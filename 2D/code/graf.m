
global n_ele ele node

for i = 1:n_ele
    x = [node(ele(i,2),2) node(ele(i,3),2) node(ele(i,4),2) node(ele(i,2),2)];
    y = [node(ele(i,2),3) node(ele(i,3),3) node(ele(i,4),3) node(ele(i,2),3)];
    plot(x,y,'b')
    axis([0 1 0 1])
    hold on
end
for j = 1:n_tracce
    x = [punti(tracce(j,2),2) punti(tracce(j,3),2)];
    y = [punti(tracce(j,2),3) punti(tracce(j,3),3)];
    plot(x,y,'r')
    axis([-1/4 5/4 -1/4 5/4])
end
