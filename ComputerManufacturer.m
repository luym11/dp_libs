% 7.3 Computer manufacturer
P{1} = [0.8, 0.2; 0, 0]; 
P{2} = [0.5, 0.5; 0, 0];
P{3} = [0, 0; 0.7, 0.3]; 
P{4} = [0, 0; 0.4, 0.6]; 
g = inf*zeros(2,4,2); 
g(1, 1, :) = 4; 
g(1, 2, :) = 6; 
g(2, 3, :) = -5; 
g(2, 4, :) = -3;

% mu0(i) = Na (if i == 1)
%        = r  (if i == 2)
alpha = 0.9;
Pmu0 = [P{2}(1, :);P{3}(2, :)];
G0 = [6; -5];
Jmu0 = (eye(2)-alpha*Pmu0)\G0; 
%%
% mu0(i) = Na (if i == 1)
%        = Nr (if i == 2)
Pmu1 = [P{2}(1, :);P{4}(2, :)];
G1 = [6; -3];
Jmu1 = (eye(2)-alpha*Pmu1)\G1 
    
%%
% VI
g0 = [0; 0]; 
alpha = 0.99; 
[ Jstar, mustar] = VI_max_alpha( P, g, g0, alpha, 0.00001)
