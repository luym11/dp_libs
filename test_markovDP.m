%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by: M.Shaqura
% Created on: 8/10/2017
%%%%%%
% This function generates test examples with the expected outputs J0,mu0
% for the markovDP function
% Inputs:
%        exmp: integer number 1,2
% Outputs:
%        P: is a cell matrix of transition probabilities under different
%           controllers. P{m}(i,j) is the probility of landing at state j
%           coming from state i under control m
%        g: is an (n x m x n) matrix of stage cost where g(i,m,j) is the cost to go
%           from state i to state j using control m
%        gT: n x 1 terminal cost vector. (n: number of states)
%        T: Terminal time
%%%%%%%

function [P,g,gT,T] = test_markovDP(exmp)

    switch exmp    
        case 1
            [P,g,gT,T] = exmp1();
        case 2
            [P,g,gT,T] = exmp2();
        otherwise
            disp('Wrong input argument! the function accepts only 1 or 2');
    end
end



% First Example: Two states, Two controls

% Output
% J0 =
%        6.8888
%        6.5649
%
% mu0 =
%        2
%        1

function [P,g,gT,T] = exmp1()

    T = 8;
    P{1} = [1 0;1 0];
    P{2} = [0.25 0.75;0.25 0.75];
    gT = [1;0];
    g = inf*ones(2,2,2);
    g(1,1,1) = 1;
    g(2,1,1) = 0.5;
    g(1,2,2) = 0;
    g(1,2,1) = 4;
    g(2,2,2) = 0;
    g(2,2,1) = 4;
    
end



% Second Example: 5 states, 5 controls
% J0 =
%    18.0117
%    17.7615
%    17.5180
%    17.3652
%    17.6152
% 
% mu0 =
%      2
%      2
%      3
%      4
%      4

function [P,g,gT,T] = exmp2() % input format modified for the effective implementation

    T = 10;
    P{1} = [0.85 0.1 0.05 0 0; 0.65 0.3 0.05 0 0; 0.65 0.1 0.25 0 0;...
            0.65 0.1 0.05 0.2 0; 0.65 0.1 0.05 0 0.2];
    P{2} = [0.3 0.65 0.05 0 0; 0.1 0.85 0.05 0 0; 0.1 0.65 0.25 0 0;...
            0.1 0.65 0.05 0.2 0; 0.1 0.65 0.05 0 0.2];
    P{3} = [0.2 0.1 0.65 0.05 0; 0 0.3 0.65 0.05 0; 0 0.1 0.85 0.05 0;...
            0 0.1 0.65 0.25 0; 0 0.1 0.65 0.05 0.2];
    P{4} = [0.2 0 0.1 0.65 0.05; 0 0.2 0.1 0.65 0.05; 0 0 0.3 0.65 0.05;...
            0 0 0.1 0.85 0.05; 0 0 0.1 0.65 0.25];
    P{5} = [0.2 0 0.05 0.1 0.65; 0 0.2 0.05 0.1 0.65; 0 0 0.25 0.1 0.65;...
            0 0 0.05 0.3 0.65; 0 0 0.05 0.1 0.85];
    gT = [5;20;7;5;10];
    
    s1 = ones(5,1);
    s2 = 2*ones(5,1);
    s5 = 10*ones(5,1);
    g1 = [s1 s2 s5 s5 s5];
    g{1} = g1;
    g2 = [s2 s1 s2 s5 s5];
    g{2} = g2;
    g3 = [s5 s2 s1 s2 s5];
    g{3} = g3;
    g4 = [s5 s5 s2 s1 s2];
    g{4} = g4;
    g5 = [s5 s5 s5 s2 s1];
    g{5} = g5;
    
end