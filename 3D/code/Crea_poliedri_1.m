function [ Poliedri,Facce_pol,Lati_pol ] = Crea_poliedri_1( i_punti,facce_inters,pos_nodi,Poliedri,Facce_pol,Lati_pol )

%siamo nel caso in cui vi è un solo punto di intersezione e due vertici
%giacciono sulla frattura
x=0;
i_base=[];
pos_int_vert=zeros(2,4);
i_vert=zeros(1,2);
for i=1:4
    if pos_nodi(i)==0
        x=x+1;
        i_vert(x)=i; %salvo i vertici che giacciono sulla frattura
    end
end
for i=1:2 %salvo la posizione interna dei vertici con riferimento alla struttura interna
    if i_vert(i)==1
        pos_int_vert(i,:)=[0 1 1 1];
    end
    if i_vert(i)==2
        pos_int_vert(i,:)=[1 0 2 2];
    end
    if i_vert(i)==3
        pos_int_vert(i,:)=[2 2 0 3];
    end
    if i_vert(i)==4
        pos_int_vert(i,:)=[3 3 3 0];
    end
end

%creo la faccia di taglio composta dai i due vertici sopra definiti ed il
%punto di intersezione classico

Lati=[i_punti(5) i_punti(i_vert(1));i_punti(i_vert(1)) i_punti(i_vert(2));i_punti(i_vert(2)) i_punti(5)];
[Lati_pol,indice_lati] = Ordina_lati( Lati_pol,Lati );
Facce=[indice_lati(1),indice_lati(2),indice_lati(3),-1];
[Facce_pol,i_facce] = Ordina_facce(Facce,Facce_pol);
i_taglio=i_facce; 

%vi saranno due facce del tetraedro che non saranno intersecate,allora
%salvo tali facce poiché formeranno un sottopoliedro

if facce_inters(1)==0 %se la prima faccia non è intersecata
    Lati=[i_punti(2) i_punti(3);i_punti(3) i_punti(4);i_punti(4) i_punti(2)];
    [Lati_pol,indice_lati] = Ordina_lati( Lati_pol,Lati );
    Facce=[indice_lati(1),indice_lati(2),indice_lati(3),-1];
    [Facce_pol,i_facce] = Ordina_facce(Facce,Facce_pol);
    x=length(i_base);
    i_base(x+1)=i_facce;
end
if facce_inters(2)==0 %se la seconda faccia non è intersecata
    Lati=[i_punti(1) i_punti(3);i_punti(3) i_punti(4);i_punti(4) i_punti(1)];
    [Lati_pol,indice_lati] = Ordina_lati( Lati_pol,Lati );
    Facce=[indice_lati(1),indice_lati(2),indice_lati(3),-1];
    [Facce_pol,i_facce] = Ordina_facce(Facce,Facce_pol);
    x=length(i_base);
    i_base(x+1)=i_facce;
end
if facce_inters(3)==0 %se la terza faccia non è intersecata
    Lati=[i_punti(1) i_punti(2);i_punti(2) i_punti(4);i_punti(4) i_punti(1)];
    [Lati_pol,indice_lati] = Ordina_lati( Lati_pol,Lati );
    Facce=[indice_lati(1),indice_lati(2),indice_lati(3),-1];
    [Facce_pol,i_facce] = Ordina_facce(Facce,Facce_pol);
    x=length(i_base);
    i_base(x+1)=i_facce;
end
if facce_inters(4)==0 %se la quarta faccia non è intersecata
    Lati=[i_punti(1) i_punti(2);i_punti(2) i_punti(3);i_punti(3) i_punti(1)];
    [Lati_pol,indice_lati] = Ordina_lati( Lati_pol,Lati );
    Facce=[indice_lati(1),indice_lati(2),indice_lati(3),-1];
    [Facce_pol,i_facce] = Ordina_facce(Facce,Facce_pol);
    x=length(i_base);
    i_base(x+1)=i_facce;
end

%inoltre vi saranno due facce intersecate e devo andare a creare le
%sottofacce di tali

