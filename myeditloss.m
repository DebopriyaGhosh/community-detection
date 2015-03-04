% Learning Social Circles in Networks 
% usersPerCircle : list of set of users (groundtruth),order doesnot matter
% usersPerCircleP : list of set of users (predicted),order doesnot matter

function [assignment,cost] = myeditloss(usersPerCircle,usersPerCircleP)

%psize : either the number of groundtruth or the number of predicted
%circles( whichever is larger)
psize = max(length(usersPerCircle),length(usersPerCircleP));
%pad the matrix with zeros
MM = zeros(psize); %matching matrix containing costs of matching groundtruth circles to predicted circles
%M[i][j] = cost of matching groundtruth circle i to predicted circle j.
for i = 1:psize
    if i<=length(usersPerCircle)
        set1 = usersPerCircle(i);
    else
        set1 = [];
    end;
    for j = 1:psize
        if j<=length(usersPerCircleP)
            set2 = usersPerCircleP(j);
        else
            set2 = [];
        end;
        %compute the distance between two circles
        MM(i,j) = length(setxor(set1, set2));
    end;
end;
% compute optimal alignment between predicted and groundtruth circles.
[assignment,cost] = munkres(MM);
end       
