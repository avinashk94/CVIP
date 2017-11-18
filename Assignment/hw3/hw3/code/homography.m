function [ H, inlierIndices ] = homography( matchingPoints1, matchingPoints2 )


    nIterations = 150;
    subsetSize = 4;
    inlierDistanceThreshold = 10;
    minInlierRatio = .3;

    [H, inlierIndices] = ransac(nIterations, subsetSize, inlierDistanceThreshold, minInlierRatio, matchingPoints1, matchingPoints2);
    
    disp('Number of inliers:');
    disp(length(inlierIndices));
    disp('Average residual for the inliers:')
    disp(mean(calcResiduals(H, matchingPoints1(inlierIndices,:), matchingPoints2(inlierIndices,:))));
end