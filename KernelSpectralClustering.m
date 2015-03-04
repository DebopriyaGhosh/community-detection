function [model] = KernelSpectralClustering( V, X_train,k)
%   KERNELSPECTRALCLUSTERING Executes spectral clustering algorithm
%   Data: Given a graph G = (V,E), which might not necessarily be stored in
%   the memory.
%     Inputs: Xtrain:  N x d matrix of training data
%             params:  kernel parameters (e.g., sig2)
%             k:       number of desired clusters
%          (*) Xtest:  Nt x d matrix of test data
%             mode:    0, train
%                      1,test
%   Result: The patitions of the graph G, i.e., divide graph into k
%   clusters.
%   Author: Debopriya Ghosh

% computing kernel matrix 

 NORMROWS_THR = 5e-2;  % Minimum norm allowed for the rows of the test
 N=size(X_train,2);
 


  % computing kernel matrix for train nodes
 model.Omegatrain = [ length(X_train), length(X_train)];

  for i = 1: length(X_train)
      x = V(X_train(i),:);
      
      for j = 1: length(X_train)
          y = V(X_train(j),:);
          model.Omegatrain (i,j) = dot(x,y)/(norm(x,2)*norm(y,2));
      end
  end
