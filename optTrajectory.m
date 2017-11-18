function route = optTrajectory( L, LS, LT )
    % Revised DP HW1-7
    % Note here -1 and -2 will be used to mark S and T node, respectively
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Find minimum cost trajectory from starting node S to terminal node T
    % L(i,j,k) is cost from node i to node j at stage k
    % LS and LT are costs from S to nodes set and nodes set to T,
    % respectively
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    n_stages = size(L,3); 
    n_nodes = size(L,1);
    routes = ones(n_nodes, n_stages+3) * 0;
    routes(:, n_stages+3) = -2; 
    % LT
    C = LT'; 
    cc=[];
    % DP in stages
    for i=n_stages:-1:1
        for j=1:n_nodes
          [Y_DP, I_DP] = min(L(j,:,i) + C); 
          cc(j) = Y_DP; 
          routes(j, i+2) = I_DP; 
        end
        C=cc; 
    end
    % LS
    [Y_LS, I_LS] = min(LS' + C); 
    routes(:, 2) = I_LS; 
    routes(:, 1) = -1; 
    route = [];
    route(1) = -1; 
    route(2) = I_LS;
    for i = 3:size(routes, 2) - 1
        route(i) = routes(route(i-1), i);
    end
    route(size(routes, 2)) = -2; 
end

