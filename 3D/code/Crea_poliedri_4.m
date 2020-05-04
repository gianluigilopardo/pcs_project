function [ Poliedri,Facce_pol,Lati_pol ] = Crea_poliedri_4( i_punti,pos_int_facce,pos_int,Poliedri,Facce_pol,Lati_pol)


[Facce_pol,Lati_pol,i_taglio ] = Taglio_4( i_punti(5),i_punti(6),i_punti(7),i_punti(8),pos_int,Facce_pol,Lati_pol );

i_facce=[];
x=length(i_facce);

%creo i lati e le relative facce per ogni triangolo che forma il tetraedro

if (pos_int_facce(1,1)~=-1 && pos_int_facce(1,2)~=-1) %il primo ed il secondo punto di intersezione appartengono alla prima faccia
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(2),i_punti(3),i_punti(4),i_punti(5),i_punti(6),pos_int_facce(1,1),pos_int_facce(1,2),Lati_pol,Facce_pol);
end
if (pos_int_facce(1,1)~=-1 && pos_int_facce(1,3)~=-1) %primo  e terzo
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(2),i_punti(3),i_punti(4),i_punti(5),i_punti(7),pos_int_facce(1,1),pos_int_facce(1,3),Lati_pol,Facce_pol); 
end
if (pos_int_facce(1,1)~=-1 && pos_int_facce(1,4)~=-1) %primo e quarto
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(2),i_punti(3),i_punti(4),i_punti(5),i_punti(8),pos_int_facce(1,1),pos_int_facce(1,4),Lati_pol,Facce_pol);
end
if (pos_int_facce(1,2)~=-1 && pos_int_facce(1,3)~=-1) %secondo e terzo
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(2),i_punti(3),i_punti(4),i_punti(6),i_punti(7),pos_int_facce(1,2),pos_int_facce(1,3),Lati_pol,Facce_pol);
end
if (pos_int_facce(1,2)~=-1 && pos_int_facce(1,4)~=-1) %secondo e quarto
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(2),i_punti(3),i_punti(4),i_punti(6),i_punti(8),pos_int_facce(1,2),pos_int_facce(1,4),Lati_pol,Facce_pol);
end
if (pos_int_facce(1,3)~=-1 && pos_int_facce(1,4)~=-1) %terzo e quarto
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(2),i_punti(3),i_punti(4),i_punti(7),i_punti(8),pos_int_facce(1,3),pos_int_facce(1,4),Lati_pol,Facce_pol);
end

x=length(i_facce);
if (pos_int_facce(2,1)~=-1 && pos_int_facce(2,2)~=-1) %il primo ed il secondo punto di intersezione appartengono alla seconda faccia
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(3),i_punti(4),i_punti(5),i_punti(6),pos_int_facce(2,1),pos_int_facce(2,2),Lati_pol,Facce_pol);
end
if (pos_int_facce(2,1)~=-1 && pos_int_facce(2,3)~=-1)
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(3),i_punti(4),i_punti(5),i_punti(7),pos_int_facce(2,1),pos_int_facce(2,3),Lati_pol,Facce_pol); 
end
if (pos_int_facce(2,1)~=-1 && pos_int_facce(2,4)~=-1)
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(3),i_punti(4),i_punti(5),i_punti(8),pos_int_facce(2,1),pos_int_facce(2,4),Lati_pol,Facce_pol);
end
if (pos_int_facce(2,2)~=-1 && pos_int_facce(2,3)~=-1)
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(3),i_punti(4),i_punti(6),i_punti(7),pos_int_facce(2,2),pos_int_facce(2,3),Lati_pol,Facce_pol);
end
if (pos_int_facce(2,2)~=-1 && pos_int_facce(2,4)~=-1)
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(3),i_punti(4),i_punti(6),i_punti(8),pos_int_facce(2,2),pos_int_facce(2,4),Lati_pol,Facce_pol);
end
if (pos_int_facce(2,3)~=-1 && pos_int_facce(2,4)~=-1)
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(3),i_punti(4),i_punti(7),i_punti(8),pos_int_facce(2,3),pos_int_facce(2,4),Lati_pol,Facce_pol);
end

