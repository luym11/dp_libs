function occupancy = markovSim( P, q, T)
occupancy = q; 
new_state = q; 
for i = 1:T
    new_state = new_state * P; % note here: two ways of defining q'=q*P or q'=P*q
    occupancy = occupancy + new_state; 
end
occupancy = occupancy / (1+T); 

end

