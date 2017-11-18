function [ F, inlierIndices ] = estimateFundamental( matches)


    nIterations = 200;
    subsetSize = 8;
    inlierDistanceThreshold = 35;
    minInlierRatio = 20/size(matches,1);

    [F, inlierIndices] = ransac(nIterations, subsetSize, inlierDistanceThreshold, minInlierRatio, matches);
    
    disp('Number of inliers:');
    disp(length(inlierIndices));
    disp('Mean Residual of Inliers is:');
    display(mean(calcResiduals(F,matches(inlierIndices,:))));
end