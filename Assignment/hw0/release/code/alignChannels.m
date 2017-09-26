function [rgbResult, scores1, scores2] = alignChannels(red, green, blue)
% alignChannels - Given 3 images corresponding to different channels of a
%       color image, compute the best aligned result with minimum
%       aberrations
% Args:
%   red, green, blue - each is a matrix with H rows x W columns
%       corresponding to an H x W image
% Returns:
%   rgb_output - H x W x 3 color image output, aligned as desired

%% Write code here

% d = sum(sum((red-blue).^2))
% scores1 = zeros(61,2);
for i = -30:1:30
    for j =-30:1:30
        redShift = circshift(red,[i j]);
        scores1(i+31,j+31) = [sum(sum((redShift-blue).^2))];
        
    end
end

for i = -30:1:30
    for j =-30:1:30
        greenShift = circshift(green,[i j]);
        scores2(i+31,j+31) = [sum(sum((greenShift-blue).^2))];
        
    end
end
[r1,r2] = find(scores1 == min(min(scores1)));
[g1,g2] = find(scores2 == min(min(scores2)));
r1,r2,g1,g2
red = circshift(red,[r1-31 r2-31]);
green = circshift(green,[g1-31 g2-31]);
% blue = circshift(blue,[g1-31 g2-31]);
% rgbResult = zeros([size(red),3]);
rgbResult = cat(3, red, green, blue);
end
