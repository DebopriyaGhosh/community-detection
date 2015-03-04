function [ S ] = FastAndUniqueRepresentativeSubset( L, M, A, N)
% Selects subset of nodes that approximately maximizes the coverage of the
% graph under the constraint that the selected nodes belong to different
% regions of the graph.
% PARAMETERS:
%   L = (V,f(V)), list of nodes with their corresponding degree.
%   M = Median degree of the graph
%   A = Adjacency Matrix containing information about neighbors Nbr(Vi),
%   ? Vi € V
%   N = number of nodes in the network
% RESULT:
%   S,subset of nodes of the given graph G = (V,E) whose cardinality is Ns


% Author: Debopriya Ghosh ( debopriya_ghosh@baylor.edu )

 L_New = [size(L,1),2];

 for i = 1: size(L,1)
     if( L(i,2) > M )
         L_New(i,:) = L(i,:);
     end
 end

 L_New( ~any(L_New,2), : ) = [];
 
 L_New = sortrows(L_New,-2);
 Ns = .15* N;
 if(Ns > size(L_New,1))
     Ns = size(L_New,1);
 end
 S = [];
 L_Deactive = [size(L_New,1),2];
 k = 1;
 %S = [];
 
 %t = cputime;
 while(size(S) < Ns)
      
     
     % Reactivation
     if( isempty(L_New))
     L_New = L_Deactive;
     L_New = sortrows(L_New,-2);
    
     end
     % Hub selection
     v1 = L_New(1,1); % pop out the highest degree node
     %L_New(1,2) = [];
     S(k) = v1;   % add to the output set
     k = k+1;
     Nb = find(A(v1,:)); % Neighboring nodes of v1 
     L_New(1,:) = [];
     L_New = sortrows(L_New,-2);
     %Nb = A(v1,ind);  
     
     %Deactivation
     %p = 0;
     for j = 1: size(Nb,2)
        if(~ismember(Nb(1,j),L_Deactive(:,1)))
   % L_Deactive(j,1) = L(Nb(1,j),1);
   % L_Deactive(j,2) = L(Nb(1,j),2);
    L_Deactive = L(L(:,1)== Nb(1,j),:);
     %L_Deactive(:,2) = L(L(:,1)== Nb(1,j),2);
    %L_New(L_New(:,1)== Nb(1,j),:)= [];
        end
     end
 
 end
 %e = cputime-t;
 %print(e);
end 
