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
state = getTetrisState(board,pieceNum,DATA.flatBoards,DATA.stateMap); 
u = DATA.mustar(state) - DATA.moves_array(pieceNum);
decision = DATA.moves{pieceNum}{u};
DATAout = DATA; 

