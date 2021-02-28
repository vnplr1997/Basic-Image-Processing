
function epe = endpointerror(flow1,flow2)

u1=flow1(:,:,1);
v1=flow1(:,:,2);
u1(u1>1000)=0;
v1(v1>1000)=0;
u2=flow2(:,:,1);
v2=flow2(:,:,2);

[M,N]=size(u1);
  
u=u1-u2;
v=v1-v2;

epe=sum(sum(u.^2))+sum(sum(v.^2));

epe=epe/(M*N);
    
end