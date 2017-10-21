function showImages(scaleSpace)
%SHOWIMAGES Summary of this function goes here

for i=1:size(scaleSpace,3)
    figure;
    imshow(scaleSpace(:,:,i),'InitialMagnification',250);
end
end

