%funzione per leggere tutti i file dei triangoli

function [res,n] = filetomatr(file)

f = fopen(file,'r'); 
n = fscanf(f,'%d',1)'; %salvo il primo valore, che indica il numero di righe
fgetl(f); %tolgo la prima riga inutile
res = fscanf(f,'%f',[4,n])'; %salvo la matrice con le info necessarie
end

