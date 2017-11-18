function [cCoord] = homo_2_cart(hCoord)

    l = size(hCoord, 2) - 1;
    X = bsxfun(@rdivide,hCoord,hCoord(:,end));
    cCoord = X(:,1:l);
end