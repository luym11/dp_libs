function [ route, cost ] = shortestpath( A, method )
% DP HW 1-8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find shortest path from a to N using Label correcting algorithm
% A_{ij} is distance from i to j, -1 distance indicates there's no path
% between i and j
% method:
% - 1: FIFO: Bellman-ford: Forward DP
% - 2: LIFO
% - 3: Minimum label: Dijkstra: Faster than original Bellman-ford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initialize
MAXINT = 1000000000;
N = size(A, 1); 
d = ones(1, N)*MAXINT;
d(1) = 0; % pretty important setting! 

% records for the previous node on the shortest path
pre = zeros(1, N); 
pre(1) = 1;

% Add start node in OPEN
OPEN(1) = 1; 


while(~isempty(OPEN))
    switch method
        case 1
            node = OPEN(1);
            OPEN(1) = []; 
        case 2
            node = OPEN(end); 
            OPEN(end) = []; 
        case 3
            [~, node_index] = min(d(OPEN));  
            node=OPEN(node_index); 
            OPEN(node_index)=[]; 
    end
    
    for i=1:N
        if(A(node, i) ~= -1) % there's a path
            D = d(node) + A(node, i);
            if(D < d(i) && D < d(N))
                d(i) = D;
                if(i ~= N)
                    OPEN=[OPEN i];
                end
                pre(i) = node; 
            end
        end
    end
end

% output results
cost = d(N); 
it_node = N;
route=[];
while(it_node ~= 1)
    route = [it_node route];  
    it_node = pre(it_node); 
end
route=[1 route];

end

