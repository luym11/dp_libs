% tetrisMain.m script
% Enter the values to setup tetris simulation
%Readme%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function Definition:
% boardHeight: takes board as an input and return heights of each column
% getTetrisBoard: takes boards, state number, and stateMap  and returns
%                 board/piece corresponding to a state.
% getTetrisState: takes a board and a piece and retuns state number.
% myPlay: play rule to minimize maximum height, evaluate all possible 
%         control (moves) givrn a piece and returns the one resulting in
%         minimum maximum hight for next board.
% nextBoard: takes board and selected control (move) and returns the new
%            board and positive score if any lines were wiped out.
% randiP: selects a random integer according to probability vector p.
% softmax: computes softmax of input vector
% tetrisBuild: build the basic elements of Tetris game
% tetrisBuildDemo: illustrates the use/structure of different 
%                  functions/variables in a the code
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;clear; close all

tData.nMaxPieces = 100; % max number of pieces per episode
tData.nEpisodes = 5; % number of episodes

tData.buildStates = 1; % flag to build state space
tData.morePieces = 1; % add the s-shaped pieces

tData.GameSize = [6,3]; % height x width
tData.RowCap = 3; % height of gameOver
tData.TimeDelay=.05; % Time delay of dropping piece (lower number=faster)

tData.SelectMethod = 1; %1. Value iteration.  2. Q-Learning Exact

% Define the game pieces
Pieces{1} = [0 1;1 1];
Pieces{2} = [0 1 0;1 1 1];
Pieces{3} = [1 1 1];
numRots = [3 3 1]; %number of times each piece can be rotated
if tData.morePieces == 1,
    Pieces{4} = [1 1 0;0 1 1];
    Pieces{5} = [0 1 1;1 1 0];
    numRots = [3 3 1 1 1]; 
end
    
tData.Pieces = Pieces;
tData.numRots = numRots;
% Set piece colors
tData.Pcolor=1:length(Pieces);

% Build tetris states & moves
if tData.buildStates,
    display(datetime('now'))
    tic
    [moves,flatBoards,boards,stateMap] = ...
        tetrisBuild(tData.RowCap,tData.GameSize(2),Pieces,numRots);
    tData.flatBoards = flatBoards;
    tData.boards = boards;
    tData.moves = moves;
    tData.stateMap = stateMap;
    toc
else
    moves = tetrisBuild(tData.RowCap,tData.GameSize(2),Pieces,numRots);
    tData.moves = moves;
end

tData.S_Sounds=0; % Switch, 1=sounds on, 0=sounds off
tData.S_Plot=1;  % Switch to Perform plotting, 1=yes

tData.startPiece = randi(length(Pieces));

tData = tetrisVI(tData); 
% Run Demo 
[Iscore,nPieces] = tetrisMyPlayDemo(tData);