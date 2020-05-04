function [ tetra_inters,Punti_pol,Lati_pol,Facce_pol,Poliedri,Punti_frattura,Sotto_frattura] = tetra( posizionenodi,n,d,i_fract )

global n_ele n_punti fract punti

tetra_inters=zeros(1,n_ele);
Punti_pol=[];
Lati_pol=[];
Facce_pol=[];
Poliedri=[];
Punti_frattura=[];
Sotto_frattura=[];
coda=[];

Fra_punti=zeros(n_punti,3);

for i=1:n_punti(i_fract)

    %salvo i punti della frattura poiché mi serviranno nel valutare
    %l'intersezione tra essa e i vari tetraedri
    Fra_punti(i,:)=punti(fract(i_fract,i),:);

end

for i=1:n_ele
    [punti_intersezione,pos_int,pos_nodi] = Intersezione_punti(posizionenodi,n,d,i); %calcola l'interseione tra piano della frattura e tetraedro
    [tetra_inters(i),Punti_frattura,Sotto_frattura(1,:)]=Poliedri_intersezione( punti_intersezione,Fra_punti,posizionenodi,i,Punti_frattura,n); %verifico se vi è intersezione tra tetraedro e frattura
     
    if tetra_inters(i)==1 %appena trovo un intersezione si inizierà il procedimento di coda
        
        [Poliedri,Facce_pol,Lati_pol,Punti_pol]=Sottopoliedri(punti_intersezione,pos_int,i,pos_nodi,Poliedri,Facce_pol,Lati_pol,Punti_pol); %creo i sottopoliedri
        
        coda=Coda(coda,tetra_inters,i); %aggiorno la coda
        lun=length(coda);
        i_coda=0;
                
        while i_coda~=lun %ciclo fino ad aver finito la coda
            
             i_coda=i_coda+1;
             [punti_intersezione,pos_int,pos_nodi] = Intersezione_punti(posizionenodi,n,d,coda(i_coda)); %calcola l'interseione tra piano della frattura e tetraedro inserito in coda
             LL=size(Sotto_frattura,1);
             [tetra_inters(coda(i_coda)),Punti_frattura,Sotto_frattura(LL+1,:)]=Poliedri_intersezione( punti_intersezione,Fra_punti,posizionenodi,coda(i_coda),Punti_frattura,n);%verifico che l'intersezione sussiste
             
             if tetra_inters(coda(i_coda))==1 %se vi è intersezione con il triangolo della coda
                    
                 [Poliedri,Facce_pol,Lati_pol,Punti_pol]=Sottopoliedri(punti_intersezione,pos_int,i,pos_nodi,Poliedri,Facce_pol,Lati_pol,Punti_pol); %creo i sottopoliedri
                 coda=Coda(coda,tetra_inters,coda(i_coda)); %aggiorna la coda
                 lun=length(coda); %aggiorno la lunghezza della coda
             end
             
        end
    
    end
    
    if ~isempty(coda)  %se è iniziato il meccanismo di coda esci dal ciclo generale
        break
    end

   
end

