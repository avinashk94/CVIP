clear;
close all;
dirList = dir('../data/*.jpg');
list = {dirList.name}';
Img1 = imread(strcat('../data/',list{1}));
I1 = rgb2gray(im2double(Img1));
outI = blobDetector(I1);
