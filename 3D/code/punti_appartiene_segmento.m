function [ int ] = punti_appartiene_segmento( P,A,B )

%per valutare l'appartenenza lavoro sulle tre coordinate x,y,z e trovo
%delle ascissa curvilinee per tali coordinate, facendo attenzione ai casi
%paralleli dove si imposta un valore di default inf. se t1,t2 e t3
%coincidono e il valore è compreso tra 0 ed 1 allora il punto appartiene al
%segmento.

int=0;
if A(1)==B(1) 
    if P(1)==A(1) 
        t1=inf; 
    else 
        return 
    end
else
    t1=(P(1)-A(1))/(B(1)-A(1));
end

if A(2)==B(2)
    if P(2)==A(2)
        t2=inf;
    else
        return
    end
else
    t2=(P(2)-A(2))/(B(2)-A(2));
end

if A(3)==B(3)
    if P(3)==A(3)
        t3=inf;
    else
        return
    end
else
    t3=(P(3)-A(3))/(B(3)-A(3));
end

if t1==inf 
    if t2==inf
        if (t3>=0 && t3<=1)
            int=1;
        end
            
    elseif t3==inf
        if (t2>=0 && t2<=1)
            int=1;
        end
    else
        
        if ((t2==t3)&&(t2>=0 && t2<=1))
            int=1;
        end
    end
elseif t2==inf
    if t3==inf
        if (t1>=0 && t1<=1)
            int=1;
        end
    else
        
        if ((t1==t3) && (t1>=0 && t1<=1))
            int=1;
        end
    end
elseif t3==inf
    if ((t1==t2) && (t1>=0 && t1<=1))
        int=1;
    end
else
    if ((t1==t2) && (t2==t3) && (t1>=0 && t1<=1))
        int=1;
    end
end
    

end

