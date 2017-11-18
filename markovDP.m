function [ J0, mu0 ] = markovDP( P, g, gT, T )
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generic DP solver for finite state Markov Decision Process
% P is a cell matrix, P{1}, P{2}, ..., P{M}. Each P{m} is N*N under control
% action m, N is the number of states. P{m}(i,j) is Pr(i->j|m)
% g is N*M*N stage cost, where g(i,m,j) indicates cost of i->j using m
% gT is terminal cost array
% T is terminal time
% J0 in N dimensional vector of optimal cost-to-go for each state at time 0
% mu0 is N dim vector of optimal control action for each state at time 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % init
    n = size(gT, 1);
    m = size(P,2);
    J = zeros(n, T+1);
    J0 = zeros(n, 1);
    mu0 = zeros(n, 1); 
    choice = zeros(n, T); 
    % Step 1, Stage T
    for i = 1:n
        J(i, T+1) = gT(i);
    end
    
    % Step 2, do the loop! 
    All_J_i_k = zeros(m, 1); 
    for k = T:-1:1
        for i = 1:n
            All_J_i_k = zeros(m, 1);
            for u = 1:m
                for j = 1:n
                    cost = ( g(i, u, j) + J(j, k+1) ) * P{u}(i, j);
                    if(isnan(cost) == 1) % 0 times inf case: set to 0
                        cost = 0; 
                    end
                    All_J_i_k(u) = All_J_i_k(u) + cost; 
                end
            end
            % contemporary_J
            [J(i, k), choice(i, k)] = min(All_J_i_k);
        end
    end
    
    % answer output
    for p = 1:n
        J0(p)= J(p, 1); 
        mu0(p) = choice(p, 1); 
    end
end

