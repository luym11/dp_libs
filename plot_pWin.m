function plot_pWin (qF, qS, pS)
    p=[];
    for pF=0:0.05:0.95 
        p=[p tennis( qF, qS, pF, pS )];
    end
    plot(p, 'r','LineWidth',2);
    xlabel('Probability of fast serve landing inbound')
    ylabel('Probability to win with optimal serve selection')
    grid on; 
end

function pWin = tennis( qF, qS, pF, pS )
    WF = pF*qF + ((1-pF)+pF*(1-qF))*pF*qF;
    LF = 1-WF; 
    P{1} = zeros(6);
    P{1}(1,2) = WF;
    P{1}(2,5) = WF;
    P{1}(3,1) = WF;
    P{1}(1,3) = LF; 
    P{1}(2,1) = LF; 
    P{1}(3,4) = LF; 
    P{1}(4:6, 6) = 1; 
    
    WS = pS*qS + ((1-pS)+pS*(1-qS))*pS*qS;
    LS = 1-WS; 
    P{2} = zeros(6);
    P{2}(1,2) = WS;
    P{2}(2,5) = WS;
    P{2}(3,1) = WS;
    P{2}(1,3) = LS; 
    P{2}(2,1) = LS; 
    P{2}(3,4) = LS; 
    P{2}(4:6, 6) = 1; 
    
    g = zeros(6,2,6);
    g(2,1,5) = 1; 
    g(2,2,5) = 1;
    
    g0 = zeros(6,1);
    
    [ Jstar, ~ ] = VI_max( P, g, g0, 0.001);
    % Jstar
    pWin=Jstar(1);

end

