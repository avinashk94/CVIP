function [ F ] = fitFundamental( matches, boolNormalize)

    x1 = cart2homo( matches(:,1:2) );
    x2 = cart2homo( matches(:,3:4) );
    
    if boolNormalize
        [transform_1, x1_norm] = normalizeCoordinates(x1);
        [transform_2, x2_norm] = normalizeCoordinates(x2);
        x1 = x1_norm;
        x2 = x2_norm;
    end
    
    u1 = x1(:,1);
    v1 = x1(:,2);
    u2 = x2(:,1);
    v2 = x2(:,2);
    
    temp = [ u2.*u1, u2.*v1, u2, v2.*u1, v2.*v1, v2, u1, v1, ones(size(matches,1), 1)];

    [~,~,V] = svd(temp);
    f_vec = V(:,end);
    
    F = reshape(f_vec, 3,3);
    F = rank2Constraint(F);
    
    if boolNormalize
        F = transform_2' * F * transform_1;
    end
end