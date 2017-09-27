function wordMap = getVisualWords(I, filterBank, dictionary)

% Repeat the image across all 3 layers if it is grayscale
if size(I, 3) == 1
    I = repmat(I, 1, 1, 3);
end

% Calculate filter responses for the current image
responses = extractFilterResponses(I, filterBank);

% Calculate all distances for current image pixels and dictionary items
distances = pdist2(responses, dictionary');

% Calculate nearest visual word for each pixel
[~, wordMap] = min(distances, [], 2);

% Reshape the wordMap to image dimensions
wordMap = reshape(wordMap, [size(I,1), size(I,2)]);

end
