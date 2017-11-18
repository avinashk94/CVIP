function residuals = calcResiduals(F, matches)

    nMatches = size(matches,1);
    L = (F * [matches(:,1:2) ones(nMatches,1)]')'; 
    L = L ./ repmat(sqrt(L(:,1).^2 + L(:,2).^2), 1, 3);
    dist = sum(L .* [matches(:,3:4) ones(nMatches,1)],2);
    
    residuals = abs(dist);
end