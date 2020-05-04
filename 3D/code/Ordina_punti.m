function [ punti_pol,indice_punti ] = Ordina_punti( punti_pol,punti_intersezione,i_tetra )

global node ele
lun1=size(punti_intersezione,1);
lun2=size(punti_pol,1);
indice_punti=[];

%inizialmente ordino i 4 vertici del tetraedro e ricavo dalle veriabili
%globali

for i=1:4
    flag=0;
    
    for j=1:lun2
        if node(ele(i_tetra,i),:) == punti_pol(j,:)
            lun_indice=length(indice_punti);
            indice_punti(lun_indice+1)=j;
            flag=1;
        end
    end
    if flag==0
            L=size(punti_pol,1);
            punti_pol(L+1,:)=node(ele(i_tetra,i),:);
            lun_indice=length(indice_punti);
            indice_punti(lun_indice+1)=L+1;
    end
end

%dopoché ordino i punti di intersezione

for i=1:lun1
    flag=0;
    for j=1:lun2
        if punti_intersezione(i,:) == punti_pol(j,:)
            lun_indice=length(indice_punti);
            indice_punti(lun_indice+1)=j;
            flag=1;
        end
    end
    if flag==0
            
            L=size(punti_pol,1);
            punti_pol(L+1,:)=punti_intersezione(i,:);
            lun_indice=length(indice_punti);
            indice_punti(lun_indice+1)=L+1;
    end
end

