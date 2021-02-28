%function for caluculating optical flow using iterative Lucas_Kanade method

function flow = lucas_kanade_final(current_frame,next_frame,win_size,mode)

[M,N,~]=size(current_frame);

[U,V] = lucas_kanade_basic(current_frame,next_frame,win_size);

for i =1:5
    estimated_next_frame=forward_warp(current_frame,U,V);
    [dU,dV] = lucas_kanade_basic(estimated_next_frame,next_frame,win_size);
    
     dU=reverse_warp(dU,U,V);
     dV=reverse_warp(dV,U,V);

    U=U+dU;
    V=V+dV;
end

if mode=='lk'
       
   
    flow=zeros(M,N,2);
    flow(:,:,1)=U;
    flow(:,:,2)=V;
    
    
    
elseif mode=='hs'
    
    alpha=1;
    max_iter=100;
    flow = horn_schnuck(current_frame,next_frame,U,V,max_iter,alpha);
    
    
    
end


end

