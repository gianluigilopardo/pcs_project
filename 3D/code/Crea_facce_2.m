function [ Lati_pol,Facce_pol,indice_facce ] = Crea_facce_2( N1,N2,N3,P,i_vert,Lati_pol,Facce_pol )

if i_vert==1 %il vertice intersecato è nella prima posizione
    Lati=[N1 N2; N2 P; N1 P; N1 N3; N3 P];
    [Lati_pol,i_lati]=Ordina_lati(Lati_pol,Lati);
    Facce=[i_lati(1) i_lati(2) i_lati(3) -1; i_lati(4) i_lati(5) i_lati(3) -1];
    [Facce_pol,indice_facce]=Ordina_facce(Facce,Facce_pol);
    return
end

if i_vert==2 %il vertice intersecato è nella seconda posizione
    Lati=[N1 N2; N1 P; N2 P; N2 N3; N3 P];
    [Lati_pol,i_lati]=Ordina_lati(Lati_pol,Lati);
    Facce=[i_lati(1) i_lati(2) i_lati(3) -1; i_lati(4) i_lati(5) i_lati(3) -1];
    [Facce_pol,indice_facce]=Ordina_facce(Facce,Facce_pol);
    return
end

if i_vert==3 %il vertice intersecato è nella terza posizione
    Lati=[N1 N3; N1 P; N3 P; N2 N3; N2 P];
    [Lati_pol,i_lati]=Ordina_lati(Lati_pol,Lati);
    Facce=[i_lati(1) i_lati(2) i_lati(3) -1; i_lati(4) i_lati(5) i_lati(3) -1];
    [Facce_pol,indice_facce]=Ordina_facce(Facce,Facce_pol);
    return
end

