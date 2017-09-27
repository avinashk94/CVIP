function h = getImageFeatures(wordMap, dictionarySize)

% Calculate the histogram
h = histcounts(wordMap, dictionarySize)';

% Normalize the histogram
h = h ./ sum(h(:));
