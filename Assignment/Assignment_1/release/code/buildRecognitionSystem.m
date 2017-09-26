function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../data/traintest.mat');

	% TODO create train_features


	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end