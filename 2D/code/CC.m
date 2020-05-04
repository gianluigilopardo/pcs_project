function [ curvilinee ] = CC( curvilinee,t1,t2,t3 )

if t1~=inf
    x=length(curvilinee);
    flag=0;
    for z=x:-1:1
        if t1==curvilinee(z)
            flag=1;
        end
    end
    if flag==0
        curvilinee(x+1)=t1;
    end
end

if t2~=inf
    x=length(curvilinee);
    flag=0;
    for z=x:-1:1
        if t2==curvilinee(z)
            flag=1;
        end
    end
    if flag==0
        curvilinee(x+1)=t2;
    end
end

if t3~=inf
    x=length(curvilinee);
    flag=0;
    for z=x:-1:1
        if t3==curvilinee(z)
            flag=1;
        end
    end
    if flag==0
        curvilinee(x+1)=t3;
    end
end

curvilinee=sort(curvilinee);

end

