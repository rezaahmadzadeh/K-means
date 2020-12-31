function Mu = maximization(X)
%{ 
This function calculates the second step of the EM algorithm for K-means.
This function updates the center of the clusters according to the updated
labels in the previous step
Input: 
    X: nx3 (number of data points , [x, y, label])
Output: 
    Mu: updated centers
%}

numClusters = max(X(:,3));

Mu = zeros(numClusters, 2);
for jj = 1:numClusters
    idx = X(:,3) == jj;
    data = X(idx, 1:2);
    Mu(jj, :) = sum(data) / size(data,1);
end
end
