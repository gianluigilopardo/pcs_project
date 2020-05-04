% vicini


function tocheck = near(triangle)
    
    global edge ele neigh node punti tracce
    global n_edge n_ele n_neigh n_node n_punti n_tracce

        
        tocheck = [];
        
    for i = 1:n_ele
        if triangle(i) == 1
                for j = 2:4
                    if neigh(i,j) ~= -1
                        if triangle(neigh(i,j)) == -1
                            x = length(tocheck);
                            tocheck(x+1) = neigh(i,j);
                    
                        end
                    end
                end
        end
    end
    
    
end
