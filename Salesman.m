% 7.4 Salesman
c = 3; 
rA = 2; 
rB = 1; 

P{1} = [0, 1; 1, 0]; 
P{2} = [1, 0; 0, 1]; 

g = zeros(2,2,2); 
g(1,1,2) = rB - c; 
g(2,1,1) = rA - c; 
g(1,2,1) = rA; 
g(2,2,2) = rB; 

alpha = 0.9;
%% 
Pmu0 = P{1}; 
G0 = [rB-c; rA-c];
Jmu0 = (eye(2)-alpha*Pmu0)\G0; 

%%
g0 = [0; 0]; 
alpha = 0.99; 
[ Jstar, mustar] = VI_max_alpha( P, g, g0, alpha, 0.00001)