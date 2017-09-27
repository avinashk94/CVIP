function buildRecognitionSystem

% Load dictionary.mat and traintest.mat files
load('dictionary.mat');
load('../dat/traintest.mat');

%% Initialize parameters
% Set the layers for SPM to 3
NumOfLayers = 3;

% Number of train images
N_train = length(train_imagenames);

% Initialize train features variable
train_features = zeros((4^NumOfLayers-1)/3 * size(dictionary, 2), N_train);

%% Calculate train features
for i = 1 : N_train
    % Load the Word Map for the current image
    wordmapfile = strrep(['../dat/', train_imagenames{1, i}], '.jpg', '.mat');
    load(wordmapfile);
    
    % Calculate the histogram (features)
    train_features(:, i) = getImageFeaturesSPM(...
        NumOfLayers, wordMap, size(dictionary, 2));
end

%% Save everything
save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');
