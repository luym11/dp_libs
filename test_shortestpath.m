clear all; 
A=[     0     2     1   -1   -1
   -1     0   -1     1     4
   -1   -1     0     9     7
   -1   -1   -1     0     1
   -1   -1   -1   -1     0];
method=1; 

[ route, cost ] = shortestpath( A, 2 )
%% 
clear all; 
% use optTrajectory to solve shortestpath, assuming all L(i,j,:) are the
% same, i.e., cost between nodes is stationary

% input for shortestpath
A=[     0     2     1   -1   -1
   -1     0   -1     1     4
   -1   -1     0     9     7
   -1   -1   -1     0     1
   -1   -1   -1   -1     0];


% input for optTrajectory
n = size(A, 1);
Lo = inf*ones(n,n,n);
for i = 1:n
    for j = 1:n
        if(A(i,j)==-1)
            Lo(i,j,:)=inf;
        else
            Lo(i,j,:)=A(i,j);
        end
    end
end

% set like this to determine S and T
LS = ones(5,1)*inf;LS(1) = 0; 
LT = ones(5,1)*inf;LT(end) = 0; 

routeo = optTrajectory( Lo, LS, LT )
[route, cost] = shortestpath( A, 3 )

% From the result we can see they're the same. And shortest path finds the
% best way faster