function esrimated_next_frame= forward_warp(current_frame,U,V)

[M,N,~]=size(current_frame);

esrimated_next_frame=current_frame;

u=real(U);
v=real(V);
for i=5:M-5
    for j=5:N-5
        for o =1:3
            
            if abs(u(i,j))>=10^(-4) || abs(v(i,j))>=10^(-4)
                
                
                i1=round(i+u(i,j));
                j1=round(j+v(i,j));
                
                if i1 > 0 && j1 > 0 && i1 <= M && j1 <= N                  
                    esrimated_next_frame(i1,j1,o)=current_frame(i,j,o);
                end
                
            end
        end
    end
end
end