function DATAout = tetrisQIOff(DATA)
    DATAout = DATA;

    stateMap = DATA.stateMap;
    moves = DATA.moves; 
    flatBoards = DATA.flatBoards; 
    boards = DATA.boards; 
    Pieces = DATA.Pieces; 
    n_Pieces = size(Pieces, 2);
    
    moves_array = DATA.moves_array; 
    Q = DATA.Q;  
    startPiece = DATA.startPiece; 
    kc = 1; 
    nTrainEpisodes = DATA.nTrainEpisodes;
    % x = startState; 
    
    board = boards{1};
    alpha = 0.9; 
    iter = 0; 
    while kc <= nTrainEpisodes
        iter = iter + 1; 
        if size(board,1) > DATA.RowCap || iter > 100 % new episode
            iter = 0; 
            kc = kc + 1; 
            new_piece = startPiece;
            board = boards{1};
        else
            new_piece = randi(n_Pieces); % fall a piece arbitraryly
        end
        x = getTetrisState(board,new_piece,flatBoards,stateMap);
    %     Generate a strategy using randomized control from Q(x,U(x))
    %     muRand = softmax(Q(x,moves_array(new_piece)+1:moves_array(new_piece)+size(moves{new_piece}, 2))/Temp);
    %     u = randiP(muRand);
        u = randi(size(moves{new_piece}, 2)); 
        next_move = moves{new_piece}{u};
        [newBoard,score] = nextBoard(board,next_move);
        if size(newBoard,1) > DATA.RowCap
            Q(x,u + moves_array(new_piece)) = score; 
            board = newBoard; 
            continue;
        end
        % Step is updated based on the number of visits (1/1+t)
    %         step = 1/(js(x,u)+1);
    %         step = step^0.6;
        % Update Q 
        Q(x,u + moves_array(new_piece)) = score; 
        for p = 1:n_Pieces
            next_state = getTetrisState(newBoard,p,flatBoards,stateMap); 
            % Q(x,u) = (1-step)*Q(x,u) + step*(score + alpha*max(Q(next_state,:)));
            Q(x,u + moves_array(new_piece)) = Q(x,u + moves_array(new_piece)) + 1/n_Pieces * alpha * max(Q(next_state, :)); 
        end
        board = newBoard; 
    end
    datetime
    
    [Jstar, mustar] = max(Q.');
    
    DATAout.Q = Q; 
    DATAout.Jstar = Jstar; 
    DATAout.mustar = mustar; 
end