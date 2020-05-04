% posizione punti rispetto alla frattura

% valore 1 se il punto sta sopra al piano
% valore -1 se il punto sta sotto al piano
% valore 0 se il punto giace sul piano

function [posizionenodi] = posnodi(n,d)
global node n_node

posizionenodi=zeros(1,n_node);

%per ogni nodo si usa la disequazione data dall'equazione cartesiana del
%piano ax+by+cz+d>0 sostituendo le coordinate (x,y,z) di ogni nodo

for i=1:n_node
    
    r = node(i,:)*n'+d;
    if r > eps
        posizionenodi(i) = 1;
    elseif r < -eps
        posizionenodi(i) = -1;
    end        
end

end
