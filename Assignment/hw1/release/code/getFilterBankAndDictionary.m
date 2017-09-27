function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

filterBank  = createFilterBank();
% TODO Implement your code here

alpha = 200;
K = 256;
T = length(imPaths);
filter_Responses = zeros(alpha*T,length(filterBank)*3);

for i=1:1:T
    fprintf('image %d out of %d\n', i, T);
    I = imread(imPaths{1});
    
    if size(I,3) == 1
        I = cat(3,I,I,I);
    end
    
    filterRes = extractFilterResponses(I,filterBank);
    
    pixels = randperm(size(filterRes,1)*size(filterRes,2),alpha);
    filterRes = reshape(filterRes, [], size(filterRes, 3));
    filter_Responses((alpha * (i - 1) + 1): (alpha * i), :) = filterRes(pixels, :);
end

[~, dictionary] = kmeans(filter_Responses, K, 'EmptyAction', 'drop');

dictionary = dictionary';
end