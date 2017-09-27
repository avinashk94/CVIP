function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses


% % TODO Implement your code here
if size(img,3) == 1
    img1 = cat(3,img,img,img);
    img = img1;
end
filterResponses = zeros(size(img,1),size(img,2),size(img,3)*size(filterBank,1));
lab = rgb2lab(img);
for i=1:1:size(filterBank,1)
    filteredImg = cat(3,imfilter(lab(:,:,1),cell2mat(filterBank(i))),imfilter(lab(:,:,2),cell2mat(filterBank(i))),imfilter(lab(:,:,3),cell2mat(filterBank(i))));
%     filteredImg(1) = imfilter(lab(:,:,1),cell2mat(filterBank(i)));
%     filteredImg(2) = imfilter(lab(:,:,2),cell2mat(filterBank(i)));
%     filteredImg(3) = imfilter(lab(:,:,3),cell2mat(filterBank(i)));

%     filterResponses(:,:,:,i) = filteredImg;

%     filterResponse(:,:,1,i) = filteredImg(:,:,1);
%     filterResponse(:,:,2,i) = filteredImg(:,:,2);
%     filterResponse(:,:,3,i) = filteredImg(:,:,3);
    filterResponses(:,:,3*(i-1)+1) = filteredImg(:,:,1);
    filterResponses(:,:,3*(i-1)+2) = filteredImg(:,:,2);
    filterResponses(:,:,3*(i-1)+3) = filteredImg(:,:,3);
end

end