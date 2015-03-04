% load the feature vectors of the alters.

featureInfo = 'C:\Program Files\MATLAB\R2011a\bin\circles.Facebook\facebook\3980';
feature = load([featureInfo,'.feat'],'-ascii');
feature_temp = feature(:,2:size(feature,2));



S = findCluster( feature_temp);
S_temp = sort(S);
U = unique(S_temp);

[uniquesP,numUniqueP] = count_unique(S);
communityinfo = 'C:\Program Files\MATLAB\R2011a\bin\circles.Facebook\facebook\3980';
community = load([communityinfo,'.circles'],'-ascii');
community(:,2) = community(:,2)+1;
[uniques,numUnique] = count_unique(community(:,1));
usersPerCircle = numUnique;
usersPerCircleP = numUniqueP;
[assignment,cost] = myeditloss(usersPerCircle,usersPerCircleP);
part = 1 - cost/(max(length(usersPerCircle), length(usersPerCircleP)))^2;

frac_comm = length(uniquesP)/length(uniques);
f1 = (2*frac_comm*part)/(frac_comm+part);
