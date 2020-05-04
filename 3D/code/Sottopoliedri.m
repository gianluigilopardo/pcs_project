function [ Poliedri,Facce_pol,Lati_pol,Punti_pol ] = Sottopoliedri( punti_intersezione,pos_int,i_tetra,pos_nodi,Poliedri,Facce_pol,Lati_pol,Punti_pol )

[Punti_pol,indice_punti] = Ordina_punti( Punti_pol,punti_intersezione,i_tetra); %ordino i punti di intersezione in Punti_pol e salvo gli indici
[pos_int_facc,facce_inters,n_inters] = posizioneinterna_facceintersecate(pos_int); %ricavo la posixione interna dei punti di intersezione e quali sono le facce del tetraedro intersecate

if n_inters == 4 %4 punti di intersezione
    [Poliedri,Facce_pol,Lati_pol ] = Crea_poliedri_4( indice_punti,pos_int_facc,pos_int,Poliedri,Facce_pol,Lati_pol);
end

if n_inters == 3 %3 punti di intersezione
    [Poliedri,Facce_pol,Lati_pol] = Crea_poliedri_3(indice_punti,facce_inters,pos_int_facc,Poliedri,Facce_pol,Lati_pol);
end

if n_inters == 2 %2 punti di intersezione
    [Poliedri,Facce_pol,Lati_pol] = Crea_poliedri_2(i_punti,pos_nodi,facce_inters,pos_int,Poliedri,Facce_pol,Lati_pol);
end

if n_inters ==1 %1 punti di intersezione
    [Poliedri,Facce_pol,Lati_pol] = Crea_poliedri_1(i_punti,facce_inters,pos_nodi,Poliedri,Facce_pol,Lati_pol);
end

end

