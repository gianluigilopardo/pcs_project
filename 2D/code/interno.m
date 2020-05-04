function [ int ] = interno( N1,N2,N3,P )

int=0;
A=[N2'-N1' N3'-N1'];
y=A\(P'-N1');
if (y(1)>=-eps && y(1)<=1+eps && y(2)>=-eps && y(2)<=1+eps)
    if ((1-y(1)-y(2)>=-eps)&&(1-y(1)-y(2)<=1+eps))
        int=1; 
    end
end

end

