function H = fitHomography(homogenousPts1, homogenousPts2)

    [l, ~] = size(homogenousPts1);

    A = [];
    for i = 1:l
        p1 = homogenousPts1(i,:);
        p2 = homogenousPts2(i,:);
        
        A_i = [ zeros(1,3), -p1, p2(2)*p1; p1      , zeros(1,3),   -p2(1)*p1];
        A = [A; A_i];        
    end
    
    [~,~,vectors] = svd(A);
    h = vectors(:,end);
    H = reshape(h, 3, 3);
    H = H ./ H(3,3);
    
end