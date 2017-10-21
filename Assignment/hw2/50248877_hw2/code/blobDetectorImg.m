function [scaleSpace] = blobDetectorImg(I, sigma, numScales, scale_k)

[h,w] = size(I);
scaleSpace = zeros(h,w,numScales);
filterSize = 2*ceil(3*sigma)+1;
H = fspecial('log',filterSize,sigma);
H = sigma.^2 * H;
for i = 1:numScales
    downScaledImage = imresize(I, 1/(scale_k^(i-1)),'bicubic');
    I_new = imfilter(downScaledImage,H,'same','replicate');
    I_new = I_new.^2;
    upScaledImage = imresize(I_new, [h,w], 'bicubic');
    
%     domain = ones(3,3);
%     upScaledImage2D = ordfilt2(upScaledImage, 3*3, domain);
    
    scaleSpace(:,:,i) = upScaledImage;
%     scaleSpace_2D(:,:,i) = upScaledImage2D;
end
end