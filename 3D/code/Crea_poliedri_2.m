function [ Poliedri,Facce_pol,Lati_pol ] = Crea_poliedri_2( i_punti,pos_nodi,facce_inters,pos_int,Poliedri,Facce_pol,Lati_pol )

%vi sono due punti di intersezione ed un vertice appartiene alla frattura

%inizialmente salvo il vertice in questione e la relativa posizione interna

for i=1:4
    if pos_nodi(i)==0
        i_vert=i;
        break
    end
end

if i_vert==1
    pos_int_vert=[0 1 1 1];
end
if i_vert==2
    pos_int_vert=[1 0 2 2];
end
if i_vert==3
    pos_int_vert=[2 2 0 3];
end
if i_vert==4
    pos_int_vert=[3 3 3 0];
end


facce_inters(i_vert)=2; %do un valore diverso alla faccia intersecata opoosta al vertice poiché avrà un intersezione diversa rispetto le altre facce

%adesso si va a formare i_taglio, la faccia di taglio. costituita da un
%vertice e due punti di intersezione

Lati=[i_punti(5) i_punti(6);i_punti(6) i_punti(i_vert);i_punti(i_vert) i_punti(5)];
[Lati_pol,indice_lati] = Ordina_lati( Lati_pol,Lati );
Facce=[indice_lati(1),indice_lati(2),indice_lati(3),-1];
[Facce_pol,i_facce] = Ordina_facce(Facce,Facce_pol);
i_taglio=i_facce;

%creo le sottofacce relative alla faccia opposta al vertice che giace sulla
%frattura

if i_vert==1
    x=length(i_facce);
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(2),i_punti(3),i_punti(4),i_punti(5),i_punti(6),pos_int(1,1),pos_int(1,2),Lati_pol,Facce_pol);
end
if i_vert==2
    x=length(i_facce);
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(3),i_punti(4),i_punti(5),i_punti(6),pos_int(2,1),pos_int(2,2),Lati_pol,Facce_pol);
end
if i_vert==3
    x=length(i_facce);
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(2),i_punti(4),i_punti(5),i_punti(6),pos_int(3,1),pos_int(3,2),Lati_pol,Facce_pol);
end
if i_vert==4
    x=length(i_facce);
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(2),i_punti(3),i_punti(5),i_punti(6),pos_int(4,1),pos_int(4,2),Lati_pol,Facce_pol);
end

%creo le altre sottofacce

if facce_inters(1)==1
    x=length(i_facce);
    if pos_int(1,1)==-1 %il primo punto di intersezione non appartiene alla faccia considerata
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_2(i_punti(2),i_punti(3),i_punti(4),i_punti(6),pos_int_vert(1),Lati_pol,Facce_pol);
    else
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_2(i_punti(2),i_punti(3),i_punti(4),i_punti(5),pos_int_vert(1),Lati_pol,Facce_pol);
    end
elseif facce_inters(1)==0 %la faccia non intersecata e la vado a salvare in i_base
    Lati=[i_punti(2) i_punti(3);i_punti(3) i_punti(4);i_punti(4) i_punti(2)];
    [Lati_pol,indice_lati] = Ordina_lati( Lati_pol,Lati );
    Facce=[indice_lati(1),indice_lati(2),indice_lati(3),-1];
    [Facce_pol,i_facce] = Ordina_facce(Facce,Facce_pol);
    i_base=i_facce;
end

if facce_inters(2)==1
    x=length(i_facce);
    if pos_int(2,1)==-1 %il primo punto di intersezione non appartiene alla faccia considerata
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_2(i_punti(1),i_punti(3),i_punti(4),i_punti(6),pos_int_vert(2),Lati_pol,Facce_pol);
    else
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_2(i_punti(1),i_punti(3),i_punti(4),i_punti(5),pos_int_vert(2),Lati_pol,Facce_pol);
    end  
