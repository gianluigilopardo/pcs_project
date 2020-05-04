function [ Facce_pol,indice_facce ] = Ordina_facce( Facce,Facce_pol )

lun1=size(Facce,1);
lun2=size(Facce_pol,1);
indice_facce=[];

for i=1:lun1
    flag=0;
    for j=1:lun2
        if sort(Facce(i,:))==sort(Facce_pol(j,:))
            lun_indice=length(indice_facce);
            indice_facce(lun_indice+1)=j;
            flag=1;
        end
    end

    if flag==0
            L=size(Facce_pol,1);
            Facce_pol(L+1,:)=Facce(i,:);
            lun_indice=length(indice_facce);
            indice_facce(lun_indice+1)=L+1;
    end

end


end

