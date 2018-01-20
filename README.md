# K-means Clustering
This is a simple implementation of K-means algorithm in MATLAB and Python

K-means clustering is a method of vector quantization, originally from signal processing, that is popular for cluster analysis in data mining. k-means clustering aims to partition n observations into k clusters in which each observation belongs to the cluster with the nearest mean, serving as a prototype of the cluster. This results in a partitioning of the data space into Voronoi cells.
The code implements the K-means algorithm and tests it on a simple 2D dataset. 

## Example ##

In this example, we first generate a dataset of points from three Normal distributions and label the dataset. This dataset with correct labels are our true values. Then we reshuffle the labels and run the k-means algorithm for the new dataset. The algorithm clusters the dataset correctly and also estimates the centers of the clusters. At the last step, we compare our result with that of k-means implemented by Mathworks.

![testing K-means algorithm](https://github.com/rezaahmadzadeh/K-means/blob/master/result/result.png?raw=true "K-means")

## Result ##

The result that I get on my machine is as follows:

```
iteration: 1, error: 1.8122, mu1: [-0.2165 4.0360], mu2: [4.2571 0.0152], mu3: [-1.1291 -3.0925] 
iteration: 2, error: 0.0906, mu1: [-0.2165 4.0360], mu2: [4.3211 0.0316], mu3: [-1.0863 -3.0476] 
iteration: 3, error: 0.0000, mu1: [-0.2165 4.0360], mu2: [4.3211 0.0316], mu3: [-1.0863 -3.0476] 
```

### Version ###
*  1.0

### How do I get set up? ###

#### MATLAB ####
* The algorithm is coded in MATLAB and Python
* No extra Toolbox is required. In order to compare the results with the MATLAB internal kmeans function you need Statistics and Machine Learning Toolbox  
* clone the repository, 
* In Matlab, set the `Matlab` folder as the current path and run the `test_kmeans.m` file.
* In Python, run `python k-means.py`
