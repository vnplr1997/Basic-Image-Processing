
function ae = angularerror(flow1,flow2)

u1=flow1(:,:,1);
v1=flow1(:,:,2);
u1(u1>1000)=0;
v1(v1>1000)=0;
u2=flow2(:,:,1);
v2=flow2(:,:,2);

[M,N]=size(u1);

ae=0;
  
for i =1:M
    for j=1:N
        a1=u1(i,j);
        b1=v1(i,j);
        a2=u2(i,j);
        b2=v2(i,j);
        tmp1=(1+a1*a1+b1*b1)^(0.5);
        tmp2=(1+a2*a2+b2*b2)^(0.5);
        tmp=tmp1*tmp2;
        t=abs(acos((1+a1*a2+b1*b2)/tmp));
        ae=ae+t;
    end
end

ae=ae/(M*N);
    
end