function DATAout = tetrisVI(DATA)
    
    DATAout = DATA;

    stateMap = DATA.stateMap;
    moves = DATA.moves; 
    flatBoards = DATA.flatBoards; 
    boards = DATA.boards; 
    Pieces = DATA.Pieces; 
    n_Pieces = size(Pieces, 2);

    N = size(stateMap, 1); % size of states
    M = 0; % size of controls
    moves_array = zeros(size(moves,2)+1, 1);% the last element is not used  
    for i = 1:size(moves,2)
        M = M + size(moves{i},2);
        moves_array(i+1) = M; 
    end

    P = cell(1, M); 
    g = cell(1, M); 
    for i = 1:M       
        P{i} = sparse(N+1, N+1);
        g{i} = sparse(N+1, N+1);
    end
    
     

    for s = 1:N
        % get the board and piece at s
        [board,piece] = getTetrisBoard(s,boards,stateMap);
        n_p_moves = size(moves{piece}, 2); 

        for i = 1:n_p_moves % all possible next move
            next_move = moves{piece}{i}; 
            [newBoard,score] = nextBoard(board,next_move); 
            for p = 1:n_Pieces % all possible next piece
                if size(newBoard, 1) <= DATA.RowCap
                    s_new = getTetrisState(newBoard,p,flatBoards,stateMap);
                else
                    s_new = N+1; 
                end
                P{i+moves_array(piece)}(s, s_new) = P{i+moves_array(piece)}(s, s_new) + 1/n_Pieces; 
                g{i+moves_array(piece)}(s, s_new) = g{i+moves_array(piece)}(s, s_new) + score/n_Pieces; 
            end
        end
    end
    for i = 1:M
        P{i}(N+1, N+1) = 1; 
    end
    g0 = zeros(N+1,1); 
    alpha = 0.9; 
    [ Jstar, mustar] = VI_max_alpha( P, g, g0, alpha, 0.01); 

    DATAout.Jstar = Jstar; 
    DATAout.mustar = mustar; 
    DATAout.moves_array = moves_array;
end