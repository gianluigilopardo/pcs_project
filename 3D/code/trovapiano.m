function [ n,d ] = trovapiano( n_punti,indice_punti,punti )

n=[0 0 0]; %sarà il vettore medio normale al piano
d=0;       %parametrizzando il piano come ax+by+cz+d=0


for i=1:n_punti
    
    for j=i+1:n_punti
        
        for k=j+1:n_punti
            
            V1=punti(indice_punti(j),:)-punti(indice_punti(i),:); 
            V2=punti(indice_punti(k),:)-punti(indice_punti(i),:);
            
            %V1 e V2 sono i vettori formati dai vertici della frattura che
            %servono ad individuare il piano
            
            n=cross(V1,V2)+n;
            
        end
    end     
end

n=n/nchoosek(n_punti,2); %si fa una media di tutti i versoli normali considerati

for i=1:n_punti
    d=-n(1)*punti(indice_punti(i),1)-n(2)*punti(indice_punti(i),2)-n(3)*punti(indice_punti(i),3)+0;
    %si ottiene d sostituendo i vertici della frattura nell'equazione del
    %piano
end

d=d/n_punti; %si fa una media dei parametri d ricavati

end