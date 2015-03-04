function [ out,qtest,mqtest] = KSC_test (V, X_train,X_test,k)
%    KSC_test executes spectral clustering on the test data
%    Parameters: 
%      V , adjacency_matrix
%      X_train, training_data indices
%      X_test, test_data indices
%      K, optimum clusters
      Nt=size(X_test,2);
      [ model]=KernelSpectralClustering( V, X_train,k);
      
      %computing kernel matrix for test nodes
       out.Omegatest = [ length(X_test), length(X_train)];

       for i = 1: length(X_test)
           x = V(X_test(i),:);
       
          for j = 1: length(X_train)
              y = V(X_train(j),:);
              out.Omegatest (i,j) = dot(x,y)/(norm(x,2)*norm(y,2));
          end
       end 
 
      out.Omegatest(isnan(out.Omegatest )) = 0;
      Omegatest_sparse = sparse(out.Omegatest );
      out.etest=out.Omegatest*model.alpha+repmat(model.b,Nt,1);
      
      % finding the clustermembership of the nodes
      [qtest,mqtest]=KSCmembership(out.etest,model.CB);
end
