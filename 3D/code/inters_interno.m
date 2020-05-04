function [int] = inters_interno(P,A,B,tanP)

tanAB=(B-A);
int=0;
if norm(cross(tanAB,tanP))>eps %escludo i vettori paralleli

    %voglio trovare l'equazione cartesiana della retta AB e della retta che
    %passa per P con direzione tanP

    if tanP(1)==0
        if tanP(2)==0
            A_mat=[1 0 0; 0 1 0];
            b=[P(1) P(2)];
        elseif tanP(3)==0
            A_mat=[1 0 0; 0 0 1];
            b=[P(1) P(3)];
        else
            A_mat=[1 0 0;0 1/(tanP(2)) -1/(tanP(3))];
            b=[P(1) P(2)/tanP(2)-P(3)/tanP(3)];
        end
    elseif tanP(2)==0
        if tanP(3)==0
            A_mat=[0 1 0; 0 0 1];
            b=[P(2) P(3)];
        else
            A_mat=[0 1 0;1/(tanP(1)) 0 -1/(tanP(3))];
            b=[P(2) P(1)/tanP(1)-P(3)/tanP(3)];
        end
    elseif tanP(3)==0
        A_mat=[0 0 1; 1/(tanP(1)) -1/(tanP(2)) 0];
        b=[P(3) P(1)/tanP(1)-P(2)/tanP(2)];
    else
        A_mat=[1/(tanP(1)) -1/(tanP(2)) 0; 1/(tanP(1)) 0 -1/(tanP(3))];
        b=[P(1)/tanP(1)-P(2)/tanP(2) P(1)/tanP(1)-P(3)/tanP(3)]; 
    end

    if tanAB(1)==0
        if tanAB(2)==0
            A_mat(3:4,:)=[1 0 0; 0 1 0];
            b(3:4)=[A(1) A(2)];
        elseif tanAB(3)==0
            A_mat(3:4,:)=[1 0 0; 0 0 1];
            b(3:4)=[A(1) A(3)];
        else
            A_mat(3:4,:)=[1 0 0;0 1/(tanAB(2)) -1/(tanAB(3))];
            b(3:4)=[A(1) A(2)/tanAB(2)-A(3)/tanAB(3)];
        end
    elseif tanAB(2)==0
        if tanAB(3)==0
            A_mat(3:4,:)=[0 1 0; 0 0 1];
            b(3:4)=[A(2) A(3)];
        else
            A_mat(3:4,:)=[0 1 0;1/(tanAB(1)) 0 -1/(tanAB(3))];
            b(3:4)=[A(2) A(1)/tanAB(1)-A(3)/tanAB(3)];
        end
    elseif tanAB(3)==0
        A_mat(3:4,:)=[0 0 1; 1/(tanAB(1)) -1/(tanAB(2)) 0];
        b(3:4)=[A(3) A(1)/tanAB(1)-A(2)/tanAB(2)];
    else
        A_mat(3:4,:)=[1/(tanAB(1)) -1/(tanAB(2)) 0; 1/(tanAB(1)) 0 -1/(tanAB(3))];
        b(3:4)=[A(1)/tanAB(1)-A(2)/tanAB(2) A(1)/tanAB(1)-A(3)/tanAB(3)]; 
    end

    %si imposta un sistema di quattro equazioni in tre incognite, il quale è ben definito, dove ogni
    %equazione è quella di un piano

    PP=A_mat\b'; %trovo il punto di intersezione tra le due rette, le quali ho espresso in forma parametrica
    
    %t sarà l'ascissa curvilinea del punto di intersezione rispetto alla
    %semiretta
    
    if tanP(1)~=0
        t=(PP(1)-P(1))/tanP(1);
    elseif tanP(2)~=0
        t=(PP(2)-P(2))/tanP(2);
    elseif tanP(3)~=0
        t=(PP(3)-P(3))/tanP(3);
    end

    %tAB sarà l'ascissa curvilinea del punto di intersezione rispetto al lato
    %AB

    if tanAB(1)~=0 
        tAB=(PP(1)-A(1))/tanAB(1);
    elseif tanAB(2)~=0
        tAB=(PP(2)-A(2))/tanAB(2);
    elseif tanAB(3)~=0
        tAB=(PP(3)-A(3))/tanAB(3);
    end

    if (t>0 && tAB>=0 && tAB<=1) %t deve essere maggiore di zero perché sto considerando una semiretta. tAB compreso tra 0 ed 1 poiché il punto deve appartenere al lato
        if (norm(PP-A)<eps || norm(PP-B)<eps) %è il caso in cui il punto di intersezione è un vertice del lato AB
            int=0.5;
        else
            int=1;
        end
    end
    
end

end