%% K-means Algorithm
%{
This is a test program for the K-means clustering of data.
The K-means algorithm uses Expectation-Maximization steps to converge to
the solution. At the beginning, we generate three sets of points from three
normal distributions and label them as clusters 1, 2 and 3. 
This will serve as our true value dataset.
Then we reshuffle the labels to make the dataset ready for the algorithm.
Given the number of clusters, the algorithm is going to look at the data 
and estimate paramters for three normal distributions that the data is drawn 
from. These parameters include the means of those Normal Distributions.   
In the next step, we make some initial guess and intentionally we use a bad
guess for the parameters.
The algorithm runs a simpler version of the EM algorithm that estimates
only the means not the covariances.
===================================================
Code: Reza Ahmadzadeh - IRIM 2018
===================================================
%}
clc, clear, close all

% number of points in each cluster
numPoints = 50;
numClusters = 3;

% generate random data with 3 clusters
[Data_o, Mu_o] = generateRandomData(numPoints);

% reshuffle data lables 
Data_r = [Data_o(:,1:2) randi(numClusters, numClusters*numPoints, 1)];

% initial guess for the means
Mu = [1,4;
    4,1;
    -2,-3];

% run the k-means algorithm
[Data_f, Mu_f] = k_means(Data_r, Mu);

% to compare the results with the Matlan version of k-means
[idx,Mu_m] = kmeans(Data_r(:,1:2),numClusters);

%% plot the results
figure; subplot(1,4,1);
scatter(Data_o(:,1), Data_o(:,2), 10, 'MarkerEdgeColor', [0 0.5 0.5], 'MarkerFaceColor',[0 0.7 0.7], 'LineWidth',1.5);
grid on; box on;
xlabel('x'); ylabel('y');title('raw data');

Data1 = Data_o(Data_o(:,3)==1, :);
Data2 = Data_o(Data_o(:,3)==2, :);
Data3 = Data_o(Data_o(:,3)==3, :);
subplot(1,4,2);hold on
scatter(Data1(:,1), Data1(:,2), 10, 'MarkerEdgeColor', [0.5 0 0], 'MarkerFaceColor',[0.7 0 0], 'LineWidth',1.5);
scatter(Data2(:,1), Data2(:,2), 10, 'MarkerEdgeColor', [0 0.5 0], 'MarkerFaceColor',[0 0.7 0], 'LineWidth',1.5);
scatter(Data3(:,1), Data3(:,2), 10, 'MarkerEdgeColor', [0 0 0.5], 'MarkerFaceColor',[0 0 0.7], 'LineWidth',1.5);
for ii=1:numClusters
    plot(Mu_o(ii,1), Mu_o(ii,2),'k+','Markersize',15, 'linewidth',2);
end
grid on; box on;
xlabel('x'); ylabel('y');title('true value');

Data_f1 = Data_f(Data_f(:,3)==1, :);
Data_f2 = Data_f(Data_f(:,3)==2, :);
Data_f3 = Data_f(Data_f(:,3)==3, :);
subplot(1,4,3); hold on
scatter(Data_f1(:,1), Data_f1(:,2), 10, 'MarkerEdgeColor', [0.5 0 0], 'MarkerFaceColor',[0.7 0 0], 'LineWidth',1.5);
scatter(Data_f2(:,1), Data_f2(:,2), 10, 'MarkerEdgeColor', [0 0.5 0], 'MarkerFaceColor',[0 0.7 0], 'LineWidth',1.5);
scatter(Data_f3(:,1), Data_f3(:,2), 10, 'MarkerEdgeColor', [0 0 0.5], 'MarkerFaceColor',[0 0 0.7], 'LineWidth',1.5);
for ii=1:numClusters
    plot(Mu_f(ii,1), Mu_f(ii,2),'k+','Markersize',15, 'linewidth',2);
end
grid on; box on;
xlabel('x'); ylabel('y');title('data clustered by k-means');


Data_m1 = Data_r(idx==1, :);
Data_m2 = Data_r(idx==2, :);
Data_m3 = Data_r(idx==3, :);
subplot(1,4,4); hold on
scatter(Data_m1(:,1), Data_m1(:,2), 10, 'MarkerEdgeColor', [0.5 0 0], 'MarkerFaceColor',[0.7 0 0], 'LineWidth',1.5);
scatter(Data_m2(:,1), Data_m2(:,2), 10, 'MarkerEdgeColor', [0 0.5 0], 'MarkerFaceColor',[0 0.7 0], 'LineWidth',1.5);
scatter(Data_m3(:,1), Data_m3(:,2), 10, 'MarkerEdgeColor', [0 0 0.5], 'MarkerFaceColor',[0 0 0.7], 'LineWidth',1.5);
for ii=1:numClusters
    plot(Mu_m(ii,1), Mu_m(ii,2),'k+','Markersize',15, 'linewidth',2);
end
grid on; box on;
xlabel('x'); ylabel('y');title('matlab k-means');