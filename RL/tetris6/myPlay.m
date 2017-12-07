function [decision,DATAout] = myPlay(board,pieceNum,DATA)
% % 
% % Places the piece to minimize the maximum height
% %
% for u = 1:length(DATA.moves{pieceNum}),
%     move = DATA.moves{pieceNum}{u};
%     theNextBoard = nextBoard(board,move);
%     height(u) = max(boardHeight(theNextBoard));
% end
% 
% [~,uBest] = min(height);
% 
% decision = DATA.moves{pieceNum}{uBest};
% DATAout = DATA;

% Offline VI policy, can use the same code for QL
state = getTetrisState(board,pieceNum,DATA.flatBoards,DATA.stateMap); 
u = DATA.mustar(state) - DATA.moves_array(pieceNum);
if u <= 1 % if model is not fully trained
    u = 1;
end
try
    decision = DATA.moves{pieceNum}{u};
catch ME
    u
    state
    DATA.mustar(state)
    pieceNum
    DATA.moves_array(pieceNum)
end
DATAout = DATA; 



