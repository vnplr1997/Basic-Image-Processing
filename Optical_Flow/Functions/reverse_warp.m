function residual_flow= reverse_warp(flow,U,V)

[M,N]=size(flow);

residual_flow=flow;

u=real(U);
v=real(V);
for i=5:M-5
    for j=5:N-5
        
        if abs(u(i,j))>=10^(-4) || abs(v(i,j))>=10^(-4)
                  
            i1=round(i-u(i,j));
            j1=round(j-v(i,j));
            
            if i1 > 0 && j1 > 0 && i1 <= M && j1 <= N
                residual_flow(i1,j1)=flow(i,j);
            end                        
        end
    end
end
end