function [ dist ] = findCluster( Data )
%Finds the cluster on basis of similarity of profile attributes.
% Input: The FeatureMatrix
% Output: Vector containing the hamming distance of each node
% from the basis vector
% Author: Debopriya Ghosh 
X = Data(1,:);

dist =[];
dist(1) = 0;
for i = 2: size(Data,1)
Y = Data(i,:);
dist(i) = pdist2(X, Y,'Hamming');
end
end
