L = inf*ones(5,5,2);
L(1,4,2) = 5;
L(2,4,2) = 1;
L(3,5,2) = 5;
% stage N - 2 = 1
L(1,2,1) = 4;
L(1,3,1) = 1;
L(5,3,1) = 0;

LS = zeros(5,1);
LT = zeros(5,1);

route = optTrajectory( L, LS, LT )

% in this experiment setting, actually is finding shortest path from any
% node to any node in given time steps. Here doesn't assume staying at the
% same place cost nothing. So this setup is more versatile