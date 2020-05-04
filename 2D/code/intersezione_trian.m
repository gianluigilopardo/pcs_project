function [ beta,sottopoligoni3,sottopoligoni4,triangolazione,tT_1,tT_2,tT_3,prolungo ] = intersezione_trian( i_trian,i_traccia,sottopoligoni3,sottopoligoni4,triangolazione)

global ele node neigh punti tracce

s = zeros(3,2);
s(1,:) = node(ele(i_trian, 2), 2:3);
s(2,:) = node(ele(i_trian, 3), 2:3);
s(3,:) = node(ele(i_trian, 4), 2:3); 
prolungo=0;      

[a1,P1,tT_1,tP1,tP2] = intersezione(s(1,1), s(1,2), s(2,1), s(2,2), i_traccia); %calcola il valore a1 della possibile intersezione col primo lato
    
if a1~=2 %se la traccia e il primo lato non sono paralleli
        
    [a2,P2,tT_2,tP1,tP2] = intersezione(s(2,1), s(2,2), s(3,1), s(3,2),i_traccia); %%calcola il valore a2 possibile intersezione col secondo lato
        
    if a2~=2    %se la traccia non è parallela al secondo lato
             
       [a3,P3,tT_3,tP1,tP2] = intersezione(s(3,1), s(3,2), s(1,1), s(1,2),i_traccia); %calcola il valore a3 della possibile interesezione col terzo lato
            
    else
        a3=0;     
 
    end
    
else
    a2=0;
    a3=0;
        
end
    
%considero prima i casi di intersezione "classica": punto-punto o
%punto-vertice

beta=-1; %che contrassegna una non intersezione
  
if ((a1==1||a1==1.25) && (a2==1||a2==1.25) && a3==0) %l'intersezione avviene tra un punto del primo lato ed uno del secondo

    beta=1;
    
    lun4=size((sottopoligoni4),1);
    lun3=size((sottopoligoni3),1);
    lunsot=size((triangolazione),1);
        
    sottopoligoni4(lun4+1,:)=[node(ele(i_trian,2),2:3),node(ele(i_trian,4),2:3),P2',P1'];
    sottopoligoni3(lun3+1,:)=[P1',P2',node(ele(i_trian,3),2:3)];
        
    triangolazione(lunsot+1,:)=[node(ele(i_trian,2),2:3),P1',P2'];
    triangolazione(lunsot+2,:)=[node(ele(i_trian,2),2:3),node(ele(i_trian,4),2:3),P2'];
    return
        
end
    
if ((a1==1||a1==1.25) && a2==0 && (a3==1||a3==1.25)) %l'intersezione avviene tra un punto del primo lato ed uno del terzo
        
    beta=1;
    
    lun4=size((sottopoligoni4),1);
    lun3=size((sottopoligoni3),1);
    lunsot=size((triangolazione),1);
        
    sottopoligoni4(lun4+1,:)=[node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3),P3',P1'];
    sottopoligoni3(lun3+1,:)=[P1',P3',node(ele(i_trian,2),2:3)];
        
    triangolazione(lunsot+1,:)=[node(ele(i_trian,3),2:3),P1',P3'];
    triangolazione(lunsot+2,:)=[node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3),P3'];
    return    
    
end
    
if (a1==0 && (a2==1||a2==1.25) && (a3==1||a3==1.25)) %l'intersezione avviene tra un punto del secondo lato ed uno del terzo
        
    beta=1;
    
    lun4=size((sottopoligoni4),1);
    lun3=size((sottopoligoni3),1);
    lunsot=size((triangolazione),1);
        
    sottopoligoni4(lun4+1,:)=[node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3),P2',P3'];
    sottopoligoni3(lun3+1,:)=[P2',P3',node(ele(i_trian,4),2:3)];
        
    triangolazione(lunsot+1,:)=[node(ele(i_trian,2),2:3),P2',P3'];
    triangolazione(lunsot+2,:)=[node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3),P2'];
    return
    
end
     

