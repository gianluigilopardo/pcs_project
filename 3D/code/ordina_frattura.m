function [ indice_punti,punti_fratt ] = ordina_frattura( punti_fratt,punti_provv )

%punti_provv sono i punti provvisori che andrò ad inserire in quelli
%definitivi punti_fratt

lun1=size(punti_fratt,1);
lun2=size(punti_provv,1);
indice_punti=[];

for i=1:lun2
    flag=0;
    for j=1:lun1
        if punti_provv(i,:) == punti_fratt(j,:) %se il punto appartiene già a punti_fratt, salvo l'indice del punto
            lun_indice=length(indice_punti);
            indice_punti(lun_indice+1)=j;
            flag=1;
        end
    end
    if flag==0 %nel caso in cui il punto non appartiene invece a punti_fratt lo inserisco e salvo il nuovo indice L+1
            
            L=size(punti_fratt,1);
            punti_fratt(L+1,:)=punti_provv(i,:);
            lun_indice=length(indice_punti);
            indice_punti(lun_indice+1)=L+1;
    end
end


end

