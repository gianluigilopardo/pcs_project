%funzione per leggere il file edge

function [res,n] = edgetomatr(file)

f = fopen(file,'r'); 
n = fscanf(f,'%d',1)'; %salvo il primo valore, che indica il numero di righe
fgetl(f); %tolgo la prima riga inutile
res = fscanf(f,'%f',[5,n])'; %salvo la matrice con le info necessarie
res = res(:,2:5);
end
