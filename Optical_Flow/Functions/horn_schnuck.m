
%function for calculating optical flow using Horn_Schunck Method


function flow = horn_schnuck(current_frame,next_frame,U0,V0,max_iter,alpha)

current_frame_gray=rgb2gray(current_frame);
next_frame_gray=rgb2gray(next_frame);
[M,N]=size(current_frame_gray);

s1=[1,0,-1;2,0,-2;1,0,-1];
s2=s1';

Ix=imfilter(current_frame_gray,s1);
Iy=imfilter(current_frame_gray,s2);
% [Ix,Iy]=gradient(f1);
It=current_frame_gray-next_frame_gray;

U=U0;
V=V0;


kernel=[1/12 1/6 1/12;1/6 0 1/6;1/12 1/6 1/12];
for iter =1: max_iter
    UAvg=imfilter(U,kernel,'same');
    VAvg=imfilter(V,kernel,'same');
    % Compute flow vectors constrained by its local average and the optical flow constraints
    U= UAvg - ( Ix .* ( ( Ix .* UAvg ) + ( Iy .* VAvg ) + It ) ) ./ ( 4*alpha^2 + Ix.^2 + Iy.^2); 
    V= VAvg - ( Iy .* ( ( Ix .* UAvg ) + ( Iy .* VAvg ) + It ) ) ./ ( 4*alpha^2 + Ix.^2 + Iy.^2);
    
end

flow=zeros(M,N,2);
flow(:,:,1)=U;
flow(:,:,2)=V;


end




