function [Facce_pol,Lati_pol,i_taglio ] = Taglio_4( P1,P2,P3,P4,pos,Facce_pol,Lati_pol )

Lati=[];

%tale funzione serve a formare i lati della faccia del taglio quando
%questa è formata da 4 punti di intersezione.

%considero i 6 possibili lati formati da quattro vertici ed escludo quelli
%che non possono essere presi, ovvero, secondo la struttura interna delle
%facce, non può esservi un lato quando i due vertici considerati hanno le
%seguenti posizioni: 1-6, 2-5, 3-4, 4-3, 5-2, 6-1. In caso contrario salvo
%i lati.

if ((pos(1)==1 && pos(2)~=6)||(pos(1)==2 && pos(2)~=5) ||(pos(1)==3 && pos(2)~=4) ||(pos(1)==4 && pos(2)~=3) ||(pos(1)==5 && pos(2)~=2) ||(pos(1)==6 && pos(2)~=1))
    x=size(Lati,1);
    Lati(x+1,:)=[P1 P2];
end
if ((pos(1)==1 && pos(3)~=6)||(pos(1)==2 && pos(3)~=5) ||(pos(1)==3 && pos(3)~=4) ||(pos(1)==4 && pos(3)~=3) ||(pos(1)==5 && pos(3)~=2) ||(pos(1)==6 && pos(3)~=1))
    x=size(Lati,1);
    Lati(x+1,:)=[P1 P3];
end
if ((pos(1)==1 && pos(4)~=6)||(pos(1)==2 && pos(4)~=5) ||(pos(1)==3 && pos(4)~=4) ||(pos(1)==4 && pos(4)~=3) ||(pos(1)==5 && pos(4)~=2) ||(pos(1)==6 && pos(4)~=1))
    x=size(Lati,1);
    Lati(x+1,:)=[P1 P4];
end


if ((pos(2)==1 && pos(3)~=6)||(pos(2)==2 && pos(3)~=5) ||(pos(2)==3 && pos(3)~=4) ||(pos(2)==4 && pos(3)~=3) ||(pos(2)==5 && pos(3)~=2) ||(pos(2)==6 && pos(3)~=1))
    x=size(Lati,1);
    Lati(x+1,:)=[P2 P3];
end
if ((pos(2)==1 && pos(4)~=6)||(pos(2)==2 && pos(4)~=5) ||(pos(2)==3 && pos(4)~=4) ||(pos(2)==4 && pos(4)~=3) ||(pos(2)==5 && pos(4)~=2) ||(pos(2)==6 && pos(4)~=1))
    x=size(Lati,1);
    Lati(x+1,:)=[P2 P4];
end


if ((pos(3)==1 && pos(4)~=6)||(pos(3)==2 && pos(4)~=5) ||(pos(3)==3 && pos(4)~=4) ||(pos(3)==4 && pos(4)~=3) ||(pos(3)==5 && pos(4)~=2) ||(pos(3)==6 && pos(4)~=1))
    x=size(Lati,1);
    Lati(x+1,:)=[P3 P4];
end

%dopo aver trovato i lati di interesse, salvo la faccia e ne ricavo
%l'indice.

[Lati_pol,indice_lati] = Ordina_lati( Lati_pol,Lati );
Facce=[indice_lati(1),indice_lati(2),indice_lati(3),indice_lati(4)];
[Facce_pol,i_taglio] = Ordina_facce(Facce,Facce_pol);

end
