function [qtest,mqtest]=KSCmembership(etest,CB)

etest2=sign(etest);

% compute Hamming distances between the test encoding vectors and codebook
hamdists = pdist2(etest2,CB,'hamming');

% Assign to the cluster codeword with minimal Hamming distance
[ymin,qtest]=min(hamdists,[],2);
mqtest = num2cell(qtest);
 

end
