list = [size(X,1),2];
%list = javaArray('java.lang.Double',size(X,1),2);

for i = 1:size(X,1)
    count = 0;
    for j = 1:size(X,2)
      if( X(i,j)== 1)
          count = count +1;
      end  
    end
    list(i,1) = i;
    list(i,2) = count;
    %list(i,1) =  javaObjectEDT('java.lang.Double',i);
    %list(i,2) =  javaObjectEDT('java.lang.Double',count);
end

M = median(double(list(:,2)));
N = size(X,1);
L = double(list);
L_New = [size(L,1),2];
for i = 1: size(L,1)
     if( L(i,2) > M )
         L_New(i,:) = L(i,:);
     end
end

% Adj =  javaArray('java.lang.Double',size(X,1),size(X,2));
% Adj = X;
S  = FastAndUniqueRepresentativeSubset( list, M, X, N);

% sampleObj = javaObject('Sampling');
% double(sampleObj.FastAndUniqueRepresentativeSubset(list,Adj,N));
