function [vicini,punti_vicini,lati_vicini,facce_vicini] = Tetra_vicini( tetra_inters )
global ele n_ele
vicini=[];
punti_vicini=[];
lati_vicini=[];
facce_vicini=[];

% serve per individuare i tetraedri vicini ai tetraedri intersecati e per
% salvare quali punti, lati e facce sono condivisi con tali tetraedri

for i=1:n_ele
    if (tetra_inters(i)==1 || tetra_inters(i)==1.5) %se il teraedro è intersecato
        for j=1:n_ele %ciclo nuovamente sui tetraedri
            punti_provv=[];
            if (tetra_inters(j)~=1 && tetra_inters(i)~=1.5) %verifico che il tetraedro non isa intersecato 
                for k=1:4 %ciclo sui nodi del tetraedro
                    
                    %salvo i vertici in comune
                    
                    if ele(i,1)==ele(j,k) %se i tetraedri hanno il primo nodo in comune
                        x=length(punti_provv);
                        punti_provv(x+1)=ele(i,1);
                    end
                    if ele(i,2)==ele(j,k) %se i tetraedri hanno il secondo nodo in comune
                         x=length(punti_provv);
                         punti_provv(x+1)=ele(i,2);
                         
                    end
                    if ele(i,3)==ele(j,k) %se i tetraedri hanno il terzo nodo in comune
                         x=length(punti_provv);
                         punti_provv(x+1)=ele(i,3);
                         
                    end
                    if ele(i,4)==ele(j,k) %se i tetraedri hanno il quarto nodo in comune
                         x=length(punti_provv);
                         punti_provv(x+1)=ele(i,4);
                         
                    end
                end
                
                l=length(punti_provv);
                if l>0 %i tetraedri condiderati hanno almeno un nodo in comune
                    
                    punti_vicini=Ordina_punti_vicini(punti_vicini,punti_provv); %ricavo gli indici dei nodi vicini
                    
                    x=length(vicini);
                    flag=1;
                    
                    for i_c=1:x
                        if vicini(i_c)==j %controllo se il tetraedro non appartiene già ai vicini
                            flag=0;
                        end
                    end
                    if flag==1
                        vicini(x+1)=j; %salvo il vicino
                    end                      
                    
                    
                    if l==2 %i tetraedri condividono un lato
                        
                        lati_vicini=Ordina_lati(lati_vicini,punti_provv);
                        
                    elseif l==3 % i tetraedri condividono una faccia
                        lati_vicini=Ordina_lati(lati_vicini,punti_provv(1:2)); %salvo il primo lato 1-2
                        lati_vicini=Ordina_lati(lati_vicini,punti_provv(2:3)); %salvo il secondo lato 2-3
                        lati_vicini=Ordina_lati(lati_vicini,punti_provv(1:2:3)); %salvo il terzo lato 1-3
                        facce_vicini=Ordina_facce_vicini(facce_vicini,punti_provv); %salvo la faccia
                    end
                end
            end
        end
    end
end

