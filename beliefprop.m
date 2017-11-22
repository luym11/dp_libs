function Xnew = beliefprop(P,R,X,z)
%%%%%%%%%%%%%%%%%%%%%%%%%
% Belief Propagation
%%%%%%%%%%%%%%%%%%%%%%%%%
    n=size(X,2); 

    Xnew=zeros(1,n); 
    fenzi = zeros(1,n);

    for i = 1:n
        for j = 1:n
            fenzi(i) = fenzi(i)+ P(j,i)*X(j)*R(z,j,i);
        end
    end
    fenmu=sum(fenzi);

    for i = 1:n
        Xnew(i) = fenzi(i)/fenmu; 
    end

end

