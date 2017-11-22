function [ Jstar, mustar ] = VI_max( P, g, g0, Accuracy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generic VI process to solve Bellman Equation for infinite horizon 
% Here we use DP recursion( new notations) i.e.,
% J_0 -> J_1 -> ... -> J_{inf}
% P (transition probabilities) is a cell matrix, P{1}, P{2}, ..., P{M}. Each P{m} is N*N under control
% action m, N is the number of states. P{m}(i,j) is Pr(i->j|m)
% g is N*M*N stage cost, where g(i,m,j) indicates cost of i->j using m
% gT is terminal cost array
% T is terminal time
% J0 in N dimensional vector of optimal cost-to-go for each state at time 0
% mu0 is N dim vector of optimal control action for each state at time 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % init
    n = size(g0, 1); % Number of states
    m = size(P,2); % Number of controls
    J = zeros(n, 1); % store cost of all the rounds
    Jstar = zeros(n, 1); % J's converge to Jstar
    mustar = zeros(n, 1); % Optimal policy for Jstar
    choice = zeros(n, 1); % store choices of all the records
    
    % Step 1, Stage 0
    for i = 1:n
        J(i, 1) = g0(i); % "terminal cost"
    end
    
    % Step 2, do the loop! 
    k = 1; % how many times does the iteration execute
    e = 1; % error between two costs in consecutive iterations
    while e > Accuracy  
        J = [J zeros(n,1)];
        choice = [choice zeros(n,1)];
        for i = 1:n
            All_J_i_k = zeros(m, 1);
            for u = 1:m
                for j = 1:n
                    cost = ( g(i, u, j) + J(j, k) ) * P{u}(i, j);
                    if(isnan(cost) == 1) % 0 times inf case: set to 0
                        cost = 0; 
                    end
                    All_J_i_k(u) = All_J_i_k(u) + cost; 
                end
            end
            [J(i, k+1), choice(i, k)] = max(All_J_i_k);
        end 
        e = norm(J(:,k+1)-J(:,k));
        k = k + 1;
    end
    
    % answer output
    for p = 1:n
        Jstar(p)= J(p, k); 
        mustar(p) = choice(p, k-1); 
    end
    % k-1
    % J
    % choice
end

