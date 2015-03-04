% reading the file and defining the format and shape of the matrix
filename = '1912.edges';
fileID = fopen('C:\Program Files\MATLAB\R2011a\bin\circles.Facebook\facebook\1912.edges','r');
formatSpec = '%d %d';
sizeA = [2 Inf];
A = fscanf(fileID, formatSpec, sizeA);
fclose(fileID);
A = A';

%creating the adjacency matrix
rows = A(:,1)+1;
cols = A(:,2)+1;

%m = max(max(rows,cols));

% X = zeros(m,m);
% for i = 1: (m)
%     X(rows(i),cols(i))= 1;
% end

%creating sparse representation of adjacency matrix
sparse_X = sparse(rows,cols,1);
X = full(sparse_X);

