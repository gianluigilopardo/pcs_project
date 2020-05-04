function [punti_intersezione,pos_int,pos_nodi ] = Intersezione_punti( posizionenodi,n,d,i_tetra )

global ele node

punti_intersezione=[];
pos_int=[];
pos=0;
pos_nodi=zeros(1,4);
%individuo i lati con gli indici 1...6 rispettivamente per i lati
%formati dai nodi 1-2,1-3,1-4,2-3,2-4,3-4.
    
%individuo le facce con gli indici 1...4 rispettivamente per le facce
%che contengono i lati (4,5,6),(2,3,6),(1,3,5),(1,2,4), ovvero che non 
%contengono il vertice nella rispettiva posizione: ad esmpio la faccia 1 non contiene in vertice 1.
for j=1:4
   pos_nodi(j)=posizionenodi(ele(i_tetra,j)); %salvo la posizione dei nodi del relativo tetraedro
end


for j=1:3
        for k=j+1:4
            pos=pos+1;
            if posizionenodi(ele(i_tetra,j))*posizionenodi(ele(i_tetra,k))==-1 %in tal caso vi è sicuramente intersezione tra il piano su cui giace la traccia e il lato considerato
                
                P1=node(ele(i_tetra,j),:);
                P2=node(ele(i_tetra,k),:);
                x=size((punti_intersezione),1);
                y=length(pos_int); 
                t=-(P1*n'+d)/((P2-P1)*n'); %trovo l'ascissa curvilinea dell'intersezione parametrizzando i lato P1-P2 in funzione del parametro t              
                punti_intersezione(x+1,:)=P1+t*(P2-P1); %dall'ascissa curvilinea ricavo le coordinate cartesiane del punto d'intersezione
                pos_int(y+1)=pos; %salvo la posizione di tale punto come indicato prima
            end  
        end
end

end

