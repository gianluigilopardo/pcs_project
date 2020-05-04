function [Lati_pol,Facce_pol,indice_facce ] = Crea_facce_1( N1,N2,N3,P1,P2,ind_P1,ind_P2,Lati_pol,Facce_pol )

if ind_P1==1 %P1 appartiene al lato formato da N1 ed N2
    
    if ind_P2==2 %P2 appartiene al lato formato da N2 ed N3
        
        Lati=[N2 P1; P1 P2; P2 N2; N1 N3; N1 P1; N3 P2];
        [Lati_pol,i_lati]=Ordina_lati(Lati_pol,Lati);
        Facce=[i_lati(1) i_lati(2) i_lati(3) -1; i_lati(4) i_lati(5) i_lati(6) i_lati(2)];
        [Facce_pol,indice_facce]=Ordina_facce(Facce,Facce_pol);
        return
    end
        
    if ind_P2==3 %%P2 appartiene al lato formato da N3 ed N1
        
       Lati=[N1 P1; P1 P2; P2 N1; N2 N3; N2 P1; N3 P2];
       [Lati_pol,i_lati]=Ordina_lati( Lati_pol,Lati );
       Facce=[i_lati(1) i_lati(2) i_lati(3) -1; i_lati(4) i_lati(5) i_lati(6) i_lati(2)];
       [Facce_pol,indice_facce]=Ordina_facce(Facce,Facce_pol);
       return 
    end
end

if ind_P1==2 %P1 appartiene al lato formato da N2 ed N3
    
    if ind_P2==1 %P2 appartiene al lato formato da N1 ed N3
        
        Lati=[N2 P1; P1 P2; N2 P2; N1 N3; N1 P2; N3 P1];
        [Lati_pol,i_lati]=Ordina_lati( Lati_pol,Lati );
        Facce=[i_lati(1) i_lati(2) i_lati(3) -1; i_lati(4) i_lati(5) i_lati(6) i_lati(2)];
        [Facce_pol,indice_facce]=Ordina_facce(Facce,Facce_pol);
        return
    end
        
    if ind_P2==3 %%P3 appartiene al lato formato da N3 ed N1
        
       Lati=[N3 P1; P1 P2; N3 P2; N1 N2; N1 P2; N2 P1];
       [Lati_pol,i_lati]=Ordina_lati( Lati_pol,Lati );
       Facce=[i_lati(1) i_lati(2) i_lati(3) -1; i_lati(4) i_lati(5) i_lati(6) i_lati(2)];
       [Facce_pol,indice_facce]=Ordina_facce(Facce,Facce_pol);
       return 
    end
end

if ind_P1==3 %P1 appartiene al lato formato da N3 ed N1
    
    if ind_P2==1 %P2 appartiene al lato formato da N1 ed N2
        
        Lati=[N1 P1; P1 P2; N1 P2; N2 N3; N2 P2; N3 P1];
        [Lati_pol,i_lati]=Ordina_lati( Lati_pol,Lati );
        Facce=[i_lati(1) i_lati(2) i_lati(3) -1; i_lati(4) i_lati(5) i_lati(6) i_lati(2)];
        [Facce_pol,indice_facce]=Ordina_facce(Facce,Facce_pol);
        return
    end
        
    if ind_P2==2 %%P3 appartiene al lato formato da N2 ed N3
        
       Lati=[N3 P1; P1 P2; N3 P2; N1 N2; N1 P1; N2 P2];
       [Lati_pol,i_lati]=Ordina_lati( Lati_pol,Lati );
       Facce=[i_lati(1) i_lati(2) i_lati(3) -1;i_lati(4) i_lati(5) i_lati(6) i_lati(2) ];
       [Facce_pol,indice_facce]=Ordina_facce(Facce,Facce_pol); 
       return 
    end
end

