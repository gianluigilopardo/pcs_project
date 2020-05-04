function coda  = Coda(coda,triangle,i)

global neigh

for j=2:4
    flag=0;
    x=length(coda);
     if neigh(i,j) ~= -1
         if triangle(neigh(i,j)) == 0 %il triangolo non è stato già controllato
                 
                  for z=x:-1:1
                        if neigh(i,j)==coda(z) %il triangolo appartiene già alla coda
                             flag=1;
                             break
                        end
                  end 
                  if flag==0
                        coda(x+1)=neigh(i,j);
                  end
         end
     end
end

