clear;
close all;
dirList = dir('../data/*.jpg');
list = {dirList.name}';

%Initialisations
numScales = 15;
sigma = 1.4;
scale_K = 1.2;
threshold = 0.015;
ImageScale = true;


for imageIterator=1:size(list,1)
    Img1 = imread(strcat('../data/',list{imageIterator}));
    Img = im2double(Img1);
    I1 = rgb2gray(Img);


    disp('before tic');
    if ImageScale == true
        tic;
        scaleSpace = blobDetectorImg(I1, sigma, numScales, scale_K);
        toc;
    else
        tic;
        scaleSpace = blobDetector(I1, sigma, numScales, scale_K);
        toc; 
    end
    disp('after toc');

    scaleSpace3D = nonMaxSupp(scaleSpace);

    scaleSpace3DThresh = scaleSpace3D > threshold;
    scaleSpace3DPost = scaleSpace3D .* scaleSpace3DThresh;

    % showImages(scaleSpace3D);
    % showImages(scaleSpace3DPost);

    radiii = zeros(numScales,1);

    circlePoints = [];
    for i=1:numScales
        radiii(i) = sqrt(2)*sigma*scale_K^(i-1);
        [rows,cols] = find(scaleSpace3DPost(:,:,i));
        circlePoints = cat(1,circlePoints,cat(2,cols,rows,radiii(i)*ones(size(rows))));
    end

    fprintf('Printing circles \n');
    maxxi = max(max(max(scaleSpace3D)));
    disp(maxxi +'\t'+ max(max(max(scaleSpace3DPost))));
    
    
    figure;
    show_all_circles(I1,circlePoints(:,1),circlePoints(:,2),circlePoints(:,3),'r',1);
    saveas(gcf,strcat(num2str(imageIterator),'.jpg'));
end