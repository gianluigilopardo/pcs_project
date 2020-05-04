function [ int,punti_fratt,sotto_fratt ] = Poliedri_intersezione( Facc_punti,Fra_punti,posnodi,i_tetra,punti_fratt,n)

%Facc_punti sono le coordinate dei punti di intersezione
%Fra_punti sono le coordinate dei punti della frattura

sotto_fratt=zeros(6,1);
int=0;
Punti_int_facc=[];
Punti_int_fra=[];
Punti_fratt_taglio=[];
global ele node n_punti

%sommo i valori delle posizioni dei nodi in pos_tot
pos_tot=posnodi(ele(i_tetra,1))+posnodi(ele(i_tetra,2))+posnodi(ele(i_tetra,3))+posnodi(ele(i_tetra,4));

% nei primi due casi (pos_tot=4 o pos_tot=-4) i punti sono tutti sopra o sotto
% il teraedro, nel terzo e nel quarto (pos_tot=3 o pos_tot=-3) vi sarà un vertice 
% che non apperterrà al piano e gli altri tre sopra o sotto, dunque in questi
% casi non può esservi intersezione

if (pos_tot==4 || pos_tot==-4 || pos_tot==3 || pos_tot==-3) 
    int=-1;
    return
end

flag=1;

if size(Facc_punti,1)==0 %ovvero non vi sono intersezioni classiche
    
    if (pos_tot==1 || pos_tot==-1) %ciò vuol dire che tre vertice staranno sul piano, e devo considerare il caso dell'intersezione parallela

    flag=0;

    else 

    int=-1;
    
    return

    end
end

for i=1:4 % salvo i nodi che giacciono sul piano della frattura in Fac_punti
    if posnodi(ele(i_tetra,i))==0
        
        L=size(Facc_punti,1);
        Facc_punti(L+1,:)=node(ele(i_tetra,i));
        
    end
end

% si definiscono tre versore che appartengono al piano considerato per
% valutare l'appartenenza del punto alla faccia

E1=(Fra_punti(2,:)-Fra_punti(1,:))/norm(Fra_punti(2,:)-Fra_punti(1,:));
E2=cross(E1,n)/norm(n);
E3=(E1+E2)/norm(E1+E2);


L=size(Facc_punti,1);

for i=1:L
    s1=0;
    s2=0;
    s3=0;
    
    for j=1:n_punti-1
        pos_int=punti_appartiene_segmento(Facc_punti(i,:),Fra_punti(j,:),Fra_punti(j+1,:)); %controllo se il punto considerato appartenga ad un lato
            
        if pos_int==1 %in questo caso appartiene
            s1=10;
            s2=10;
            s3=10;
            break
        else
            k1=inters_interno(Facc_punti(i,:),Fra_punti(j,:),Fra_punti(j+1,:),E1);
            k2=inters_interno(Facc_punti(i,:),Fra_punti(j,:),Fra_punti(j+1,:),E2);
            k3=inters_interno(Facc_punti(i,:),Fra_punti(j,:),Fra_punti(j+1,:),E3);
            s1=s1+k1;
            s2=s2+k2;
            s3=s3+k3;
        end
    end
    
   if s1~=10 %il punto appartiene a qualche segmento
        pos_int=punti_appartiene_segmento(Facc_punti(i,:),Fra_punti(n_punti,:),Fra_punti(1,:));
  
        if pos_int==1
            s1=10;
            s2=10;
            s3=10;
        else
                
        k1=inters_interno(Facc_punti(i,:),Fra_punti(n_punti,:),Fra_punti(1,:),E1);
        k2=inters_interno(Facc_punti(i,:),Fra_punti(n_punti,:),Fra_punti(1,:),E2);
        k3=inters_interno(Facc_punti(i,:),Fra_punti(n_punti,:),Fra_punti(1,:),E3);
        s1=s1+k1;
        s2=s2+k2;
        s3=s3+k3;
            
        end
   end
  
   if (s1==s2 && s2==s3)
        if ((s1==1 || s1==10) && flag~=0)%il punto è interno
            int=1;
            l=size(Punti_int_facc,1);
            Punti_int_facc(l+1,:)=Facc_punti(i,:);
        elseif (flag==0 && (s1==1 || s1==10)) %siamo nel caso in cui la frattura è parallela ad una faccia del tetraedro
            int=1.5;
            l=size(Punti_int_facc,1);
            Punti_int_facc(l+1,:)=Facc_punti(i,:);
        end
   end
end

if size(Punti_int_facc,1)==L
    if flag==0 %nel caso di intersezione parallela se tutti i punti della faccia appartengono alla frattura non vi è intersezione
        int=0;
    end
