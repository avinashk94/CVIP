function [filterBank, dictionary] = getFilterBankAndDictionary(image_names)

% Initialize filter bank
filterBank = createFilterBank();

% Number of chosen pixels for filter responces per layer
alpha = 150;

% Initialize the output matrix
allResponses = zeros(length(image_names), length(filterBank) * 3);

%% Read the images
for i = 1:length(image_names)
    fprintf('Calculating filter responses for %s\n', image_names{i});
    
    % Read image and repeat it across all layers if it is grayscale
    I = imread(image_names{i});
    if size(I, 3) == 1
        I = repmat(I, 1, 1, 3);
    end
    
    % Calculate filter responces for the current image
    currentResponses = extractFilterResponses(I, filterBank);
    
    % Calculate SURF Feature points and select strongests
    points = detectSURFFeatures(rgb2gray(I));
    xys = round(points.selectStrongest(ceil(alpha/4)).Location);
    inds = (xys(:,1)-1)*size(I, 1) + xys(:,2);

    % Calculate random remaining indices
    inds2 = randperm(size(currentResponses, 1), alpha-length(inds));

    % Save indices of points
    indices = [inds; inds2'];
    
    %indices = randperm(size(currentResponses, 1), alpha);
    allResponses((i*alpha-alpha+1):(i*alpha), :) = currentResponses(indices, :);
end

% Perform K-Means
K = 150;
[~, dictionary] = kmeans(allResponses, K, 'EmptyAction', 'drop');

dictionary = dictionary';

end