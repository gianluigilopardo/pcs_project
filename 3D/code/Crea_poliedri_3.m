function [ Poliedri,Facce_pol,Lati_pol ] = Crea_poliedri_3( i_punti,facce_inters,pos_int,Poliedri,Facce_pol,Lati_pol )

%siamo nel caso in cui vi sono 3 punti di intersezione

i_facce=[];

%formo la faccia del taglio formata dai tre punti di intersezione

Lati=[i_punti(5) i_punti(6);i_punti(6) i_punti(7);i_punti(7) i_punti(5)];
[Lati_pol,indice_lati] = Ordina_lati( Lati_pol,Lati );
Facce=[indice_lati(1),indice_lati(2),indice_lati(3),-1];
[Facce_pol,indice_facce] = Ordina_facce(Facce,Facce_pol);
i_taglio=indice_facce;

if facce_inters(1)==1
    
    x=length(i_facce);
    
    if pos_int(1,1)==-1 %il primo punto non appartiene alla prima faccia
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(2),i_punti(3),i_punti(4),i_punti(6),i_punti(7),pos_int(1,2),pos_int(1,3),Lati_pol,Facce_pol);
    end
    if pos_int(1,2)==-1 %il secondo punto non appartiene alla prima faccia
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(2),i_punti(3),i_punti(4),i_punti(5),i_punti(7),pos_int(1,1),pos_int(1,3),Lati_pol,Facce_pol);
    end
    if pos_int(1,3)==-1 %il terzo punto non appartiene alla prima faccia
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(2),i_punti(3),i_punti(4),i_punti(5),i_punti(6),pos_int(1,1),pos_int(1,2),Lati_pol,Facce_pol);
    end
    
else %se la faccia non è intersecata, la salvo in i_base
    Lati=[i_punti(2) i_punti(3);i_punti(3) i_punti(4);i_punti(4) i_punti(2)];
    [Lati_pol,indice_lati] = Ordina_lati( Lati_pol,Lati );
    Facce=[indice_lati(1),indice_lati(2),indice_lati(3),-1];
    [Facce_pol,indice_facce] = Ordina_facce(Facce,Facce_pol);
    i_base=indice_facce;
end



if facce_inters(2)==1
    
    x=length(i_facce);
    
    if pos_int(2,1)==-1 %il primo punto non appartiene alla seconda faccia
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(3),i_punti(4),i_punti(6),i_punti(7),pos_int(2,2),pos_int(2,3),Lati_pol,Facce_pol);
    end
    if pos_int(2,2)==-1 %il secondo punto non appartiene alla seconda faccia
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(3),i_punti(4),i_punti(5),i_punti(7),pos_int(2,1),pos_int(2,3),Lati_pol,Facce_pol);
    end
    if pos_int(2,3)==-1 %il terzo punto non appartiene alla seconda faccia
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(3),i_punti(4),i_punti(5),i_punti(6),pos_int(2,1),pos_int(2,2),Lati_pol,Facce_pol);
    end
else %se la faccia non è intersecata, la salvo in i_base
    Lati=[i_punti(1) i_punti(3);i_punti(3) i_punti(4);i_punti(4) i_punti(1)];
    [Lati_pol,indice_lati] = Ordina_lati( Lati_pol,Lati );
    Facce=[indice_lati(1),indice_lati(2),indice_lati(3),-1];
    [Facce_pol,indice_facce] = Ordina_facce(Facce,Facce_pol);
    i_base=indice_facce;
end



if facce_inters(3)==1
    
    x=length(i_facce);
    
    if pos_int(3,1)==-1 %il primo punto non appartiene alla terza faccia
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(2),i_punti(4),i_punti(6),i_punti(7),pos_int(3,2),pos_int(3,3),Lati_pol,Facce_pol);
    end
    if pos_int(3,2)==-1 %il secondo punto non appartiene alla terza faccia
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(2),i_punti(4),i_punti(5),i_punti(7),pos_int(3,1),pos_int(3,3),Lati_pol,Facce_pol);
    end
    if pos_int(3,3)==-1 %il terzo punto non appartiene alla terza faccia
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(2),i_punti(4),i_punti(5),i_punti(6),pos_int(3,1),pos_int(3,2),Lati_pol,Facce_pol);
    end
else %se la faccia non è intersecata, la salvo in i_base
    Lati=[i_punti(1) i_punti(2);i_punti(2) i_punti(4);i_punti(4) i_punti(1)];
    [Lati_pol,indice_lati] = Ordina_lati( Lati_pol,Lati );
    Facce=[indice_lati(1),indice_lati(2),indice_lati(3),-1];
    [Facce_pol,indice_facce] = Ordina_facce(Facce,Facce_pol);
    i_base=indice_facce;
end



if facce_inters(4)==1
    
    x=length(i_facce);
    
    if pos_int(4,1)==-1 %il primo punto non appartiene alla prima faccia
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(2),i_punti(3),i_punti(6),i_punti(7),pos_int(4,2),pos_int(4,3),Lati_pol,Facce_pol);
    end
    if pos_int(4,2)==-1 %il secondo punto non appartiene alla prima faccia
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(2),i_punti(3),i_punti(5),i_punti(7),pos_int(4,1),pos_int(4,3),Lati_pol,Facce_pol);
    end
    if pos_int(4,3)==-1 %il terzo punto non appartiene alla prima faccia
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(2),i_punti(3),i_punti(5),i_punti(6),pos_int(4,1),pos_int(4,2),Lati_pol,Facce_pol);
    end
else %se la faccia non è intersecata, la salvo in i_base
    Lati=[i_punti(1) i_punti(2);i_punti(2) i_punti(3);i_punti(3) i_punti(1)];
    [Lati_pol,indice_lati] = Ordina_lati( Lati_pol,Lati );
    Facce=[indice_lati(1),indice_lati(2),indice_lati(3),-1];
    [Facce_pol,indice_facce] = Ordina_facce(Facce,Facce_pol);
    i_base=indice_facce;    
end

x=size(Poliedri,1);

%formo i poliedri

Poliedri(x+1,:)=[i_facce(1),i_facce(3),i_facce(5),i_taglio,-1];
Poliedri(x+2,:)=[i_facce(2),i_facce(4),i_facce(6),i_taglio,i_base];

end

