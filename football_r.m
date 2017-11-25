clear all; 

% set problem params
global YL; 
YL=30;
global lambda_r
lambda_r = 3; 
S =YL*4*10; 


% compute Pr, it's a state search problem
global Pr;
global state_mapper; 
Pr = zeros(S); 
state_mapper = []; 
state_mapper = [state_mapper; [0 1 10] ]; 
state_mapper = [state_mapper; [-2 -2 -2] ]; % lost index is 2
state_mapper = [state_mapper; [-3 -3 -3] ]; % win index is 3
global visited_r;
visited_r = zeros(S,1); 


dfs_r([0 1 10]); 
calculate_Pr(); 
N = size(state_mapper, 1); 
state_mapper = [state_mapper; [-4 -4 -4] ]; % Terminal index is N+1
Pr(2,N+1) = 1; 
Pr(3,N+1) = 1; 
Pr(N+1, N+1) = 1; 
function dfs_r( state )
    global Pr;
    global state_mapper; 
    global visited_r; 
    
    index = getIndex(state); 
    visited_r(index) = 1;
    if( index == 2 )
        return; 
    elseif( index == 3 )
        return; 
    else
        % do nothing
    end
    % Not belong to any Terminal state, need to expand this node
    NeighborIndices = generate_neighbors_r(state);
    for n = 1:size(NeighborIndices, 2)
        Pr(index, NeighborIndices(n)) = 1;%computePr(index, NeighborIndices(n)); 
        if(visited_r(NeighborIndices(n)) == 0)
            dfs_r( state_mapper( NeighborIndices(n), : ) ); 
        end
    end
     
    return; 
end

function calculate_Pr()
global Pr; 
    n = size(Pr, 1); 
    for k = 1:n
        for j = 1:n
            if(Pr(k, j) == 1)
                Pr(k,j) = computePr(k, j); 
            end
        end
    end
end


function index = add_state_to_map_and_return_index(state)
    global state_mapper;
    if(isMapped(state) == 0)
        state_mapper = [state_mapper; state ]; % add it in state_mapper! 
        size(state_mapper, 1)
    end
    index = getIndex(state); 
end

function p = poi(k, lambda)
    p = lambda^k*exp(-lambda)/factorial(k); 
end

function NeighborIndices = generate_neighbors_r(state)
    global YL;
    state_ = []; 
    yl = state(1); dw = state(2); tg = state(3); 
    NeighborIndices = []; 
    NeighborIndices = [NeighborIndices 3];  % add win to be its neighbor
    if(dw == 4)
        NeighborIndices = [NeighborIndices 2];  % add lose to be its neighbor
        for yl_ = yl:YL-1
            if(tg-(yl_ - yl) <= 0)
                state_ = [yl_, 1, 10]; 
                index_ = add_state_to_map_and_return_index(state_);
                NeighborIndices = [NeighborIndices index_]; % add this state
            end
        end
    else
        for yl_ = yl:YL-1
            if( tg-(yl_ - yl) >= 1 )
                state_ = [yl_, dw+1, tg-(yl_ - yl)];  
            else
                state_ = [yl_, 1, 10];
            end
            index_ = add_state_to_map_and_return_index(state_);
            NeighborIndices = [NeighborIndices index_]; % add this state
        end
    end
    
end


function pr = computePr(index, index_)
    global state_mapper;   
    global YL
    global lambda_r
    state = state_mapper(index, :); 
    yl = state(1); dw = state(2); tg = state(3);
    state_ = state_mapper(index_, :); 
    yl_ = state_(1); dw_ = state_(2); tg_ = state_(3); 
    if(index_ == 2)
        % probability of lose
        pr = 0; 
        for i = 0:tg-1
            if(yl + i < YL)
                pr = pr + poi(i, lambda_r); 
            end
        end
    elseif(index_ == 3)
        % probability of win
        pr = 1; 
        for i = 0:YL-yl-1
            pr = pr - poi(i, lambda_r); 
        end
    else
        % probablity from index to index_
        pr = poi(yl_-yl, lambda_r); 
    end

end

function index = getIndex(state)
   global state_mapper; 
   index = intersect(...
       intersect(find(state_mapper(:,1)==state(1)), find( state_mapper(:, 2) == state(2) ) ),...
       find( state_mapper(:, 3)== state(3))); 
end

function exist = isMapped(state)
    global state_mapper; 
    if(size(intersect(...
       intersect(find(state_mapper(:,1)==state(1)), find( state_mapper(:, 2) == state(2) ) ),...
       find( state_mapper(:, 3)== state(3)))...
       , 1) == 1)
        exist = 1;  
    else
        exist = 0;
    end
end

