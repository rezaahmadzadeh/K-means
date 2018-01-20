function [Data_u, Mu_u] = k_means(Data, Mu)
%{ 
This is the main K-means algorithm. It performs two steps Expectation and
Maximization. The whole process is done in a while loop until a desired
error has reached. 
Input: 
    Data: the dataset including the points and labels [x y label]
    Mu: center of the clusters
Output: 
    Data_f: the dataset with updated labels
    Mu_f: updated centers
%}

shift = 10000;  % a big number
iter = 0;       % counter
epsilon = 0.001; % percision
formatSpec = 'iteration: %d, error: %2.4f, mu1: [%2.4f %2.4f], mu2: [%2.4f %2.4f], mu3: [%2.4f %2.4f] \n';

while shift > epsilon
    iter = iter + 1;
    
    % Expectation
    Data_u = expectation(Data, Mu);
    
    % Maximization
    Mu_u = maximization(Data_u);
    
    % calculate the error
    shift = sqrt(sum(sum((Mu - Mu_u).^2)));
    
    fprintf(formatSpec, iter, shift, Mu_u(1,:), Mu_u(2,:), Mu_u(3,:));
    
    Mu = Mu_u;
    Data = Data_u;
end