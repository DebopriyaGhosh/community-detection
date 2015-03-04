function [C,qtrain,mqtrain,alphaCenters] = KSCcodebook(etrain,alpha)

  % constructing the code book, by binarizing the projected vector matrix
  % obtained from training data. The code book is obtained by selecting top
  % k most frequent codebook vectors
  
  [N,d]=size(etrain);
  k=d+1;
  
  betabin=sign(etrain);
  [C,m,uniquecw]=unique(betabin,'rows');
  
  cwsizes = zeros(length(m),1);
  for i=1:length(m)
      cwsizes(i) = sum(uniquecw==i);
  end;
  
  [temp,j]=sort(cwsizes,'descend');
  
  if length(m)<k
      k = length(m);
  end;


  C = C(j(1:k),:);
  qtrain=zeros(N,1);
  for i=1:k
      qtrain(uniquecw==j(i))=i;
  end;
  find_groups = [alpha qtrain];
  alphaCenters=0;
  
   [qtrain,mqtrain] =  KSCmembership(etrain,C);

end
    
