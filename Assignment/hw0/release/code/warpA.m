function [ warp_im ] = warpA( im, A, out_size )
% warp_im=warpAbilinear(im, A, out_size)
% Warps (w,h,1) image im using affine (3,3) matrix A 
% producing (out_size(1),out_size(2)) output image warp_im
% with warped  = A*input, warped spanning 1..out_size
% Uses nearest neighbor mapping.
% INPUTS:
%   im : input image
%   A : transformation matrix 
%   out_size : size the output image should be
% OUTPUTS:
%   warp_im : result of warping im by A
warp_im = zeros(out_size);
invA = inv(A);
[X,Y] = meshgrid(1:out_size(1),1:out_size(2));
oness = ones(out_size);
X_cord = round(invA(1,1).*X' + invA(1,2).*Y' + invA(1,3).*oness);
Y_cord = round(invA(2,1).*X' + invA(2,2).*Y' + invA(2,3).*oness);

% for i=1:out_size(1)
%     for j=1:out_size(2)
%         inde = invA*[i,j,1]';
%         index = round(inde);
% %         index
%         ij = A*[index(1), index(2), 1]';
% %         round(ij)
%         if 0<index(1) && index(1)<size(im,1) && 0<index(2) && index(2)<size(im,2)
%             
%             warp_im(i,j) = im(index(1), index(2));
%         else
%             warp_im(i,j) = 0;
%         end
%     end
% end


