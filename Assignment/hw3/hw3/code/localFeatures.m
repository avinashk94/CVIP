function [ features ] = localFeatures(img, r, centers )

    n = size(centers,1);
    features = zeros(n, (2*r + 1)*(2*r + 1));

    padd = zeros(2*r + 1); 
    padd(r + 1, r + 1) = 1;

    Img2 = imfilter(img, padd, 'replicate', 'full');

    for i=1:n
        rows = centers(i,2) : centers(i,2) + 2*r;
        cols = centers(i,1) : centers(i,1) + 2*r;

        neighbours = Img2(rows, cols);
        flattenedFeatures = neighbours(:);
        features(i,:) = flattenedFeatures;
    end
    features = zscore(features')';
end