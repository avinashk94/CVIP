function [histo] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    % TODO Implement your code here
    [h,w] = size(wordMap);
    L = layerNum - 1;
    histo = zeros(dictionarySize, (4^(L + 1) - 1) / 3);
    dim_h = 1;
    
    mapping = zeros(2^L, 2^L);
    
    for l = L: -1: 0
        num_split = 2^l;
        len_hSplit = floor(h / num_split);
        len_wSplit = floor(w / num_split);
        
        if l == 0
            weight = 2^(-L);
        else
            weight = 2^(l - L - 1);
        end
        
        for i = 1: num_split
            for j = 1: num_split
                hist_grid = zeros(dictionarySize, 1);
                if l == L
                   row_head = 1 + len_hSplit * (i - 1);
                   row_tail = len_hSplit * i;
                   col_head = 1 + len_wSplit * (j - 1);
                   col_tail = len_wSplit * j;
                   grid = wordMap(row_head: row_tail, col_head: col_tail);
                   hist_grid = getImageFeatures(grid, dictionarySize);
                   
                else 
                   for x = i * 2 - 1: i * 2
                       for y = j * 2 - 1: j * 2                           
                           hist_grid = hist_grid + histo(:, mapping(x, y));
                       end 
                   end
                end
                histo(:, dim_h) = weight .* hist_grid;
                mapping(i, j) = dim_h;
                dim_h = dim_h + 1;
                
            end
        end
        mapping = mapping(1: num_split, 1: num_split);
    end
    
    histo = reshape((histo./sum(histo(:))), [], 1);

end