function [ bestFitModel, inlierIndices ] = ransac(iterations, subsetSize, inlierDistanceThreshold, minInlierRatio, matches)

[n, ~] = size(matches);
nInliers = zeros(iterations,1);
allModels = {};

for i = 1 :iterations
    
    subIndices = randsample(n, subsetSize);
    matches_subset = matches(subIndices, :);
 
    
    model = fitFundamental(matches_subset, true);
    
    residualErrors = calcResiduals(model, matches);
    
    inlierIndices = find(residualErrors < inlierDistanceThreshold);
    
    nInliers(i) = length(inlierIndices);
    
    currentInlierRatio = nInliers(i)/n;
    if currentInlierRatio >=  minInlierRatio
        matches_inliers = matches(inlierIndices, :);
        allModels{i} = fitFundamental(matches_inliers, true);
    end
end

bestIteration = find(nInliers == max(nInliers));
bestIteration = bestIteration(1);
bestFitModel = allModels{bestIteration};

residualErrors = calcResiduals(bestFitModel, matches);
inlierIndices = find(residualErrors < inlierDistanceThreshold);
end