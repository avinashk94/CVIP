function evaluateRecognitionSystem(numCores)

if nargin < 1
    %default to non-parallel execution
    numCores = 1;
end

% Close the pools, if any
if numCores > 1
    try
        fprintf('Closing any pools...\n');
    %     matlabpool close; 
        delete(gcp('nocreate'))
    catch ME
        disp(ME.message);
    end

    fprintf('Starting a pool of workers with %d cores\n', numCores);
    % matlabpool('local',numCores);
    parpool('local', numCores);
end

%% Load train and test data
load('../data/traintest.mat');

%% Initialize
% Initialize the confusion matrix
C = zeros(length(mapping));

% Number of test images
N_train = length(test_imagenames);

%This is a peculiarity of loading inside of a function with parfor. We need to 
%tell MATLAB that these variables exist and should be passed to worker pools.
mapping = mapping;
test_imagenames = test_imagenames;
test_labels = test_labels;

%% Calculate train features
if numCores > 1
    parfor i = 1 : N_train
        % Guess the classification of the current image
        testfile = ['../data/', test_imagenames{1, i}];
        fprintf('Guessing classification of %s\n', testfile);
        guess = find(strcmp(guessImage(testfile), mapping));

        % Update the confusion matrix
        C_temp = zeros(length(mapping));
        C_temp(test_labels(i), guess) = 1;
        C = C + C_temp;
    end
else
    for i = 1 : N_train
        % Guess the classification of the current image
        testfile = ['../data/', test_imagenames{1, i}];
        fprintf('Guessing classification of %s\n', testfile);
        guess = find(strcmp(guessImage(testfile), mapping));

        % Update the confusion matrix
        C(test_labels(i), guess) = C(test_labels(i), guess) + 1;
    end    
end

fprintf('Accuracy for classification = %0.2f%%\n', 100 * trace(C) / sum(C(:)));

fprintf('Confusion matrix: \n');
disp(C);

if numCores > 1
    %close the pool
    fprintf('Closing the pool\n');
    delete(gcp('nocreate'));
end
