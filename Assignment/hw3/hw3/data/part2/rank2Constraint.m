function [ rank2_mat ] = rank2Constraint( mat )

    [U, S, V] = svd(mat);
    S(end) = 0;
    rank2_mat = U*S*V';
end