x=length(i_facce);
if (pos_int_facce(3,1)~=-1 && pos_int_facce(3,2)~=-1) %il primo ed il secondo punto di intersezione appartengono alla terza faccia
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(2),i_punti(4),i_punti(5),i_punti(6),pos_int_facce(3,1),pos_int_facce(3,2),Lati_pol,Facce_pol);
end
if (pos_int_facce(3,1)~=-1 && pos_int_facce(3,3)~=-1)
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(2),i_punti(4),i_punti(5),i_punti(7),pos_int_facce(3,1),pos_int_facce(3,3),Lati_pol,Facce_pol); 
end
if (pos_int_facce(3,1)~=-1 && pos_int_facce(3,4)~=-1)
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(2),i_punti(4),i_punti(5),i_punti(8),pos_int_facce(3,1),pos_int_facce(3,4),Lati_pol,Facce_pol);
end
if (pos_int_facce(3,2)~=-1 && pos_int_facce(3,3)~=-1)
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(2),i_punti(4),i_punti(6),i_punti(7),pos_int_facce(3,2),pos_int_facce(3,3),Lati_pol,Facce_pol);
end
if (pos_int_facce(3,2)~=-1 && pos_int_facce(3,4)~=-1)
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(2),i_punti(4),i_punti(6),i_punti(8),pos_int_facce(3,2),pos_int_facce(3,4),Lati_pol,Facce_pol);
end
if (pos_int_facce(3,3)~=-1 && pos_int_facce(3,4)~=-1)
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(2),i_punti(4),i_punti(7),i_punti(8),pos_int_facce(3,3),pos_int_facce(3,4),Lati_pol,Facce_pol);
end

x=length(i_facce);
if (pos_int_facce(4,1)~=-1 && pos_int_facce(4,2)~=-1) %il primo ed il secondo punto di intersezione appartengono alla quarta faccia
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(2),i_punti(3),i_punti(5),i_punti(6),pos_int_facce(4,1),pos_int_facce(4,2),Lati_pol,Facce_pol);
end
if (pos_int_facce(4,1)~=-1 && pos_int_facce(4,3)~=-1)
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(2),i_punti(3),i_punti(5),i_punti(7),pos_int_facce(4,1),pos_int_facce(4,3),Lati_pol,Facce_pol); 
end
if (pos_int_facce(4,1)~=-1 && pos_int_facce(4,4)~=-1)
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(2),i_punti(3),i_punti(5),i_punti(8),pos_int_facce(4,1),pos_int_facce(4,4),Lati_pol,Facce_pol);
end
if (pos_int_facce(4,2)~=-1 && pos_int_facce(4,3)~=-1)
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(2),i_punti(3),i_punti(6),i_punti(7),pos_int_facce(4,2),pos_int_facce(4,3),Lati_pol,Facce_pol);
end
if (pos_int_facce(4,2)~=-1 && pos_int_facce(4,4)~=-1)
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(2),i_punti(3),i_punti(6),i_punti(8),pos_int_facce(4,2),pos_int_facce(4,4),Lati_pol,Facce_pol);
end
if (pos_int_facce(4,3)~=-1 && pos_int_facce(4,4)~=-1)
    [Lati_pol,Facce_pol,i_facce(x+1:x+2)]=Crea_facce_1(i_punti(1),i_punti(2),i_punti(3),i_punti(7),i_punti(8),pos_int_facce(4,3),pos_int_facce(4,4),Lati_pol,Facce_pol);
end

%ho creato otto facce in tale tipologia di intersezione

L=size(Poliedri,1);

%adesso per creare i poliedri controllo le facce salvate in i_facce di
%indice pari, e ho che due di esse condivideranno un lato formato da due
%nodi(che si trova nalla prima posizione), allora avrò le seguenti
%possibilità: 2-4 e 6-8, 2-6 e 4-8, 2-8 e 4-6. Con dei controlli allora
%andrò a formare i poliedri.

if Facce_pol(i_facce(2),1)== Facce_pol(i_facce(4),1)
    Poliedri(L+1,:)=[i_facce(1),i_facce(3),i_facce(6),i_facce(8),i_taglio];
    Poliedri(L+2,:)=[i_facce(2),i_facce(4),i_facce(5),i_facce(7),i_taglio];
    return
end

if Facce_pol(i_facce(2),1)== Facce_pol(i_facce(6),1)
    Poliedri(L+1,:)=[i_facce(1),i_facce(4),i_facce(5),i_facce(8),i_taglio];
    Poliedri(L+2,:)=[i_facce(2),i_facce(3),i_facce(6),i_facce(7),i_taglio];
    return
end

if Facce_pol(i_facce(2),1)== Facce_pol(i_facce(8),1)
    Poliedri(L+1,:)=[i_facce(1),i_facce(4),i_facce(6),i_facce(7),i_taglio];
    Poliedri(L+2,:)=[i_facce(2),i_facce(3),i_facce(5),i_facce(8),i_taglio];
    return
end
end

