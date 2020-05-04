function [ PP ] = intersezione_segmenti( P1,P2,Z1,Z2)

%analogo a inters_interno, con la differenza che qui considera due segmenti
%e lì un segmento ed una semiretta

Tan1=(P2-P1);
Tan2=(Z2-Z1);
int=0;

if norm(cross(Tan1,Tan2))>eps %escludo i vettori paralleli
    if tan1(1)==0
       if tan1(2)==0
           A_mat=[1 0 0; 0 1 0];
           b=[P1(1) P1(2)];
        elseif Tan1(3)==0
            A_mat=[1 0 0; 0 0 1];
            b=[P1(1) P1(3)];
       else
            A_mat=[1 0 0;0 1/(Tan1(2)) -1/(Tan1(3))];
            b=[P1(1) P1(2)/Tan1(2)-P1(3)/Tan1(3)];
       end
    elseif Tan1(2)==0
        if Tan1(3)==0
            A_mat=[0 1 0; 0 0 1];
            b=[P1(2) P1(3)];
        else
            A_mat=[0 1 0;1/(Tan1(1)) 0 -1/(Tan1(3))];
            b=[P1(2) P1(1)/Tan1(1)-P1(3)/Tan1(3)];
        end
    elseif Tan1(3)==0
        A_mat=[0 0 1; 1/(Tan1(1)) -1/(Tan1(2)) 0];
        b=[P1(3) P1(1)/Tan1(1)-P1(2)/Tan1(2)];
    else
        A_mat=[1/(Tan1(1)) -1/(Tan1(2)) 0; 1/(Tan1(1)) 0 -1/(Tan1(3))];
        b=[P1(1)/Tan1(1)-P1(2)/Tan1(2) P1(1)/Tan1(1)-P1(3)/Tan1(3)]; 
    end

    if Tan2(1)==0
        if Tan2(2)==0
            A_mat(3:4,:)=[1 0 0; 0 1 0];
            b(3:4)=[Z1(1) Z1(2)];
        elseif Tan2(3)==0
            A_mat(3:4,:)=[1 0 0; 0 0 1];
            b(3:4)=[Z1(1) Z1(3)];
        else
            A_mat(3:4,:)=[1 0 0;0 1/(Tan2(2)) -1/(Tan2(3))];
            b(3:4)=[Z1(1) Z1(2)/Tan2(2)-Z1(3)/Tan2(3)];
        end
    elseif Tan2(2)==0
        if Tan2(3)==0
            A_mat(3:4,:)=[0 1 0; 0 0 1];
            b(3:4)=[Z1(2) Z1(3)];
        else
            A_mat(3:4,:)=[0 1 0;1/(Tan2(1)) 0 -1/(Tan2(3))];
            b(3:4)=[Z1(2) Z1(1)/Tan2(1)-Z1(3)/Tan2(3)];
        end
    elseif Tan2(3)==0
        A_mat(3:4,:)=[0 0 1; 1/(Tan2(1)) -1/(Tan2(2)) 0];
        b(3:4)=[Z1(3) Z1(1)/Tan2(1)-Z1(2)/Tan2(2)];
    else
        A_mat(3:4,:)=[1/(Tan2(1)) -1/(Tan2(2)) 0; 1/(Tan2(1)) 0 -1/(Tan2(3))];
        b(3:4)=[Z1(1)/Tan2(1)-Z1(2)/Tan2(2) Z1(1)/Tan2(1)-Z1(3)/Tan2(3)]; 
    end

    %si è difenito il sistema di quattro equzioni in tre incognite

    PP=A_mat\b'; %trovo il punto di intersezione tra le due rette, le quali ho espresso in forma parametrica

    %trovo t1 e t2 che sono le ascisse curvilinee del punto PP rispetto ai due
    %lati considerati

    if tanP(1)~=0
        t1=(PP(1)-P1(1))/Tan1(1);
    elseif tanP(2)~=0
        t1=(PP(2)-P1(2))/Tan1(2);
    elseif tanP(3)~=0
        t1=(PP(3)-P1(3))/Tan1(3);
    end

    if tanAB(1)~=0
        t2=(PP(1)-Z1(1))/Tan2(1);
    elseif tanAB(2)~=0
        t2=(PP(2)-Z1(2))/Tan2(2);
    elseif tanAB(3)~=0
        t2=(PP(3)-Z1(3))/Tan2(3);
    end

    if (t1>=0 && t1<=1) && (t2>=0 && t2<=1) %l'intersezione avviene effettivamente, poiché il punto appartiene ad i lati considerati
        int=1;
    end
end

if int~=1 %non avviene intersezione
    PP=0; %valore di default di PP in tale caso
end

end

