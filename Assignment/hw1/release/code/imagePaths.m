function [ fList ] = imagePaths()
%IMAGEPATHS Return paths of all images.
dirList = dir('../data/garden/*.jpg');
list = {dirList.name};
folder = dirList.folder;
fList = cell(length(list),1);
for i=1:length(list)
    fList{i} = fullfile(folder,list{i});
end
end