function [D, Mu] = generateRandomData(n)
%{ 
This function generates random data
The points are drawn from two Normal Distributions with parameters (mu, sigma)
Input: 
    n: number of points in each cluster
Output: 
    D: the generated dataset [x y label]
%}
Mu = [4, 0;
    0, 4;
    -1, -3];
sigma1 = [1, 0; 0, 1];
sigma2 = [1, 0; 0, 1];
sigma3 = [1, 0; 0, 1];

rng default  % For reproducibility
D1 = mvnrnd(Mu(1,:), sigma1, n);
D2 = mvnrnd(Mu(2,:), sigma2, n);
D3 = mvnrnd(Mu(3,:), sigma3, n);
D = [D1 1*ones(n,1); D2 2*ones(n,1); D3 3*ones(n,1)];
end