elseif facce_inters(2)==0 %la faccia non intersecata e la vado a salvare in i_base
    Lati=[i_punti(1) i_punti(3);i_punti(3) i_punti(4);i_punti(4) i_punti(1)];
    [Lati_pol,indice_lati] = Ordina_lati( Lati_pol,Lati );
    Facce=[indice_lati(1),indice_lati(2),indice_lati(3),-1];
    [Facce_pol,i_facce] = Ordina_facce(Facce,Facce_pol);
    i_base=i_facce;
end

if facce_inters(3)==1
    x=length(i_facce);
    if pos_int(3,1)==-1 %il primo punto di intersezione non appartiene alla faccia considerata
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_2(i_punti(1),i_punti(2),i_punti(4),i_punti(6),pos_int_vert(3),Lati_pol,Facce_pol);
    else
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_2(i_punti(1),i_punti(2),i_punti(4),i_punti(5),pos_int_vert(3),Lati_pol,Facce_pol);
    end
elseif facce_inters(3)==0 %la faccia non intersecata e la vado a salvare in i_base
    Lati=[i_punti(1) i_punti(2);i_punti(2) i_punti(4);i_punti(4) i_punti(1)];
    [Lati_pol,indice_lati] = Ordina_lati( Lati_pol,Lati );
    Facce=[indice_lati(1),indice_lati(2),indice_lati(3),-1];
    [Facce_pol,i_facce] = Ordina_facce(Facce,Facce_pol);
    i_base=i_facce;
end

if facce_inters(4)==1
    x=length(i_facce);
    if pos_int(4,1)==-1 %il primo punto di intersezione non appartiene alla faccia considerata
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_2(i_punti(1),i_punti(2),i_punti(3),i_punti(6),pos_int_vert(4),Lati_pol,Facce_pol);
    else
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_2(i_punti(1),i_punti(2),i_punti(3),i_punti(5),pos_int_vert(4),Lati_pol,Facce_pol);
    end
elseif facce_inters(4)==0 %la faccia non intersecata e la vado a salvare in i_base
    Lati=[i_punti(1) i_punti(2);i_punti(2) i_punti(3);i_punti(3) i_punti(1)];
    [Lati_pol,indice_lati] = Ordina_lati( Lati_pol,Lati );
    Facce=[indice_lati(1),indice_lati(2),indice_lati(3),-1];
    [Facce_pol,i_facce] = Ordina_facce(Facce,Facce_pol);
    i_base=i_facce;
end

y=size(Poliedri,1);

% se consideriamo le facceche vanno da 3 a 6 avremmo che 2 di esse
% condivideranno un lato formato da due nodi. inoltre la faccia 3 non può
% condividerla con la 5 e la faccia 5 non può condividerlo con la 6.
% Controllando tale lato in condivisione andremo a creare i sottopoliedri.

if Facce_pol(i_facce(3),1)==Facce_pol(i_facce(5),1)
    Poliedri(y+1,:)=[i_facce(1) i_facce(3) i_facce(5) i_taglio -1];
    Poliedri(y+2,:)=[i_facce(2) i_facce(4) i_facce(6) i_taglio i_base];
    return
end
if Facce_pol(i_facce(3),1)==Facce_pol(i_facce(6),1)
    Poliedri(y+1,:)=[i_facce(1) i_facce(3) i_facce(6) i_taglio -1];
    Poliedri(y+2,:)=[i_facce(2) i_facce(4) i_facce(5) i_taglio i_base];
    return
end
if Facce_pol(i_facce(4),1)==Facce_pol(i_facce(5),1)
    Poliedri(y+1,:)=[i_facce(1) i_facce(4) i_facce(5) i_taglio -1];
    Poliedri(y+2,:)=[i_facce(2) i_facce(3) i_facce(6) i_taglio i_base];
    return
end
if Facce_pol(i_facce(4),1)==Facce_pol(i_facce(6),1)
    Poliedri(y+1,:)=[i_facce(1) i_facce(4) i_facce(6) i_taglio -1];
    Poliedri(y+2,:)=[i_facce(2) i_facce(4) i_facce(5) i_taglio i_base];
    return
end
end

