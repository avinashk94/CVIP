function [ img1Ids, img2Ids] = featureMatch( nMatches, features1, features2)
    
    distances = dist2(features1, features2);
    [~,distance_idx] = sort(distances(:), 'ascend');
    nBest = distance_idx(1:nMatches);
    [rows, cols] = ind2sub(size(distances), nBest);
    img1Ids = rows;
    img2Ids = cols;
end