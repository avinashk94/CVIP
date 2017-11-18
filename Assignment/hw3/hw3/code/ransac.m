function [ bestFitModel, inlierIndices ] = ransac(iterations, subsetSize, inlierDistanceThreshold, minInlierRatio, x, y)

[n, ~] = size(x);
nInliers = zeros(iterations,1);
allModels = {};

for i = 1 :iterations
    
    subIndices = randsample(n, subsetSize);
    x_subset = x(subIndices, :);
    y_subset = y(subIndices, :);
    
    model = fitHomography(x_subset, y_subset);
    
    residualErrors = calcResiduals(model, x, y);
    
    inlierIndices = find(residualErrors < inlierDistanceThreshold);
    
    nInliers(i) = length(inlierIndices);
    
    currentInlierRatio = nInliers(i)/n;
    if currentInlierRatio >=  minInlierRatio
        x_inliers = x(inlierIndices, :);
        y_inliers = y(inlierIndices, :);
        allModels{i} = fitHomography(x_inliers, y_inliers);
    end
end

bestIteration = find(nInliers == max(nInliers));
bestIteration = bestIteration(1);
bestFitModel = allModels{bestIteration};

residualErrors = calcResiduals(bestFitModel, x, y);
inlierIndices = find(residualErrors < inlierDistanceThreshold);
end