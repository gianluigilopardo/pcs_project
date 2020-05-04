function [ Lati_pol,indice_lati ] = Ordina_lati( Lati_pol,Lati )

lun1=size(Lati,1);
lun2=size(Lati_pol,1);
indice_lati=[];

%controllo che il lato non appartenga già a Lati_poli:
%se appartiene ne salvo l'indice, se non appartiene lo aggiungo e salvo il nuovo indice L+1 

for i=1:lun1
    flag=0;
    for j=1:lun2
        if sort(Lati(i,:))==sort(Lati_pol(j,:))
            lun_indice=length(indice_lati);
            indice_lati(lun_indice+1)=j;
            flag=1;
        end
    end

    if flag==0
            L=size(Lati_pol,1);
            Lati_pol(L+1,:)=Lati(i,:);
            lun_indice=length(indice_lati);
            indice_lati(lun_indice+1)=L+1;
    end

end

