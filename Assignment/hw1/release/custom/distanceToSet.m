function histInter = distanceToSet(wordHist, histograms)

% Sum of minimums (Baseline implementation)
%intersections = bsxfun(@min, histograms, repmat(wordHist, 1, size(histograms, 2)));
%histInter = sum(intersections);

% Bhattacharyya coefficient
%intersections = bsxfun(@times, sqrt(histograms), repmat(sqrt(wordHist), 1, size(histograms, 2)));
%histInter = sum(intersections);

% Sum of products
%intersections = bsxfun(@times, histograms, repmat(wordHist, 1, size(histograms, 2)));
%histInter = sum(intersections);

% Sum of squared differences (Euclidean distance)
%intersections = bsxfun(@minus, histograms, repmat(wordHist, 1, size(histograms, 2)));
%histInter = sum(intersections.^2);

% Standard Euclidean
%histInter = -pdist2(histograms', wordHist', 'seuclidean');

% Chebychev distance
%histInter = -pdist2(histograms', wordHist', 'chebychev');

% Correlation
%histInter = -pdist2(histograms', wordHist', 'correlation');

% Chi-squared
%histInter = -pdist2(histograms', wordHist', @distChiSq);

% Spearman's rank correlation
histInter = -pdist2(histograms', wordHist', 'spearman');

end



%% Chi-squared function
% Downloaded from:
% http://www.mathworks.com/matlabcentral/fileexchange/29004-feature-points-in-image--keypoint-extraction/content/FPS_in_image/FPS%20in%20image/Help%20Functions/SearchingMatches/pdist2.m
function D = distChiSq( X, Y )

m = size(X,1);  n = size(Y,1);
mOnes = ones(1,m); D = zeros(m,n);
for i=1:n
  yi = Y(i,:);  yiRep = yi( mOnes, : );
  s = yiRep + X;    d = yiRep - X;
  D(:,i) = sum( d.^2 ./ (s+eps), 2 );
end
D = D/2;

end
