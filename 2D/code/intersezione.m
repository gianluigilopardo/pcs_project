function  [alfa,P,tT,t1,t2]  = intersezione( XE1,YE1,XE2,YE2,i_traccia )

global punti tracce
P=0;
tT=inf;
t1=inf;
t2=inf;
TE1=[XE2-XE1 YE2-YE1]; %vettore tangente il lato


XT1=punti(tracce(i_traccia,2),2); %ascissa primo nodo della traccia
XT2=punti(tracce(i_traccia,3),2); %ascissa secondo nodo della traccia

YT1=punti(tracce(i_traccia,2),3); %ordinata primo nodo della traccia
YT2=punti(tracce(i_traccia,3),3); %ordinata sedcondo nodo della traccia

TT=[XT2-XT1 YT2-YT1]; %vettore tangente la traccia

alfa=0;


if norm(cross([TE1 0],[TT 0]))<=eps %vettori paralleli
    if XE1==XE2 % lato parallelo asse x
        if XT1==XE1 %lato e traccia sono coincidenti
            
            t1=(YT1-YE1)/(YE2-YE1);
            t2=(YT2-YE1)/(YE2-YE1);
            alfa=-2;
            
        end
    end
    
    if YE1==YE2 % lato parallelo asse y
        if YT1==YE1 %lato e traccia sono coincidenti
            
            t1=(XT1-XE1)/(XE2-XE1);
            t2=(XT2-XE1)/(XE2-XE1);
            alfa=-2;
            
        end
    end
    
    if abs((YT1-YE1)/(YE2-YE1)-(XT1-XE1)/(XE2-XE1))<=eps %lato e traccia coincidenti nel caso generale
        
        t1=(XT1-XE1)/(XE2-XE1);
        t2=(XT2-XE1)/(XE2-XE1);
        alfa=-2;
            
    end
        
    if (alfa==-2 && ((t1>0 && t1<1) || (t2>0 && t2<1))) % la traccia ricopre solo parzialemente il lato, dunque vi è intersezione
        
        alfa=2;
        %potrebbe essere importante sapere quale (o quali) sono i punti di
        %intersezione, ovvero dove termina la traccia
        
    end
    
end


if norm(cross([TE1 0],[TT 0]))>0 %esclude i vettori paralleli
    
    if (XT1==XT2 && (XE1-XT1)*(XE2-XT1)<=0) %posta la traccia parallela l'asse x, esclude gli "estremi concordi"
        
        P=[XT1 YE1+(YE2-YE1)*(XT1-XE1)/(XE2-XE1)]'; %punto di intersezione tra la 
                                                   %retta tengente il lato e quella tangente la traccia    
        
        alfa=0.2;                                        
    end
    
    
    if (YT1==YT2 && (YE1-YT1)*(YE2-YT1)<=0) %posta la traccia parallela l'asse y, esclude gli "estremi concordi"
        
        P=[XE1+(XE2-XE1)*(YT1-YE1)/(YE2-YE1) YT1]'; %punto di intersezione tra la retta 
                                                   %tengente il lato e quella tangente la traccia
        alfa=0.2;
                                                   
    end
    
    if (XT1~=XT2 && YT1~=YT2 && ((YE1-YT1)/(YT2-YT1)-(XE1-XT1)/(XT2-XT1))*((YE2-YT1)/(YT2-YT1)-(XE2-XT1)/(XT2-XT1))<=0) %posta la traccia non parallela gli assi esclude gli estremi concordi
       
        %distinguo tre casi: lato parallelo asse x, lato parallelo
        %asse y e lato non parallelo gli assi
        
        if XE1==XE2
            P=[XE1 YT1+(XE1-XT1)*(YT2-YT1)/(XT2-XT1)]';
            alfa=0.2;
        end
        
        if YE1==YE2
            P=[XT1+(YE1-YT1)*(XT2-XT1)/(YT2-YT1) YE2]';
            alfa=0.2;
        end
            
        %imposto il sistema per l'intersezione tra le due rette(quella
        %tangente il lato e quella tangente la traccia)
       if (XE1~=XE2 && YE1~=YE2)
           
           A=[-1/(XE2-XE1) 1/(YE2-YE1); -1/(XT2-XT1) 1/(YT2-YT1)]; %matrice per risolvere il sistema
           b=[YE1/(YE2-YE1)-XE1/(XE2-XE1); YT1/(YT2-YT1)- XT1/(XT2-XT1)]; %vettore per la risoluzione
           P=A\b; %trovo il punto di intersezione
           alfa=0.2;
       end
    end
end

if alfa==0.2 %ho trovato una possibile intersezione tra traccia e lato
    
    tE=(P(1)-XE1)/(XE2-XE1); %tE è il valore per cui P appartiene alla retta parallela al lato
    tT=(P(1)-XT1)/(XT2-XT1); %tt è il valore per cui P appartiene alla retta parallela alla traccia
    
    if isnan(tE)
        tE=(P(2)-YE1)/(YE2-YE1);
    end
    
    if isnan(tT)
        tT=(P(2)-YT1)/(YT2-YT1);
    end
    
end

%il valore tE è sempre compreso tra 0 ed 1, poiché si escludono le
%intersezione in cui tale valore potrebbe essere minore di 0 o maggiore di 1

if (alfa==0.2 && tT>=0 && tT<=1 && tE>0 && tE<1) % vi è intersezione tra il lato e la traccia in un punto P generico esclusi i vertici
    
    alfa=1;
    
end

if (alfa==0.2 && tT>=0 && tT<=1 && (tE==0 || tE==1)) %vi è intersezione tra un vertice del lato e la traccia
    
    alfa=0.5;
    
end


if (alfa==1 && (tT==0 || tT==1)) %l'intersezione avviene tra punto generico del triangolo e tra un vertice della traccia

    alfa=1.25;
    
end

if (alfa==0.5 && (tT==0 || tT==1)) %l'intersezione avviene tra un vertice del triangolo e tra un vertice della traccia

    alfa=0.6;
    
end

if alfa<0.2 %non vi è né intersezione né possibile intersezione tra lato e traccia 
    
    P=0;
    
end
