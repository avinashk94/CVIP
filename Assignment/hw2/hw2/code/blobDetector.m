function [outImage] = blobDetector(I)
%BLOBDETECTOR Summary of this function goes here
%   Detailed explanation goes here
[h,w] = size(I);
for i = 5:2:45
    H = fspecial('log',i);
    I_new = imfilter(I,H);
    figure;
    imshow(I_new);
end
outImage = I;
end