if((a1==0.5||a1==0.6) && (a2==1||a2==1.25) && (a3==0.5||a3==0.6)) %intersezione con secondo lato e secondo vertice
        
    beta=1;
    
    lun3=size((sottopoligoni3),1);
    sottopoligoni3(lun3+1,:)=[node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3),P2'];
    sottopoligoni3(lun3+2,:)=[node(ele(i_trian,2),2:3),node(ele(i_trian,4),2:3),P2'];
    return
    
end
    
if((a1==1||a1==1.25) && (a2==0.5||a2==0.6) && (a3==0.5||a3==0.6)) %intersezione con primo lato e primo vertice
        
    beta=1;
    
    lun3=size((sottopoligoni3),1);
    sottopoligoni3(lun3+1,:)=[node(ele(i_trian,2),2:3),node(ele(i_trian,4),2:3),P1'];
    sottopoligoni3(lun3+2,:)=[node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3),P1'];
    return
    
end
    
if((a1==0.5||a1==0.6) && (a2==0.5||a2==0.6) && (a3==1||a3==1.25)) %intersezione con terzo lato e terzo vertice

    beta=1;
    
    lun3=size((sottopoligoni3),1);
    sottopoligoni3(lun3+1,:)=[node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3),P3'];
    sottopoligoni3(lun3+2,:)=[node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3),P3'];
    return
    
end
   
        
%studio i casi in cui vi è intersezione tra la traccia ed il triangolo, ma
%un estremo rimane all'interno del triangolo e bisogna prolungare la
%traccia


if (a1==1 || (a1==1.25 && ((tT_1==0 && interno(node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3),punti(tracce(i_traccia,3),2:3))==1) ...
                        || (tT_1==1 && interno(node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3),punti(tracce(i_traccia,2),2:3))==1))))  %vi è intersezione tra un punto della traccia e il primo lato
    
    if (a2==0.2 && a3==0) %il possibile punto d'intersezione avviene col secondo lato
        
        beta=1;
        lunsot=size((triangolazione),1);
       
        %creo la sottotriangolazione interna
       
        triangolazione(lunsot+1,:)=[P1',P2',node(ele(i_trian,2),2:3)];
        triangolazione(lunsot+2,:)=[P1',P2',node(ele(i_trian,3),2:3)];
        triangolazione(lunsot+3,:)=[P2',node(ele(i_trian,2),2:3),node(ele(i_trian,4),2:3)];
      
        %inoltre devo andare anche a sottotriangolizzare il triangolo
        %adiacente al punto di intersezione per mantenere la
        %sottotriangolarizzazione conforme
        
       if neigh(i_trian,2)==-1
           
           return
           
       else
           
           prolungo=neigh(i_trian,2);
           for j=2:4
               
               if i_trian==neigh(neigh(i_trian,2),j)
                   
                   lunsot=size((triangolazione),1);
                   
                   triangolazione(lunsot+1,:)=[node(ele(neigh(i_trian,2),j),:),node(ele(i_trian,3),2:3),P2'];
                   triangolazione(lunsot+2,:)=[node(ele(neigh(i_trian,2),j),:),node(ele(i_trian,4),2:3),P2'];
                   
                   return
               end
           end
       end
        
        
    end
    
    if (a2==0 && a3==0.2) %il possibile punto d'intersezione avviene col terzo lato
        
        beta=1;
        lunsot=size((triangolazione),1);
       
        %creo la sottotriangolazione interna
       
        triangolazione(lunsot+1,:)=[P1',P3',node(ele(i_trian,2),2:3)];
        triangolazione(lunsot+2,:)=[P1',P3',node(ele(i_trian,3),2:3)];
        triangolazione(lunsot+3,:)=[P3',node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3)];
      
        %inoltre devo andare anche a sottotriangolizzare il triangolo
        %adiacente al punto di intersezione per mantenere la
        %sottotriangolarizzazione conforme
        
       if neigh(i_trian,3)==-1
           
           return
           
       else
           
           prolungo=neigh(i_trian,3);
           for j=2:4
               
               if i_trian==neigh(neigh(i_trian,3),j)
                   
                   lunsot=size((triangolazione),1);
                   
                   triangolazione(lunsot+1,:)=[node(ele(neigh(i_trian,3),j),:),node(ele(i_trian,2),2:3),P3'];
                   triangolazione(lunsot+2,:)=[node(ele(neigh(i_trian,3),j),:),node(ele(i_trian,4),2:3),P3'];
                   
                   return
               end
           end
       end
    end
    
    if (a2==0.2 && a3==0.2) %il possibile punto d'intersezione avviene col terzo vertice

        beta=1;
        lunsot=size((triangolazione),1);
        
        triangolazione(lunsot+1,:)=[P1',node(ele(i_trian,2),2:3),node(ele(i_trian,4),2:3)];
        triangolazione(lunsot+2,:)=[P1',node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3)];
        
        return
    
    end
end


if (a2==1 || (a2==1.25 && ((tT_2==0 && interno(node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3),punti(tracce(i_traccia,3),2:3))==1) ...
                        || (tT_2==1 && interno(node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3),punti(tracce(i_traccia,2),2:3))==1)))) %vi è intersezione tra un punto generico della traccia e il secondo lato
    if (a1==0.2 && a3==0) %il possibile punto d'intersezione avviene col primo lato
        
        beta=1;
        lunsot=size((triangolazione),1);
       
        %creo la sottotriangolazione interna
       
        triangolazione(lunsot+1,:)=[P1',P2',node(ele(i_trian,2),2:3)];
        triangolazione(lunsot+2,:)=[P1',P2',node(ele(i_trian,3),2:3)];
        triangolazione(lunsot+3,:)=[P2',node(ele(i_trian,2),2:3),node(ele(i_trian,4),2:3)];
      
        %inoltre devo andare anche a sottotriangolare il triangolo
        %adiacente al punto di intersezione per mantenere la
        %sottotriangolarizzazione conforme
        
       if neigh(i_trian,4)==-1
           
           return
           
       else
           
           prolungo=neigh(i_trian,4);
           for j=2:4
               
               if i_trian==neigh(neigh(i_trian,4),j)
                   
                   lunsot=size((triangolazione),1);
                   
                   triangolazione(lunsot+1,:)=[node(ele(neigh(i_trian,4),j),:),node(ele(i_trian,2),2:3),P1'];
                   triangolazione(lunsot+2,:)=[node(ele(neigh(i_trian,4),j),:),node(ele(i_trian,3),2:3),P1'];
                   
                   return
               end
           end
       end
    end
    
    if (a1==0 && a3==0.2) %il possibile punto d'intersezione avviene col terzo lato
        
        beta=1;
        lunsot=size((triangolazione),1);
       
        %creo la sottotriangolazione interna
       
        triangolazione(lunsot+1,:)=[P2',P3',node(ele(i_trian,2),2:3)];
        triangolazione(lunsot+2,:)=[P2',P3',node(ele(i_trian,4),2:3)];
        triangolazione(lunsot+3,:)=[P2',node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3)];
      
        %inoltre devo andare anche a sottotriangolare il triangolo
        %adiacente al punto di intersezione per mantenere la
        %sottotriangolazazione conforme
        
        if neigh(i_trian,3)==-1
            
            return
            
        else
           
            prolungo=neigh(i_trian,3);
            for j=2:4
               
                if i_trian==neigh(neigh(i_trian,3),j)
                   
                    lunsot=size((triangolazione),1);
                   
                    triangolazione(lunsot+1,:)=[node(ele(neigh(i_trian,3),j),:),node(ele(i_trian,2),2:3),P3'];
                    triangolazione(lunsot+2,:)=[node(ele(neigh(i_trian,3),j),:),node(ele(i_trian,4),2:3),P3'];
                   
                    return
                end
            end
        end   
     end
    
    if (a1==0.2 && a3==0.2) %il possibile punto d'intersezione avviene col primo vertice

        beta=1;
        lunsot=size((triangolazione),1);
        
        triangolazione(lunsot+1,:)=[P2',node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3)];
        triangolazione(lunsot+2,:)=[P2',node(ele(i_trian,2),2:3),node(ele(i_trian,4),2:3)];
       
        return
        
    end
end


if (a3==1 || (a3==1.25 && ((tT_3==0 && interno(node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3),punti(tracce(i_traccia,3),2:3))==1) ...
                        || (tT_3==1 && interno(node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3),punti(tracce(i_traccia,2),2:3))==1)))) %vi è intersezione tra un punto generico della traccia e il terzo lato
    if (a1==0.2 && a2==0) %il possibile punto d'intersezione avviene col primo lato
        
        beta=1;
        lunsot=size((triangolazione),1);
       
        %creo la sottotriangolazione interna
       
        triangolazione(lunsot+1,:)=[P1',P3',node(ele(i_trian,2),2:3)];
        triangolazione(lunsot+2,:)=[P1',P3',node(ele(i_trian,3),2:3)];
        triangolazione(lunsot+3,:)=[P3',node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3)];
      
        %inoltre devo andare anche a sottotriangolizzare il triangolo
        %adiacente al punto di intersezione per mantenere la
        %sottotriangolarizzazione conforme
        
       if neigh(i_trian,4)==-1
           
           return
       
       else
           
           prolungo=neigh(i_trian,4);
           for j=2:4
               
               if i_trian==neigh(neigh(i_trian,4),j)
                   
                   lunsot=size((triangolazione),1);
                   
                   triangolazione(lunsot+1,:)=[node(ele(neigh(i_trian,4),j),:),node(ele(i_trian,2),2:3),P1'];
                   triangolazione(lunsot+2,:)=[node(ele(neigh(i_trian,4),j),:),node(ele(i_trian,3),2:3),P1'];
                   
                   return
               end
           end
       end
        
    end
    
    if (a1==0 && a2==0.2) %il possibile punto d'intersezione avviene col secondo lato
        
        beta=1;
        lunsot=size((triangolazione),1);
       
        %creo la sottotriangolazione interna
       
        triangolazione(lunsot+1,:)=[P2',P3',node(ele(i_trian,2),2:3)];
        triangolazione(lunsot+2,:)=[P2',P3',node(ele(i_trian,4),2:3)];
        triangolazione(lunsot+3,:)=[P2',node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3)];
      
        %inoltre devo andare anche a sottotriangolizzare il triangolo
        %adiacente al punto di intersezione per mantenere la
        %sottotriangolarizzazione conforme
        
      if neigh(i_trian,2)==-1
          
          return
          
      else
           
           prolungo=neigh(i_trian,2);
           for j=2:4
               
               if i_trian==neigh(neigh(i_trian,2),j)
                   
                   lunsot=size((triangolazione),1);
                   
                   triangolazione(lunsot+1,:)=[node(ele(neigh(i_trian,2),j),:),node(ele(i_trian,3),2:3),P2'];
                   triangolazione(lunsot+2,:)=[node(ele(neigh(i_trian,2),j),:),node(ele(i_trian,4),2:3),P2'];
                   
                   return
               end
           end
       end
        
    end
    
    if (a1==0.2 && a2==0.2) %il possibile punto d'intersezione avviene col secondo vertice

        beta=1;
        lunsot=size((triangolazione),1);
        
        triangolazione(lunsot+1,:)=[P3',node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3)];
        triangolazione(lunsot+2,:)=[P3',node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3)];
       
        return
        
    end
end



if ((a1==0.5 && a2==0.5 && a3==0.2) || ((a1==0.6 && a2==0.6 && a3==0.2)&&((tT_1==0 && interno(node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3),punti(tracce(i_traccia,3),2:3))==1) ...
                                                                       || (tT_1==1 && interno(node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3),punti(tracce(i_traccia,2),2:3))==1)))) %intersezione tra la traccia ed il secondo vertice + possibile intersezione con il terzo lato, il che equivale a dire che la traccia è interna al triangolo

    beta=1;
    lunsot=size((triangolazione),1);
    
    triangolazione(lunsot+1,:)=[node(ele(i_trian,3),2:3),node(ele(i_trian,2),2:3),P3'];
    triangolazione(lunsot+2,:)=[node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3),P3'];
    
    %inoltre devo andare anche a sottotriangolizzare il triangolo
    %adiacente al punto di intersezione per mantenere la
    %sottotriangolarizzazione conforme
        
    if neigh(i_trian,3)==-1
        
        return
        
    else
        
        prolungo=neigh(i_trian,3);
        for j=2:4
               
            if i_trian==neigh(neigh(i_trian,3),j)
                   
                lunsot=size((triangolazione),1);
                   
                triangolazione(lunsot+1,:)=[node(ele(neigh(i_trian,3),j),:),node(ele(i_trian,2),2:3),P3'];
                triangolazione(lunsot+2,:)=[node(ele(neigh(i_trian,3),j),:),node(ele(i_trian,4),2:3),P3'];
                   
                return
            end
        end
    end 
    
end

if ((a1==0.5 && a2==0.2 && a3==0.5) || ((a1==0.6 && a2==0.2 && a3==0.6)&&((tT_1==0 && interno(node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3),punti(tracce(i_traccia,3),2:3))==1) ...
                                                                       || (tT_1==1 && interno(node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3),punti(tracce(i_traccia,2),2:3))==1)))) %intersezione tra la traccia ed il primo vertice + possibile intersezione con il secondo lato, il che equivale a dire che la traccia è interna al triangolo

    beta=1;
    lunsot=size((triangolazione),1);
    
    triangolazione(lunsot+1,:)=[node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3),P2'];
    triangolazione(lunsot+2,:)=[node(ele(i_trian,2),2:3),node(ele(i_trian,4),2:3),P2'];
    
    %inoltre devo andare anche a sottotriangolizzare il triangolo
    %adiacente al punto di intersezione per mantenere la
    %sottotriangolarizzazione conforme
    
    if neigh(i_trian,2)==-1
          
          return
          
    else
           
           prolungo=neigh(i_trian,2);
           for j=2:4
               
               if i_trian==neigh(neigh(i_trian,2),j)
                   
                   lunsot=size((triangolazione),1);
                   
                   triangolazione(lunsot+1,:)=[node(ele(neigh(i_trian,2),j),:),node(ele(i_trian,3),2:3),P2'];
                   triangolazione(lunsot+2,:)=[node(ele(neigh(i_trian,2),j),:),node(ele(i_trian,4),2:3),P2'];
                   
                   return
               end
           end
    end
    
end

if ((a1==0.2 && a2==0.5 && a3==0.5) || ((a1==0.2 && a2==0.6 && a3==0.6)&&((tT_2==0 && interno(node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3),punti(tracce(i_traccia,3),2:3))==1) ...
                                                                       || (tT_2==1 && interno(node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3),punti(tracce(i_traccia,2),2:3))==1)))) %intersezione tra la traccia ed il terzo vertice + possibile intersezione con il primo lato, il che equivale a dire che la traccia è interna al triangolo

    beta=1;
    lunsot=size((triangolazione),1);
    
    triangolazione(lunsot+1,:)=[node(ele(i_trian,4),2:3),node(ele(i_trian,2),2:3),P1'];
    triangolazione(lunsot+2,:)=[node(ele(i_trian,4),2:3),node(ele(i_trian,3),2:3),P1'];
    
    %inoltre devo andare anche a sottotriangolizzare il triangolo
    %adiacente al punto di intersezione per mantenere la
    %sottotriangolarizzazione conforme
    
    if neigh(i_trian,4)==-1
           
           return
       
    else
           
           prolungo=neigh(i_trian,4);
           for j=2:4
               
               if i_trian==neigh(neigh(i_trian,4),j)
                   
                   lunsot=size((triangolazione),1);
                   
                   triangolazione(lunsot+1,:)=[node(ele(neigh(i_trian,4),j),:),node(ele(i_trian,2),2:3),P1'];
                   triangolazione(lunsot+2,:)=[node(ele(neigh(i_trian,4),j),:),node(ele(i_trian,3),2:3),P1'];
                   
                   return
               end
           end
    end

end




if a1==1.25 %intersezione tra estremo traccia e punto generico triangolo, in cui la traccia è esterna, poiché ho già esauirito i casi in cui la traccia è interna
            %o in cui vi sia un intersezione classica


            beta=1;
            lunsot=size((triangolazione),1);
            
             triangolazione(lunsot+1,:)=[node(ele(i_trian,4),2:3),node(ele(i_trian,2),2:3),P1'];
             triangolazione(lunsot+2,:)=[node(ele(i_trian,4),2:3),node(ele(i_trian,3),2:3),P1'];
            
            return
end


if a2==1.25 %intersezione tra estremo traccia e punto generico triangolo, in cui la traccia è esterna, poiché ho già esauirito i casi in cui la traccia è interna
            %o in cui vi sia un intersezione classica


            beta=1;
            lunsot=size((triangolazione),1);
            
            triangolazione(lunsot+1,:)=[node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3),P2'];
            triangolazione(lunsot+2,:)=[node(ele(i_trian,2),2:3),node(ele(i_trian,4),2:3),P2'];
            
            return
end


if a3==1.25 %intersezione tra estremo traccia e punto generico triangolo, in cui la traccia è esterna, poiché ho già esauirito i casi in cui la traccia è interna
            %o in cui vi sia un intersezione classica


            beta=1;
            lunsot=size((triangolazione),1);
            
            triangolazione(lunsot+1,:)=[node(ele(i_trian,3),2:3),node(ele(i_trian,2),2:3),P3'];
            triangolazione(lunsot+2,:)=[node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3),P3'];
             
            return
end

%bisogna studiare i casi paralleli

if a1==2 %la traccia è parallela al primo lato e vi è intersezione 
    
    beta=1;
    
    %analizzo i casi in cui solo un estremo della traccia è interno al lato
    
    if ((tP1>0 && tP1<1)&&(tP2<=0 || tP2>=1)) %il primo estremo della traccia è interno al lato, mentre il secondo no
        
        lunsot=size((triangolazione),1);
        tT_1=0;
        triangolazione(lunsot+1,:)=[punti(tracce(i_traccia,2),2:3),node(ele(i_trian,2),2:3),node(ele(i_trian,4),2:3)];
        triangolazione(lunsot+2,:)=[punti(tracce(i_traccia,2),2:3),node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3)];
        
        return
        
    end
    
    if ((tP1<=0 || tP1>=1)&&(tP2>0 && tP2<1)) %il secondo estremo della traccia è interno al lato, mentre il primo no
        
        lunsot=size((triangolazione),1);
        tT_2=0;
        triangolazione(lunsot+1,:)=[punti(tracce(i_traccia,3),2:3),node(ele(i_trian,2),2:3),node(ele(i_trian,4),2:3)];
        triangolazione(lunsot+2,:)=[punti(tracce(i_traccia,3),2:3),node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3)];
        
        return
        
    end
    
    %adesso analizzo invece i casi in cui entrambi gli estremi sono interni
    %alla traccia
    
    if ((tP1>0 && tP1<1)&&(tP2>0 && tP2<1))
        
        if tP1<tP2
            
            lunsot=size((triangolazione),1);
            tT_1=0;
            tT_2=0;
            triangolazione(lunsot+1,:)=[punti(tracce(i_traccia,2),2:3),node(ele(i_trian,2),2:3),node(ele(i_trian,4),2:3)];
            triangolazione(lunsot+2,:)=[punti(tracce(i_traccia,3),2:3),node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3)];
            triangolazione(lunsot+3,:)=[punti(tracce(i_traccia,2),2:3),punti(tracce(i_traccia,3),2:3),node(ele(i_trian,4),2:3)];
            
            return
            
        else           
            
            lunsot=size((triangolazione),1);
            
            triangolazione(lunsot+1,:)=[punti(tracce(i_traccia,3),2:3),node(ele(i_trian,2),2:3),node(ele(i_trian,4),2:3)];
            triangolazione(lunsot+2,:)=[punti(tracce(i_traccia,2),2:3),node(ele(i_trian,3),2:3),node(ele(i_trian,4),2:3)];
            triangolazione(lunsot+3,:)=[punti(tracce(i_traccia,2),2:3),punti(tracce(i_traccia,3),2:3),node(ele(i_trian,4),2:3)];
            
            return
            
        end
    end
    
    
end

if a2==2 %la traccia è parallela al secondo lato e vi è intersezione 
    
    beta=1;
    
    if ((tP1>0 && tP1<1)&&(tP2<=0 || tP2>=1)) %il primo estremo della traccia è interno al lato, mentre il secondo no
        
        lunsot=size((triangolazione),1);
        tT_1=0;
        triangolazione(lunsot+1,:)=[punti(tracce(i_traccia,2),2:3),node(ele(i_trian,3),2:3),node(ele(i_trian,2),2:3)];
        triangolazione(lunsot+2,:)=[punti(tracce(i_traccia,2),2:3),node(ele(i_trian,4),2:3),node(ele(i_trian,2),2:3)];
        
        return
        
    end
    
    if ((tP1<=0 || tP1>=1)&&(tP2>0 && tP2<1)) %il secondo estremo della traccia è interno al lato, mentre il primo no
        
        lunsot=size((triangolazione),1);
        tT_2=0;
        triangolazione(lunsot+1,:)=[punti(tracce(i_traccia,3),2:3),node(ele(i_trian,3),2:3),node(ele(i_trian,2),2:3)];
        triangolazione(lunsot+2,:)=[punti(tracce(i_traccia,3),2:3),node(ele(i_trian,4),2:3),node(ele(i_trian,2),2:3)];
        
        return
        
    end
    
    %adesso analizzo invece i casi in cui entrambi gli estremi sono interni
    %alla traccia
    
    if ((tP1>0 && tP1<1)&&(tP2>0 && tP2<1))
        
        if tP1<tP2
            
            lunsot=size((triangolazione),1);
            tT_1=0;
            tT_2=0;
            triangolazione(lunsot+1,:)=[punti(tracce(i_traccia,2),2:3),node(ele(i_trian,3),2:3),node(ele(i_trian,2),2:3)];
            triangolazione(lunsot+2,:)=[punti(tracce(i_traccia,3),2:3),node(ele(i_trian,4),2:3),node(ele(i_trian,2),2:3)];
            triangolazione(lunsot+3,:)=[punti(tracce(i_traccia,2),2:3),punti(tracce(i_traccia,3),2:3),node(ele(i_trian,2),2:3)];
            
            return
            
        else           
            
            lunsot=size((triangolazione),1);
            
            triangolazione(lunsot+1,:)=[punti(tracce(i_traccia,3),2:3),node(ele(i_trian,3),2:3),node(ele(i_trian,2),2:3)];
            triangolazione(lunsot+2,:)=[punti(tracce(i_traccia,2),2:3),node(ele(i_trian,4),2:3),node(ele(i_trian,2),2:3)];
            triangolazione(lunsot+3,:)=[punti(tracce(i_traccia,2),2:3),punti(tracce(i_traccia,3),2:3),node(ele(i_trian,2),2:3)];
            
            return
            
        end
    end
    
end

if a3==2 %la traccia è parallela al terzo lato e vi è intersezione 
    
    beta=1;
    
    if ((tP1>0 && tP1<1)&&(tP2<=0 || tP2>=1)) %il primo estremo della traccia è interno al lato, mentre il secondo no
        
        lunsot=size((triangolazione),1);
        tT_1=0;
        triangolazione(lunsot+1,:)=[punti(tracce(i_traccia,2),2:3),node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3)];
        triangolazione(lunsot+2,:)=[punti(tracce(i_traccia,2),2:3),node(ele(i_trian,4),2:3),node(ele(i_trian,3),2:3)];
        
        return
        
    end
    
    if ((tP1<=0 || tP1>=1)&&(tP2>0 && tP2<1)) %il secondo estremo della traccia è interno al lato, mentre il primo no
        
        lunsot=size((triangolazione),1);
        tT_2=0;
        triangolazione(lunsot+1,:)=[punti(tracce(i_traccia,3),2:3),node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3)];
        triangolazione(lunsot+2,:)=[punti(tracce(i_traccia,3),2:3),node(ele(i_trian,4),2:3),node(ele(i_trian,3),2:3)];
        
        return
        
    end
    
    %adesso analizzo invece i casi in cui entrambi gli estremi sono interni
    %alla traccia
    
    if ((tP1>0 && tP1<1)&&(tP2>0 && tP2<1))
        
        if tP1<tP2
            
            lunsot=size((triangolazione),1);
            tT_2=0;
            triangolazione(lunsot+1,:)=[punti(tracce(i_traccia,2),2:3),node(ele(i_trian,4),2:3),node(ele(i_trian,3),2:3)];
            triangolazione(lunsot+2,:)=[punti(tracce(i_traccia,3),2:3),node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3)];
            triangolazione(lunsot+3,:)=[punti(tracce(i_traccia,2),2:3),punti(tracce(i_traccia,3),2:3),node(ele(i_trian,3),2:3)];
            
            return
            
        else           
            
            lunsot=size((triangolazione),1);
            tT_1=0;
            tT_2=0;
            triangolazione(lunsot+1,:)=[punti(tracce(i_traccia,3),2:3),node(ele(i_trian,4),2:3),node(ele(i_trian,3),2:3)];
            triangolazione(lunsot+2,:)=[punti(tracce(i_traccia,2),2:3),node(ele(i_trian,2),2:3),node(ele(i_trian,3),2:3)];
            triangolazione(lunsot+3,:)=[punti(tracce(i_traccia,2),2:3),punti(tracce(i_traccia,3),2:3),node(ele(i_trian,3),2:3)];
            
            return
            
        end
    end
    
end

    

