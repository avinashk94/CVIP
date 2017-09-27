function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    % TODO Implement your code here
    [h,w,~] = size(img);
    
    wordMap = zeros(h,w);
    if size(img,3) == 1
        img = cat(3,img,img,img);
    end
    
    filterRes = extractFilterResponses(img,filterBank);
    filterRes = reshape(filterRes, [], size(filterRes, 3));
    
    dis = pdist2(filterRes, dictionary', 'euclidean');
    [~, wordMap] = min(dis, [], 2);
    
    wordMap = reshape(wordMap, h, w);
end