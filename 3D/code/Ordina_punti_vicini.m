function [ punti_vicini] = Ordina_punti_vicini( punti_vicini,punti_provv )
lun1=length(punti_provv);
lun2=length(punti_vicini);

%controllo che il nodo in condivisione tra un vicino e il tetraedro
%intersecato non appartenga già a punti_vicini:
%se appartiene ne salvo l'indice, se non appartiene lo aggiungo 

for i=1:lun1
    flag=0;
    for j=1:lun2
        if punti_provv(i) == punti_vicini(j) 
            flag=1;
        end
    end
    if flag==0
            
            L=length(punti_vicini);
            punti_vicini(L+1)=punti_provv(i);
            
    end
end
end

