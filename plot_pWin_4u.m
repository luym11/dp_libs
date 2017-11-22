function [p, mu] = plot_pWin_4u (qF, qS, pS)
    p=[];
    mu = [];
    for pF=0:0.05:0.95 
        [pWin, mustar] = tennis( qF, qS, pF, pS );
        p=[p pWin];
        mu = [mu mustar];
    end
    plot(p, 'r','LineWidth',2);
    xlabel('Probability of fast serve landing inbound')
    ylabel('Probability to win with optimal serve selection')
    grid on; 
    hold on; 
end

function [pWin, mustar] = tennis( qF, qS, pF, pS )
    WFF = pF*qF + (1-pF)*pF*qF;
    LFF = 1-WFF; 
    P{1} = zeros(6);
    P{1}(1,2) = WFF;
    P{1}(2,5) = WFF;
    P{1}(3,1) = WFF;
    P{1}(1,3) = LFF; 
    P{1}(2,1) = LFF; 
    P{1}(3,4) = LFF; 
    P{1}(4:6, 6) = 1; 
    
    WSS = pS*qS + (1-pS)*pS*qS;
    LSS = 1-WSS; 
    P{2} = zeros(6);
    P{2}(1,2) = WSS;
    P{2}(2,5) = WSS;
    P{2}(3,1) = WSS;
    P{2}(1,3) = LSS; 
    P{2}(2,1) = LSS; 
    P{2}(3,4) = LSS; 
    P{2}(4:6, 6) = 1; 
    
    WFS = pF*qF + (1-pF)*pS*qS;
    LFS = 1-WFS; 
    P{3} = zeros(6);
    P{3}(1,2) = WFS;
    P{3}(2,5) = WFS;
    P{3}(3,1) = WFS;
    P{3}(1,3) = LFS; 
    P{3}(2,1) = LFS; 
    P{3}(3,4) = LFS; 
    P{3}(4:6, 6) = 1; 
    
    WSF = pS*qS + (1-pS)*pF*qF;
    LSF = 1-WSF; 
    P{4} = zeros(6);
    P{4}(1,2) = WSF;
    P{4}(2,5) = WSF;
    P{4}(3,1) = WSF;
    P{4}(1,3) = LSF; 
    P{4}(2,1) = LSF; 
    P{4}(3,4) = LSF; 
    P{4}(4:6, 6) = 1; 
    
    g = zeros(6,4,6);
    g(2,:,5) = 1; 
    
    g0 = zeros(6,1);
    
    [ Jstar, mustar ] = VI_max( P, g, g0, 0.001);
    % Jstar
    pWin=Jstar(1);

end