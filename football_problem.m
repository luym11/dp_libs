function [pWin mustar Jstar state_mapper] = football_problem()
    Pr = importdata('./python/Pr.txt');
    Pp = importdata('./python/Pp.txt');
    P{1} = Pr; P{2} =Pp; 
    state_mapper = importdata('./python/state_mapper.txt'); 
    N = size(state_mapper, 1); 
    g = zeros(N, 2, N); 
    g(3,:,N) = 1; 
    g0 = zeros(N, 1); 
    
    [ Jstar, mustar ] = VI_max( P, g, g0, 0.001);
    pWin=Jstar(1);
    
    sorted_mapper = sortrows(state_mapper);
    resultMat = [sorted_mapper(:, 2:4), mustar, Jstar];
    % save results to a file
    fileID = fopen('results.txt', 'w'); 
    fprintf(fileID, '%8s %8s %5s\r\n', 'state', 'u', 'pWin'); 
    for i = 1:size(resultMat, 1)
        fprintf(fileID, '[%3d %3d %3d] %3d %6.4f\r\n', resultMat(i, :)); 
    end
    fclose(fileID); 
    
    % save results to a file
    sorted_result = sortrows(resultMat, 5);
    fileID = fopen('sorted_results.txt', 'w'); 
    fprintf(fileID, '%8s %8s %5s\r\n', 'state', 'u', 'pWin'); 
    for i = 1:size(resultMat, 1)
        fprintf(fileID, '[%3d %3d %3d] %3d %6.4f\r\n', sorted_result(i, :)); 
    end
    fclose(fileID); 
    
end

