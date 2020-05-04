function [ facce_vicini ] = Ordina_facce_vicini( facce_vicini,facce )
lun1=size(facce,1);
lun2=size(facce_vicini,1);

%controllo se la faccia appartiene già, se non appartiene la aggiungo

for i=1:lun1
    flag=0;
    for j=1:lun2
        if sort(facce(i,:))==sort(facce_vicini(j,:))
            flag=1;
        end
    end

    if flag==0
            L=size(facce_vicini,1);
            facce_vicini(L+1,:)=facce(i,:);
    end

end
end

