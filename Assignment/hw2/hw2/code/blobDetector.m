function [scaleSpace] = blobDetector(I, sigma, numScales, scale_k)
%BLOBDETECTOR Summary of this function goes here
%   Detailed explanation goes here
[h,w] = size(I);
scaleSpace = zeros(h,w,numScales);
% scaleSpace_2D = zeros(h,w,numScales);
for i = 1:numScales
    sigmaNew = sigma*scale_k^(i-1);
    filterSize = 2*ceil(3*sigmaNew)+1;
%     filterSize = max(1,fix(6*sigmaNew)+1);
    H = fspecial('log',filterSize,sigmaNew);
    H = sigmaNew.^2 * H;
    I_new = imfilter(I,H,'same','replicate');
    I_new = I_new.^2;
%     domain = ones(3,3);
%     I_new_2D = ordfilt2(I_new, 3*3, domain);

    scaleSpace(:,:,i) = I_new;
%     scaleSpace_2D(:,:,i) = I_new_2D;
end
end