if facce_inters(1)==1 
    x=length(i_facce);
    if pos_int_vert(1,1)==0 %il primo vertice non appartiene alla faccia considerata
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_2(i_punti(2),i_punti(3),i_punti(4),i_punti(5),pos_int_vert(2,1),Lati_pol,Facce_pol);
    else
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_2(i_punti(2),i_punti(3),i_punti(4),i_punti(5),pos_int_vert(1,1),Lati_pol,Facce_pol);
    end
end

if facce_inters(2)==1
    x=length(i_facce);
    if pos_int_vert(1,2)==0 %il primo vertice non appartiene alla faccia considerata
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_2(i_punti(1),i_punti(3),i_punti(4),i_punti(5),pos_int_vert(2,2),Lati_pol,Facce_pol);
    else
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_2(i_punti(1),i_punti(3),i_punti(4),i_punti(5),pos_int_vert(1,2),Lati_pol,Facce_pol);
    end
end

if facce_inters(3)==1
    x=length(i_facce);
    if pos_int_vert(1,3)==0 %il primo vertice non appartiene alla faccia considerata
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_2(i_punti(1),i_punti(2),i_punti(4),i_punti(5),pos_int_vert(2,3),Lati_pol,Facce_pol);
    else
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_2(i_punti(1),i_punti(2),i_punti(4),i_punti(5),pos_int_vert(1,3),Lati_pol,Facce_pol);
    end
end

if facce_inters(4)==1
    x=length(i_facce);
    if pos_int_vert(1,4)==0 %il primo vertice non appartiene alla faccia considerata
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_2(i_punti(1),i_punti(2),i_punti(3),i_punti(5),pos_int_vert(2,4),Lati_pol,Facce_pol);
    else
        [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_2(i_punti(1),i_punti(2),i_punti(3),i_punti(5),pos_int_vert(1,4),Lati_pol,Facce_pol);
    end
end

flag1=0;
flag2=0;

%il primo elemento di Facce_pol delle facce create da Crea_facce_2 è
%formato dal lato costituito da due nodi. Tale lato sarà condiviso con una
%delle facce non intersecate. Inoltre si ha che se il lato è in
%condivisione con i_facce(1) non può esserlo con i_facce(2) e viceversa.
%Allora salvo in dei flag valutando con quale faccia vi è la condivisione.

%i_base(1) condividerà un lato con una tra i_facce(1) e i_facce(2) e
%condividerà un altro lato con una tra i_facce(3) e i_facce(4). Allora
%controllo con quali di tali facce il lato è condiviso.
for j=1:3
    if Facce_pol(i_base(1),j)==Facce_pol(i_facce(1),1)
        flag1=1;
    end
    if Facce_pol(i_base(1),j)==Facce_pol(i_facce(3),1)
        flag2=1;
    end
end

y=size(Poliedri,1);

if (flag1==1 && flag2==1) %i_base(1) forma il sottopoliedro con i_facce(1) e i_facce(3)
    Poliedri(y+1)=[i_taglio,i_base(1),i_facce(1),i_facce(3),-1];
    Poliedri(y+2)=[i_taglio,i_base(2),i_facce(2),i_facce(4),-1];
end
if (flag1==1 && flag2==0) %i_base(1) forma il sottopoliedro con i_facce(1) e i_facce(4)
    Poliedri(y+1)=[i_taglio,i_base(1),i_facce(1),i_facce(4),-1];
    Poliedri(y+2)=[i_taglio,i_base(2),i_facce(2),i_facce(3),-1];
end
if (flag1==0 && flag2==1) %i_base(1) forma il sottopoliedro con i_facce(2) e i_facce(3)
    Poliedri(y+1)=[i_taglio,i_base(1),i_facce(2),i_facce(3),-1];
    Poliedri(y+2)=[i_taglio,i_base(2),i_facce(1),i_facce(4),-1];
end
if (flag1==0 && flag2==0) %i_base(1) forma il sottopoliedro con i_facce(2) e i_facce(4)
    Poliedri(y+1)=[i_taglio,i_base(1),i_facce(2),i_facce(4),-1];
    Poliedri(y+2)=[i_taglio,i_base(2),i_facce(1),i_facce(3),-1];
end
end

