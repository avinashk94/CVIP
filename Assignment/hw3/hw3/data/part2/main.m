clear;
close all;
I1 = rgb2gray(imread('house1.jpg'));
I2 = rgb2gray(imread('house2.jpg'));
matches = load('house_matches.txt'); 
normalize = true;

N = size(matches,1);

% figure;
% imshow([I1 I2]); hold on;
% plot(matches(:,1), matches(:,2), '+r');
% plot(matches(:,3)+size(I1,2), matches(:,4), '+r');
% line([matches(:,1) matches(:,3) + size(I1,2)]', matches(:,[2 4])', 'Color', 'r');


% first, fit fundamental matrix to the matches
F = fitFundamental(matches, normalize); % this is a function that you should write
L = (F * [matches(:,1:2) ones(N,1)]')'; % transform points from 
% the first image to get epipolar lines in the second image

% find points on epipolar lines L closest to matches(:,3:4)
L = L ./ repmat(sqrt(L(:,1).^2 + L(:,2).^2), 1, 3); % rescale the line
pt_line_dist = sum(L .* [matches(:,3:4) ones(N,1)],2);
closest_pt = matches(:,3:4) - L(:,1:2) .* repmat(pt_line_dist, 1, 2);

% find endpoints of segment on epipolar line (for display purposes)
pt1 = closest_pt - [L(:,2) -L(:,1)] * 10; % offset from the closest point is 10 pixels
pt2 = closest_pt + [L(:,2) -L(:,1)] * 10;

% display points and segments of corresponding epipolar lines
% figure;
% imshow(I2); hold on;
% plot(matches(:,3), matches(:,4), '+r');
% line([matches(:,3) closest_pt(:,1)]', [matches(:,4) closest_pt(:,2)]', 'Color', 'r');
% line([pt1(:,1) pt2(:,1)]', [pt1(:,2) pt2(:,2)]', 'Color', 'g');


[h1, w1] = size(I1);
[h2, w2] = size(I1);

C1 = corner(I1,'Harris',500);
C2 = corner(I2,'Harris',500);

% figure; %1
% imshow([I1 I2]);
% hold on;
% title('Detected features/corners');
% hold on;
% plot(C1(:,1),C1(:,2),'mo');
% plot(C2(:,1) + w1, C2(:,2), 'mo');

neighbourRadius = 21;

features1 = localFeatures(I1,neighbourRadius,C1);
features2 = localFeatures(I2,neighbourRadius,C2);

nMatches = 300;
[ img1Ids, img2Ids] = featureMatch(nMatches, features1, features2);

selectC1 = C1(img1Ids,:);
selectC2 = C2(img2Ids,:);

% figure; %2
% imshow([I1 I2]);
% hold on;
% title(['Top matched ' num2str(nMatches) ' features']);
% hold on;
% plot(selectC1(:,1), selectC1(:,2),'mo');
% plot(selectC2(:,1) + w1, selectC2(:,2), 'mo');

% figure; %3
% imshow([I1 I2]);
% hold on;
% title(['Mapping between top ' num2str(nMatches) ' matched features']);
% hold on; 
% plot(selectC1(:,1), selectC1(:,2),'mo');
% plot(selectC2(:,1) + w1, selectC2(:,2), 'mo');
% for i = 1:nMatches
%     plot([selectC1(i,1),selectC2(i,1) + w1],[selectC1(i,2),selectC2(i,2)]);
% end

F = estimateFundamental( [selectC1 selectC2]);


camMatrix1 = load('house1_camera.txt');
camCenter1 = getCamCenter(camMatrix1);

camMatrix2 = load('house2_camera.txt');
camCenter2 = getCamCenter(camMatrix2);

%homogenize the coordinates
x1 = cart2homo(matches(:,1:2));
x2 = cart2homo(matches(:,3:4));
numMatches = size(x1,1);
triangPoints = zeros(numMatches, 3);
projPointsImg1 = zeros(numMatches, 2);
projPointsImg2 = zeros(numMatches, 2);


for i = 1:numMatches
    pt1 = x1(i,:);
    pt2 = x2(i,:);
    crossProductMat1 = [  0   -pt1(3)  pt1(2); pt1(3)   0   -pt1(1); -pt1(2)  pt1(1)   0  ];
    crossProductMat2 = [  0   -pt2(3)  pt2(2); pt2(3)   0   -pt2(1); -pt2(2)  pt2(1)   0  ];    
    Eqns = [ crossProductMat1*camMatrix1; crossProductMat2*camMatrix2 ];
    
    [~,~,V] = svd(Eqns);
    triangPointHomo = V(:,end)';
    triangPoints(i,:) = homo_2_cart(triangPointHomo);
    
    projPointsImg1(i,:) = homo_2_cart((camMatrix1 * triangPointHomo')');
    projPointsImg2(i,:) = homo_2_cart((camMatrix2 * triangPointHomo')');
    
end


plot_triangulation(triangPoints, camCenter1, camCenter2);

distances1 = diag(dist2(matches(:,1:2), projPointsImg1));
distances2 = diag(dist2(matches(:,3:4), projPointsImg2));
display(['Mean Residual 1: ', num2str(mean(distances1))]);
display(['Mean Residual 2: ', num2str(mean(distances2))]);