function X = expectation(X, Mu)
%{ 
This function calculates the first step of the EM algorithm for K-means.
This function associates the closest point to each center to its cluster.
Input: 
    X : nx3 (number of data points , [x, y, label])
    Mu: 3x2
Output: 
    X: the dataset with updated labels
%}

[numPoints, ~] = size(X);
numClusters = max(X(:,3));

% define a function to calculate the distance between a set of points and a
% mean
calcDistance = @(x,y) (sum((x - repmat(y, size(x,1), 1)).^2 , 2)).^0.5;
% shift = sqrt(sum(sum((Mu - Mu_u).^2)));
DV = zeros(numPoints, numClusters);
for jj = 1:numClusters
    DV(:, jj) = calcDistance(X(:,1:2), Mu(jj,:));
end
[~, Idx] = min(DV, [], 2);
X(:,3) = Idx;
end
    