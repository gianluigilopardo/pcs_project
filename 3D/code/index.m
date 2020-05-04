%% PROGETTO 2 - TETRAEDRIZZAZIONE

global node n_node n_ele ele neigh fract punti n_punti

[edge, n_edge] = edgetomatr('tetgen_e_fratture/barra.1.edge');
[ele, n_ele] = filetomatr('tetgen_e_fratture/barra.1.ele');
[neigh, n_neigh] = filetomatr('tetgen_e_fratture/barra.1.neigh');
[node, n_node] = filetomatr('tetgen_e_fratture/barra.1.node');
[face, n_face] = facetomatr('tetgen_e_fratture/barra.1.face');
[punti, n_punti, fract, n_fract, n_vert] = fracttomatr('tetgen_e_fratture/fract.pol');


for i=1:n_fract
    [n,d]=trovapiano(n_vert(i),fract(i,:),punti);
    posizionenodi = posnodi(n,d);
    [tetra_inters,Punti_pol,Lati_pol,Facce_pol,Poliedri,Punti_frattura,Sotto_frattura]=tetra(posizionenodi,n,d,i);
    [vicini,punti_vicini,lati_vicini,facce_vicini] = Tetra_vicini(tetra_inters);
    
end
