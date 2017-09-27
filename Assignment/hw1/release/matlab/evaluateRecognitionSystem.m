function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../data/traintest.mat');

    num_test = size(test_imagenames, 1);
    num_class = 8;
    conf = zeros(num_class, num_class);
    
    for i = 1: num_test
                
        img_path = ['../data/', test_imagenames{i}];
        guess_class = guessImage(img_path);
        j_guess = find(strcmp(mapping, guess_class));
        
        i_label = test_labels(i);
        conf(i_label, j_guess) = conf(i_label, j_guess) + 1; 
    
    end
    
    accuracy = trace(conf) / sum(conf(:));
    fprintf('Accuracy: %f\n', accuracy);
    
    conf
end