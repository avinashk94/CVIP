function [rgbResult] = alignChannels(red, green, blue)
% alignChannels - Given 3 images corresponding to different channels of a
%       color image, compute the best aligned result with minimum
%       aberrations
% Args:
%   red, green, blue - each is a matrix with H rows x W columns
%       corresponding to an H x W image
% Returns:
%   rgb_output - H x W x 3 color image output, aligned as desired

%% Write code here
rgbResult = zeros([size(red),3],'uint8');

best = 0;
shift_blue = 0;
for(drg = -30:30 )
    score = ncc(red,circshift(blue,drg));
    if(score > best)
      fprintf('%i %.4f\n',drg,score);
      best = score;
      shift_blue = drg;
    end
end

best = 0;
shift_green = 0;
for(drg = -30:30 )
    score = ncc(red,circshift(green,drg));
    if(score > best)
      fprintf('%i %.4f\n',drg,score);
      best = score;
      shift_green = drg;
    end
end

rgbResult(:,:,1) = red;
rgbResult(:,:,2) = circshift(green,shift_green);
rgbResult(:,:,3) = circshift(blue,shift_blue);


end
