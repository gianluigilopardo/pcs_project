%funzione per leggere tutti i file dei triangoli

function [res,nr] = filetomatr(file)

f = fopen(file,'r'); 
n = fscanf(f,'%d',2)'; %salvo il primo valore, che indica il numero di righe
nr = n(1); nc = n(2);
fgetl(f); %tolgo la prima riga inutile
res = fscanf(f,'%f',[nc+1,nr])'; 
res = res(:,2:nc+1);%salvo la matrice con le info necessarie
end


    
    