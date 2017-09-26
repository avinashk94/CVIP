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

nu = size(im,2); % input columns
nv = size(im,1); % input rows
nx = out_size(2);% output columns
ny = out_size(1);% output rows

[X Y] = meshgrid(1:nx,1:ny); 
XY = [X(:)';Y(:)';ones(numel(X),1)']; 
UV = round(A\XY); % inverse transform: P_input = inv(A) P_output
cpy = find(UV(1,:)>0 & UV(1,:) <=nu & UV(2,:)>0 & UV(2,:) <=nv);

warp_im(sub2ind([ny nx],XY(2,cpy),XY(1,cpy))) = im(sub2ind([nv nu],UV(2,cpy),UV(1,cpy)));