else %se tutti i punti della faccia appartengono alla frattura allora sicuramente i punti della frattura non possono appartenere alla faccia
    
    %il modo di procedere è anologo a quanto fatto sopra
    
    E1=(Facc_punti(2,:)-Facc_punti(1,:))/norm(Facc_punti(2,:)-Facc_punti(1,:));
    E2=cross(E1,n)/norm(n);
    E3=(E1+E2)/norm(E1+E2);
    
    for i=1:n_punti
        s1=0;
        s2=0;
        s3=0;
        
        for j=1:L-1
            pos_int=punti_appartiene_segmento(Fra_punti(i,:),Facc_punti(j,:),Facc_punti(j+1,:));
        
            if pos_int==1
                s1=10;
                s2=10;
                s3=10;
                break
            else
                k1=inters_interno(Fra_punti(i,:),Facc_punti(j,:),Facc_punti(j+1,:),E1);
                k2=inters_interno(Fra_punti(i,:),Facc_punti(j,:),Facc_punti(j+1,:),E2);
                k3=inters_interno(Fra_punti(i,:),Facc_punti(j,:),Facc_punti(j+1,:),E3);
                s1=s1+k1;
                s2=s2+k2;              
                s3=s3+k3;
            end
        end
        if s1~=10
            
            pos_int=punti_appartiene_segmento(Fra_punti(i,:),Facc_punti(L,:),Facc_punti(1,:));
            if pos_int==1
                s1=10;
                s2=10;
                s3=10;
            else
                k1=inters_interno(Fra_punti(i,:),Facc_punti(L,:),Facc_punti(1,:),E1);
                k2=inters_interno(Fra_punti(i,:),Facc_punti(L,:),Facc_punti(1,:),E2);
                k3=inters_interno(Fra_punti(i,:),Facc_punti(L,:),Facc_punti(1,:),E3);
                s1=s1+k1;
                s2=s2+k2;
                s3=s3+k3;
            end
        end
        
        if (s1==s2 && s2==s3)
            if ((s1==1 || s1==10) && flag~=0)%il punto è interno
                int=1;
                l=size(Punti_int_fra,1);
                Punti_int_fra(l+1,:)=Fra_punti(i,:);
            elseif (flag==0 && (s1==1 || s1==10))
                int=1.5;
                l=size(Punti_int_fra,1);
                Punti_int_fra(l+1,:)=Fra_punti(i,:);
            end
        end

    end
end

%adesso bidogna calcolare i punti di intersezione tra i lati della faccia e
%i lati della frattura ciclando su tutti i lati

if (size(Punti_int_facc,1)~=L && size(Punti_int_fra,1)~=n_punti) %escludo il caso in cui tutti punti della faccia sono contenuti nella frattura e viceversa
    for i=1:n_punti-1
        for j=1:L-1
            P=intersezioni_segmenti(Fra_punti(i,:),Fra_punti(i+1,:),Facc_punti(j,:),Facc_punti(j+1,:));
            if P~=0
               l=size(Punti_fratt_taglio,1);
               Punti_fratt_taglio(l+1,:)=P; 
            end
        end
    end
    P=intersezioni_segmenti(Fra_punti(i,:),Fra_punti(i+1,:),Facc_punti(L,:),Facc_punti(1,:));
    if P~=0
    l=size(Punti_fratt_taglio,1);
    Punti_fratt_taglio(l+1,:)=P; 
    end
    
    for j=1:L-1
        P=intersezioni_segmenti(Fra_punti(n_punti,:),Fra_punti(1,:),Facc_punti(j,:),Facc_punti(j+1,:));
        if P~=0
        l=size(Punti_fratt_taglio,1);
        Punti_fratt_taglio(l+1,:)=P; 
        end
    end
    
    P=intersezioni_segmenti(Fra_punti(n_punti,:),Fra_punti(1,:),Facc_punti(L,:),Facc_punti(1,:));
    if P~=0
    l=size(Punti_fratt_taglio,1);
    Punti_fratt_taglio(l+1,:)=P; 
    end
end

%dopo aver salvato i punti di intersezione nella matrice Punti_fratt_taglio
%vado a creare la sottofrattura

if int>=1 %se avviene l'intersezione
    
    %in sotto_fratt il primo indice sarà quello del tetraedro con cui
    %avviene l'intersezione, il secondo è un -1 di default e gli altri
    %elementi saranno degli indici che individuano i punti di punti_fratt
    %che vanno a formare la sottofrattura
    
    sotto_fratt(1:2)=[i_tetra,-1];
    
    %con ordina_frattura salvo i punti in una matrice e li inddividuo con
    %degli indici
    
    [indici_1,punti_fratt]=ordina_frattura(punti_fratt,Punti_int_facc); 
    [indici_2,punti_fratt]=ordina_frattura(punti_fratt,Punti_int_fra);
    [indici_3,punti_fratt]=ordina_frattura(punti_fratt,Punti_fratt_taglio);
    L1=length(indici_1);
    L2=length(indici_2);
    L3=length(indici_3);
    for j=1:L1
        flag=1;
        for i=3:6
            if sotto_fratt(i)==0
                break
            elseif sotto_fratt(i)==indici_1(j) %controllo che il punto di interesse non appartenga già alla sottofrattura
                flag=0;
            end
        end
        if flag==1
            sotto_fratt(i)=indici_1(j); %nel caso in cui il punto non appartiene lo vado a salvare
        end
    end
    
    for j=1:L2
        flag=1;
        for i=3:6
            if sotto_fratt(i)==0
                break
            elseif sotto_fratt(i)==indici_2(j)  %controllo che il punto di interesse non appartenga già alla sottofrattura
                flag=0;
            end
        end
        if flag==1
            sotto_fratt(i)=indici_2(j); %nel caso in cui il punto non appartiene lo vado a salvare
        end
    end
    
    for j=1:L3
        flag=1;
        for i=3:6
            if sotto_fratt(i)==0
                break
            elseif sotto_fratt(i)==indici_3(j)  %controllo che il punto di interesse non appartenga già alla sottofrattura
                flag=0;
            end
        end
        if flag==1
            sotto_fratt(i)=indici_3(j); %nel caso in cui il punto non appartiene lo vado a salvare
        end
    end
                
    


end

