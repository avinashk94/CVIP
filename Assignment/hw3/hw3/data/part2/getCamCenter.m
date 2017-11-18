function [ cameraCenter ] = getCamCenter( cameraMatrix)
    [~, ~, V] = svd(cameraMatrix);
    cameraCenter = V(:,end);
    cameraCenter = homo_2_cart(cameraCenter');
end