%read fract file

function [res,n,res2,n2,nc] = fracttomatr(file)

f = fopen(file,'r'); 
n = fscanf(f,'%d',1)'; %salvo il primo valore, che indica il numero di righe
fgetl(f); %tolgo la prima riga inutile
res = fscanf(f,'%f',[4,n])'; res=res(:,2:4); %salvo la matrice con le info necessarie
n2 = fscanf(f,'%d',1)'; %salvo il primo valore, che indica il numero di righe
fgetl(f); %tolgo la prima riga inutile
mat=fscanf(f,'%f',[6,n2])';
nc = mat(:,2)';  %salvo il primo valore, che indica il numero di righe
res2 = mat(:,3:6); %salvo la matrice con le info necessari
end
