function [p mu]=plot_pWin (qF, qS, pS)
    p=[];
    mu=[];
    for pF=0:0.05:0.95 
        [pWin, mustar] = tennis( qF, qS, pF, pS );
        p=[p pWin];
        mu = [mu mustar];
    end
    plot(p, 'k','LineWidth',2);
    xlabel('Probability of fast serve landing inbound')
    ylabel('Probability to win with optimal serve selection')
    grid on; 
    hold on; 
end

function [pWin, mustar] = tennis( qF, qS, pF, pS )

    
    P{1} = zeros(9);
    P{1}(1,2) =1-pF;
    P{1}(1,3) = pF*qF;
    P{1}(1,5) = pF*(1-qF);
    P{1}(2,3) = pF*qF; 
    P{1}(2,5) = 1-pF*qF; 
    P{1}(3,1) = pF*(1-qF); 
    P{1}(3,4) = 1-pF; 
    P{1}(3,7) = pF*qF; 
    P{1}(4,1) = 1-pF*qF; 
    P{1}(4,7) = pF*qF; 
    P{1}(5,1) = pF*qF; 
    P{1}(5,6) = 1-pF; 
    P{1}(5,8) = pF*(1-qF); 
    P{1}(6,1) = pF*qF; 
    P{1}(6,8) = 1-pF*qF; 
    P{1}(7:9, 9) = 1; 
    
   
    P{2} = zeros(9);
    P{2}(1,2) =1-pS;
    P{2}(1,3) = pS*qS;
    P{2}(1,5) = pS*(1-qS);
    P{2}(2,3) = pS*qS; 
    P{2}(2,5) = 1-pS*qS; 
    P{2}(3,1) = pS*(1-qS); 
    P{2}(3,4) = 1-pS; 
    P{2}(3,7) = pS*qS; 
    P{2}(4,1) = 1-pS*qS; 
    P{2}(4,7) = pS*qS; 
    P{2}(5,1) = pS*qS; 
    P{2}(5,6) = 1-pS; 
    P{2}(5,8) = pS*(1-qS); 
    P{2}(6,1) = pS*qS; 
    P{2}(6,8) = 1-pS*qS; 
    P{2}(7:9, 9) = 1; 
    
    g = zeros(9,2,9);
    %g(3,:,7) = 1; 
    %g(4,:,7) = 1;
    g(7,:,9) = 1; 
    
    g0 = zeros(9,1);
    
    [ Jstar, mustar ] = VI_max( P, g, g0, 0.001);
    % Jstar
    pWin=Jstar(1);

end

