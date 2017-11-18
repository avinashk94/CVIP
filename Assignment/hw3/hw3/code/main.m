clear;
close all;
dirList = dir('../data/part1/uttower/*.jpg');
list = {dirList.name}';

Img1 = im2double(imread(strcat('../data/part1/uttower/',list{1})));
I1 = rgb2gray(Img1);
Img2 = im2double(imread(strcat('../data/part1/uttower/',list{2})));
I2 = rgb2gray(Img2);
[h1, w1] = size(I1);
[h2, w2] = size(I1);

C1 = corner(I1,'Harris',500);
C2 = corner(I2,'Harris',500);

% figure; %1
% imshow([Img1 Img2]);
% hold on;
% title('Detected features/corners');
% hold on;
% plot(C1(:,1),C1(:,2),'mo');
% plot(C2(:,1) + w1, C2(:,2), 'mo');

neighbourRadius = 21;

features1 = localFeatures(I1,neighbourRadius,C1);
features2 = localFeatures(I2,neighbourRadius,C2);

nMatches = 250;
[ img1Ids, img2Ids] = featureMatch(nMatches, features1, features2);

selectC1 = C1(img1Ids,:);
selectC2 = C2(img2Ids,:);

% figure; %2
% imshow([Img1 Img2]);
% hold on;
% title(['Top matched ' num2str(nMatches) ' features']);
% hold on;
% plot(selectC1(:,1), selectC1(:,2),'mo');
% plot(selectC2(:,1) + w1, selectC2(:,2), 'mo');

% figure; %3
% imshow([Img1 Img2]);
% hold on;
% title(['Mapping between top ' num2str(nMatches) ' matched features']);
% hold on; 
% plot(selectC1(:,1), selectC1(:,2),'mo');
% plot(selectC2(:,1) + w1, selectC2(:,2), 'mo');
% for i = 1:nMatches
%     plot([selectC1(i,1),selectC2(i,1) + w1],[selectC1(i,2),selectC2(i,2)]);
% end

matchingPoints1 = [selectC1(:,1), selectC1(:,2), ones(nMatches,1)];
matchingPoints2 = [selectC2(:,1), selectC2(:,2), ones(nMatches,1)];
[H, inlierIndices] = homography(matchingPoints1,matchingPoints2);

% figure;
% imshow([Img1 Img2]);
% hold on;
% title(['The matching between ' num2str(length(inlierIndices)) ' inlier matches in both images']);
% hold on; 
% plot(selectC1(inlierIndices,1), selectC1(inlierIndices,2),'mo');
% plot(selectC2(inlierIndices,1) + w1, selectC2(inlierIndices,2), 'mo');
% for i = 1:length(inlierIndices)
%     plot([selectC1(inlierIndices(i),1),selectC2(inlierIndices(i),1) + w1],[selectC1(inlierIndices(i),2),selectC2(inlierIndices(i),2)]);
% end

stitchedImg = stitchImages(Img1, Img2, H);
figure, imshow(stitchedImg);
title('Alignment by homography');


