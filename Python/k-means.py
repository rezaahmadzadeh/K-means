import numpy as np
import random as rand
import matplotlib.pyplot as plt


# set a random seed
rand.seed(33)
# ------------------------------------------------
# Generate our true value for this test
# ------------------------------------------------
nPointsC = 50  # number of points in each cluster

# means
mu1 = np.array([4, 0], dtype = np.float64)
mu2 = np.array([0, 4], dtype = np.float64)
mu3 = np.array([-3, 3], dtype = np.float64)
# covariances
sigma1 = np.array([[1, 0], [0, 1]], dtype = np.float64)
sigma2 = np.array([[2, 0], [0, 1]], dtype = np.float64)
sigma3 = np.array([[0.5, 0], [0, 4]], dtype = np.float64)
# using Normal distribution PDF
D1 = np.random.multivariate_normal(mu1, sigma1, nPointsC)
D2 = np.random.multivariate_normal(mu2, sigma2, nPointsC)
D3 = np.random.multivariate_normal(mu3, sigma3, nPointsC)
Data = np.concatenate((D1, D2), axis = 0)
Data = np.concatenate((Data, D3), axis = 0)
# make labels
L1 = np.ones((nPointsC,1), dtype = np.int8)
L2 = 2*L1
L3 = 3*L1
L = np.concatenate((L1, L2), axis = 0)
L = np.concatenate((L, L3), axis = 0)
# concatente all the data in one matrix
Data = np.concatenate((Data, L), axis = 1)
print 'the generated dataset has size: '
print Data.shape
fig = plt.figure()
plt.scatter(Data[:,0], Data[:,1], 24, c = Data[:,2])
plt.show()
#fig.savefig('true_value.png')
# ------------------------------------------------


# ------------------------------------------------
# functions
# ------------------------------------------------
def distance(x, mu):
    ''' this function calculates the Euclidean distance
    between a point and a given mean'''
    return (np.sum((x - mu)**2) ** 0.5)


def getShift(mu_, mu):
    ''' this function calculates the error between
    the current and previous means'''
    return (np.sum((np.sum(mu,axis=0) - np.sum(mu_,axis=0))**2))** 0.5


def expectation(Data, Mu):
    ''' this function is the first step of the algorithm
    the first step of the algorithm, Expectation, updates the labels
    according to the distance between each point and the current mean locations'''
    numPoints, numClusters = Data.shape
    dist_from_clusters = np.array([100,100,100], dtype = np.float64)
    # updating data labels based on distance
    for p in range(numPoints):
        for k in range(numClusters):
            dist_from_clusters[k] = distance(Data[p, 0:1], Mu[k,:])
            #print dist_from_clusters
        if (k == np.argmin(dist_from_clusters)):
            Data[p,2] = k+1
            
    return Data


def maximization(Data):
    ''' this function is the second step of the algorithm
    the second step of the algorithm, Minimzation, updates the means
    according to the updated labels from the previous step'''

    numPoints, numClusters = Data.shape
    Mu = np.empty([numClusters,2], dtype = np.float64)
    # updating means based on data        
    for k in range(numClusters):
        data = Data_[Data[:,2] == k+1]
        m = np.array([np.sum(data[:,0]), np.sum(data[:,1])])
        m = m / len(data)
        Mu[k,:] = m

    return Mu



# ------------------------------------------------
# K-Means
# ------------------------------------------------
Data_ = Data.copy()

# reshuffle the labels or start with no labels
Data_[:,2] = np.random.choice(2, len(Data))+1

numPoints, numClusters = Data.shape

# make initial guess
Mu = np.array([[0, 0], [2, 2], [-1, -1]], dtype = np.float64)

epsilon = 0.0001  # the percision we want to reach
iters = 0       # counter
shift = 10000.0   # initial error (a big number)

# the main loop
while shift > epsilon:
    iters += 1

    # Expectation
    Data_u = expectation(Data.copy(), Mu)

    # Minimization
    Mu_u = maximization(Data_u)

    # calculate the error
    shift = getShift(Mu, Mu_u)
    
    Mu = Mu_u
    Data = Data_u

    print("iteration {}, shift{}".format(iters,shift))


# plot the result

fig2 = plt.figure()
plt.scatter(Data_u[:,0], Data_u[:,1], 24, c = Data_u[:,2])
plt.show()
#fig2.savefig('final.png')

