function [histo] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    % TODO Implement your code here
    L = layerNum - 1;
    histo = zeros(dictionarySize, (4^layerNum - 1) / 3);
    h_counter = 0;
    
    mapping = zeros(2^L, 2^L);
    
    for l = L: -1: 0
        split = 2^l;
        cellSize = floor(size(wordMap) / split);
        
        if l == 0
            weight = 2^(-L);
        else
            weight = 2^(l - L - 1);
        end
        
        for i = 1: split
            for j = 1: split
                h_counter = h_counter + 1;
                histogram_array = zeros(dictionarySize, 1);
                if l == L
                   row_start = 1 + cellSize(1) * (i - 1);
                   row_end = cellSize(1) * i;
                   col_start = 1 + cellSize(2) * (j - 1);
                   col_end = cellSize(2) * j;
                   grid = wordMap(row_start: row_end, col_start: col_end);
                   histogram_array = getImageFeatures(grid, dictionarySize); 
                else 
                   for x = i * 2 - 1: i * 2
                       for y = j * 2 - 1: j * 2                           
                           histogram_array = histogram_array + histo(:, mapping(x, y));
                       end 
                   end
                end
                histo(:, h_counter) = weight .* histogram_array;
                mapping(i, j) = h_counter;  
            end
        end
        mapping = mapping(1: split, 1: split);
    end
    
    histo = reshape((histo./sum(histo(:))), [], 1);

end