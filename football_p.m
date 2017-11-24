% set problem params
global YL; 
YL=30;
global lambda_p;
lambda_r = 3; 
lambda_p = 10; 
global p;
p = 0.4; 
global q; 
q = 0.05;
S =YL*4*10; 


% compute Pp, it's a state search problem
global Pp;
global state_mapper; 
Pp = zeros(S); 
global visited_p;
visited_p = zeros(S,1); 
% state_mapper = []; 
% state_mapper = [state_mapper; [0 1 10] ]; 
% state_mapper = [state_mapper; [-2 -2 -2] ]; % lost index is 2
% state_mapper = [state_mapper; [-3 -3 -3] ]; % win index is 3

dfs_p([0 1 10]); 
calculate_Pp(); 
N = size(state_mapper, 1); 
Pp(2,N+1) = 1; 
Pp(3,N+1) = 1; 
Pp(N+1, N+1) = 1; 
function dfs_p( state )
    global Pp;
    global state_mapper; 
    global visited_p;
    
    index = getIndex(state); 
    visited_p(index) = 1; 
    if( index == 2 )
        return; 
    elseif( index == 3 )
        return; 
    else
        % do nothing
    end
    % Not belong to any Terminal state, need to expand this node
    NeighborIndices = generate_neighbors_p(state);
    for n = 1:size(NeighborIndices, 2)
        Pp(index, NeighborIndices(n)) = 1;%computePp(index, NeighborIndices(n));
        if(visited_p(NeighborIndices(n)) == 0)
            dfs_p( state_mapper( NeighborIndices(n), : ) ); 
        end
    end
    return; 
end

function calculate_Pp()
global Pp;
    n = size(Pp, 1); 
    for k = 1:n
        for j = 1:n
            if(Pp(k, j) == 1)
                Pp(k,j) = computePp(k, j); 
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

function NeighborIndices = generate_neighbors_p(state)
    global YL;
    state_ = []; 
    yl = state(1); dw = state(2); tg = state(3); 
    NeighborIndices = []; 
    NeighborIndices = [NeighborIndices 3];  % add win to be its neighbor
    NeighborIndices = [NeighborIndices 2];  % add lose to be its neighbor, cause can lose at any state
    if(dw == 4)
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


function pp = computePp(index, index_)
    global state_mapper;   
    global YL;
    global lambda_p;
    global p;
    global q;
    state = state_mapper(index, :); 
    yl = state(1); dw = state(2); tg = state(3);
    state_ = state_mapper(index_, :); 
    yl_ = state_(1); dw_ = state_(2); tg_ = state_(3); 
    pp_c = 1-p-q; 
    if(index_ == 2)
        % probability of lose
        pp = q; 
        if(dw == 4)
            pp = pp + p; 
            for i = 0:tg-1
                if(yl + i < YL)
                    pp = pp + pp_c * poi(i, lambda_p); 
                end
            end
        end
    elseif(index_ == 3)
        % probability of win
        pp = pp_c;
        for i = 0:YL-yl-1
            pp = pp - pp_c * poi(i, lambda_p); 
        end
    else
        % probablity from index to index_
        if(yl_==yl)
            pp = pp_c * poi(yl_-yl, lambda_p) + p;
        else
            pp = pp_c * poi(yl_-yl, lambda_p);
        end
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

