function Q_cart = homo_2_cart(Q_homo)


    dimension = size(Q_homo, 2) - 1;
    normCoord = bsxfun(@rdivide,Q_homo,Q_homo(:,end));
    Q_cart = normCoord(:,1:dimension);
end