function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../data/traintest.mat');

	% TODO create train_features
    dictionarySize = size(dictionary, 2);
    num_train = size(train_imagenames, 1);
    layerNum = 3;
    
    train_features = zeros(dictionarySize * (4^layerNum - 1) / 3, num_train);
    
    for i = 1: num_train
        
        % modify file names to fetch the corresponding wordMap
        name_wordMap = ['../data/', strrep(train_imagenames{i}, '.jpg', '.mat')];
        load(name_wordMap);
        
        % compute features for each training image
        train_features(:, i) = getImageFeaturesSPM(layerNum, wordMap, dictionarySize);
    end


	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end