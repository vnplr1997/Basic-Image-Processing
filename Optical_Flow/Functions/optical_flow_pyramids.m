function flow = optical_flow_pyramids(I1,I2,win_size,n_lev)

I1 = imgaussfilt(I1,1);
I2 = imgaussfilt(I2,1);

[M,N,~]=size(I1);

I_h1=imresize(I1,2^(1-n_lev));
I_h2=imresize(I2,2^(1-n_lev));

[U,V] = lucas_kanade_basic(I_h1,I_h2,win_size);

for k =1:n_lev-1
    I_1=imresize(I1,2^(k-n_lev+1));
    I_2=imresize(I2,2^(k-n_lev+1));
    
    U=2*imresize(U,2,'bilinear');
    V=2*imresize(V,2,'bilinear');
    
    I_nex= forward_warp(I_1,U,V);
    
    [dU,dV] = lucas_kanade_basic(I_nex,I_2,win_size);
    
    dU=imresize(dU,size(U));
    dV=imresize(dV,size(V));
    
    dU=reverse_warp(dU,U,V);
    dV=reverse_warp(dV,U,V);

    
    U=U+dU;
    V=V+dV;
end

U=imresize(U,[M,N],'bilinear');
V=imresize(V,[M,N],'bilinear');

flow(:,:,1)=U;
flow(:,:,2)=V;

end

