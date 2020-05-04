function [ pos_int_facc,facce_inters,n_inters ] = posizioneinterna_facceintersecate( pos_int )

n_inters=length(pos_int);
facce_inters=zeros(1,4);

for j=1:n_inters %calcola con quali lati avvengono le intersezioni, ordinando i lati
    if pos_int(j)==1
        pos_int_facc(:,j)=[-1 -1 1 1];
    elseif pos_int(j)==2
        pos_int_facc(:,j)=[-1 1 -1 3];
    elseif pos_int(j)==3
        pos_int_facc(:,j)=[-1 3 3 -1];
    elseif pos_int(j)==4
        pos_int_facc(:,j)=[1 -1 -1 2];
    elseif pos_int(j)==5
        pos_int_facc(:,j)=[3 -1 2 -1];
    else
        pos_int_facc(:,j)=[2 2 -1 -1];
    end
end
                        
for j=1:n_inters %calcola con quali facce avviene l'intersezione
    if (pos_int(j)==4 || pos_int(j)==5 || pos_int(j)==6)
        facce_inters(1)=1;
    end
    if (pos_int(j)==2 || pos_int(j)==3 || pos_int(j)==6)
        facce_inters(2)=1;
    end
    if (pos_int(j)==1 || pos_int(j)==3 || pos_int(j)==5)
        facce_inters(3)=1;
    end
    if (pos_int(j)==1 || pos_int(j)==2 || pos_int(j)==4)
        facce_inters(4)=1;
    end
end
end

