function coda  = Coda(coda,tetra_inters,i)

global neigh

for j=1:4
    flag=0;
    x=length(coda);
     if neigh(i,j) ~= -1     
         if tetra_inters(neigh(i,j)) == 0 %il tetraedro non è stato già controllato
                 
                  for z=x:-1:1
                        if neigh(i,j)==coda(z) %il tetraedro appartiene già alla coda
                             flag=1;
                             break
                        end
                  end 
                  if flag==0
                        coda(x+1)=neigh(i,j); %aggiungo il vicino alla coda
                  end
         end
     end
end