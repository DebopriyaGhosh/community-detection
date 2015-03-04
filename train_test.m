% construct the training and test set
% Author : Debopriya Ghosh


X_train = [];
X_train = S;

X_test = [];
temp = list(:,1);
temp = temp';

Rest =  setdiff(temp,X_train);

% temp = X;
% temp(X_train,:) = [];
% temp(:,X_train) =[];
% [i,j] = find(temp);

li_test = [length(Rest),2];
%li_test = javaArray('java.lang.Double',length(Rest),2);
% for i = 1:size(temp,1)
%     count = 0;
%     for j = 1:size(temp,2)
%       if( temp(i,j)== 1)
%           count = count +1;
%       end  
%     end
%     li_test(i,1) = i;
%     li_test(i,2) = count;
% end
ind = 1;
for i = 1: size(Rest,2)
   for j = 1: size(list,1)
       if(list(j,1) == Rest(1,i))
           li_test(ind,:)= list(j,:);
           ind = ind+1;
       end
   end
end

Mt = median(li_test(:,2));
Nt = size(li_test,1);


St  = FastAndUniqueRepresentativeSubset( li_test, Mt, X, Nt);
%X_test = randsample(Rest,length(X_train));

X_test = St;
%M_test = median(Rest(:,2));
%N = size(temp,1);


%S  = FastAndUniqueRepresentativeSubset( list, M, temp, N);


%% Performing training and validation step of KSC
% disp('Tuning of the number of clusters');

maxk = 40;
tic
[model]=KernelSpectralClustering( X, X_train,maxk);
toc
%[qtrain,mqtrain]=KSCmembership(model.etrain,CB);
%collinearity = CosineSim(model.etrain,qtrain);

%[Y, I]= max(collinearity);

%optimumK = I;


%% Using CosineSim to find optimal clusters
    mink = 3;
    %maxk =8;
    linefit_cos = zeros(maxk-mink+1,1);
    for j=1:maxk-mink+1
        linefit_cos(j)=mean((CosineSim(model.etrain(:,1:mink-2+j),model.qtrainExtra(mink-2+j,:))));
        %linefit_cos(j)=(CosineSim(model.etrain(:,1:mink-2+j),qtrain(mink-2+j,:)));
    end;
    linefit_cos(isnan(linefit_cos)) = 0;
    y=mink:maxk;
    plot(y,linefit_cos(1:end));
    xlabel('Number of Clusters (k)');
    ylabel('BAF');
    title('Plot of BAF value vs Number of Clusters (k)');
    [~,idx_max_cos] = max(linefit_cos(1:end));
    numclu_value = idx_max_cos+mink-1;
    numclu_value = 38;

%% performing test step of KSC
tic
[out ,qtest, mqtest]=KSC_test( X,X_train, X_test,numclu_value );
toc
%[qtest,mqtest]=KSCmembership(out.etest,CB); 
output = [X_test',qtest];

%% evaluation of model
communityinfo = 'C:\Program Files\MATLAB\R2011a\bin\circles.Facebook\facebook\1912';
community = load([communityinfo,'.circles'],'-ascii');
community(:,2) = community(:,2)+1;
[uniquesP,numUniqueP] = count_unique(output(:,2));
[uniques,numUnique] = count_unique(community(:,1));
usersPerCircle = numUnique;
usersPerCircleP = numUniqueP;
[assignment,cost] = myeditloss(usersPerCircle,usersPerCircleP);
part = 1 - cost/(max(length(usersPerCircle), length(usersPerCircleP)))^2;
frac_comm = numclu_value/length(uniques);
%part = cost/length(X_test);
f1 = (2*frac_comm*part)/(frac_comm+part);
