% PROGETTO 1 - Triangolarizzazione

%inizializzazione 
tic
global edge ele neigh node punti tracce
global n_edge n_ele n_neigh n_node n_punti n_tracce


[edge, n_edge] = filetomatr('triangolazione_e_tracce/quad.1.edge');
[ele, n_ele] = filetomatr('triangolazione_e_tracce/quad.1.ele');
[neigh, n_neigh] = filetomatr('triangolazione_e_tracce/quad.1.neigh');
[node, n_node] = filetomatr('triangolazione_e_tracce/quad.1.node');
[punti, n_punti, tracce, n_tracce] = traccetomatr('triangolazione_e_tracce/trace.trace');

%salvo triangoli per ogni vertice
vertcom = [];
    for i = 1:n_node 
        s = 1;
        for j = 1:n_ele
            for k = 2:4
                if i == ele(j,k)
                    vertcom(s,i) = ele(j,1);
                    s = s+1;
                end
            end
        end
    end
    fid = fopen ('result.txt', 'wt');
%per ogni traccia

title = 'Programmazione e Calcolo Scientifico - Problema 1';
fprintf (fid, '%s\n\n\n', title);
for i_traccia=1:n_tracce
    [triangle,sottopoligoni3,sottopoligoni4,triangolazione,curvilinee] = trian(i_traccia);
    [lati,tagl] = vicinilato(triangle);
    [vert,tagv] = vicinivertice(triangle,tagl,vertcom);
    
    % scrittura su file

fprintf(fid, '\n\t\t%s %d', 'Risultati per la traccia numero', i_traccia);

%punto 1
title1 = '(1) Elenco dei triangoli tagliati dalla traccia (il numero del triangolo corrisponde alla colonna, la colonna corrisponde alla traccia).';
legend1_1 = ' 1 : intersezione';
legend1_0 = ' 0 : nessuna intersezione';
legend1_m1 = '-1 : nessuna intersezione, triangolo controllato';
legend1_m5 = '1/2: triangolo non intersecato ma sottotriangolato';
fprintf (fid, '\n\n%s\n\t%s\n\t%s\n\t%s\n\t%s\n \n\n', title1, legend1_1, legend1_0, legend1_m1, legend1_m5);
fprintf (fid, [repmat(' %d\t', [1, 16]) '\n'], triangle);
%fprintf (fid, '\n\n%s\n\t%s\n\t%s\n\t%s\n\t%s\n', title1, legend1_1, legend1_0, legend1_m1, mat2str(triangle));

%punto 2 
title2 = '(2) Elenco dei triangoli che condividono almeno un vertice con un triangolo tragliato.';
legend2_v = ' - Triangoli che condividono solo un vertice con un triangolo tagliato: ';
legend2_v2 = ' che condividono rispettivamente i vertici: ';
legend2_l = ' - Triangoli che condividono un lato con un triangolo tagliato: ';
legend2_l2 = ' che condividono rispettivamente i lati: ';
fprintf (fid, '\n\n%s\n\t%s\t%s\t%s%s\n\t%s\t%s\t%s\t%s \n\n', title2, legend2_v, mat2str(tagv), legend2_v2, mat2str(vert), legend2_l, mat2str(tagl),legend2_l2, mat2str(lati));
    % da stampare anche i lati e i vertici in corrispondenza

%punto 3 
title3 = '(3) Elenco dei si sottopoligoni ottenuti tagliando il triangolo con la traccia.';
fprintf (fid, '\n\n%s\n\t%s\n\t%s\n\n\n', title3, mat2str(sottopoligoni3,2), mat2str(sottopoligoni4,2));
    %stamp sottopoligoni3, sottopoligoni4

%punto 4
title4 = '(4) Sottotriangolazione conforme alla traccia ed al suo eventuale prolungamento.';
fprintf (fid, '\n\n%s\n\t%s\n\t%s\n\n\n', title4, mat2str(triangolazione,2), mat2str(sottopoligoni3,2));
    %stamp triangolazione [sottopoligoni3 fa parte della triangolazione]

%punto 5
title5 = '(5) Coordinate curvilinee delle intersezioni della traccia con i segmenti o punti della triangolazione.';
fprintf (fid, '\n\n%s\t%s\n', title5, mat2str(curvilinee,2));
    %stamp curvilinee


fprintf(fid, '\n\n\n\n');



end
fprintf(fid, '\n\n\n\n%s\n%s', 'Gabriele Fioravanti','Gianluigi Lopardo');

fclose (fid);
toc


