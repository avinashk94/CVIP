% Problem 1: Image Alignment

%% 1. Load images (all 3 channels)
parent = fileparts(pwd);
data = strcat(parent,'/data/');
load(strcat(data,'red.mat'));
load(strcat(data,'blue.mat'));
load(strcat(data,'green.mat'));
% red = load(strcat(parent,'red.mat'));  % Red channel
% green = load(parent+'green.mat');  % Green channel
% blue = load(parent+'blue.mat');  % Blue channel

%% 2. Find best alignment
% Hint: Lookup the 'circshift' function

[rgbResult, scores1, scores2] = alignChannels(red, green, blue);
close all;
figure;
imshow(rgbResult);
%% 3. Save result to rgb_output.jpg (IN THE "results" folder)

imwrite(rgbResult,strcat(parent,'/results/rgb_output.jpg'));