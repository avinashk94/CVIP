function h = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)

% Initialize output
h = zeros((4^layerNum-1)/3, dictionarySize);

% A variable to keep the total number of the histograms calculated
histCounter = 0;

% Define a temporary matrix to keep the histogram number for the next
% level to facilitate calculation
histTemp = zeros(2 ^ (layerNum-1), 2 ^ (layerNum-1));

for l = layerNum-1 : -1 : 0
    
    % Calculate cell properties
    numOfCells = 2 ^ l;
    cellSize = floor(size(wordMap) / numOfCells);
    
    % Calculate histograms of the cells
    for i = 1 : numOfCells
        for j = 1 : numOfCells
            
            % Increment the histogram counter
            histCounter = histCounter + 1;
            
            % Calculate the histogram for the finest layer
            if l == layerNum-1

                % Isolate a single cell
                cell = wordMap(...
                    ((i-1)*cellSize(1)+1) : (i*cellSize(1)), ...
                    ((j-1)*cellSize(2)+1) : (j*cellSize(2)));

                h(histCounter, :) = getImageFeatures(cell, dictionarySize) / 2;
                
            % Calculate the histogram for the coarser layers
            else
                h(histCounter, :) = ...
                    h(histTemp(i*2-1, j*2-1), :) + ...
                    h(histTemp(i*2, j*2-1), :) + ...
                    h(histTemp(i*2-1, j*2), :) + ...
                    h(histTemp(i*2, j*2), :);
                
                % Multiply by the correct weight
                if l ~= 0
                    h(histCounter, :) = h(histCounter, :) / 2;
                end
            end
            
            % Remember the histogram number for our i and j
            histTemp(i, j) = histCounter;
        end
    end
end

% Convert the histogram matrix to a column vector and L1 normalize it
h = h(:) / sum(h(:));
