
%function for calculating optical flow using Lucas_Kanade Method

function [U,V] = lucas_kanade_basic(current_frame,next_frame,win_size)

current_frame_gray=rgb2gray(current_frame);
next_frame_gray=rgb2gray(next_frame);
[M,N]=size(current_frame_gray);

k=(win_size-1)/2;
tau=0.0001;
current_frame_gray= padarray(current_frame_gray,[k k],0,'both');
next_frame_gray= padarray(next_frame_gray,[k k],0,'both');

s1=[1,0,-1;2,0,-2;1,0,-1];
s2=s1';

Ix=imfilter(current_frame_gray,s1);
Iy=imfilter(current_frame_gray,s2);
% [Ix,Iy]=gradient(f1);
It=current_frame_gray-next_frame_gray;

U=zeros(M,N);
V=zeros(M,N);

for i =k+1:M+k-1
    for j=k+1:N+k-1
        
        Ix1=Ix(i-k:i+k,j-k:j+k);
        Iy1=Iy(i-k:i+k,j-k:j+k);
        It1=It(i-k:i+k,j-k:j+k);
        
        
        Ixx=sum(sum(Ix1.*Ix1));
        Ixy=sum(sum(Ix1.*Iy1));
        Iyy=sum(sum(Iy1.*Iy1));
        Ixt=-sum(sum(Ix1.*It1));
        Iyt=-sum(sum(Iy1.*It1));
        
        
        P=[Ixx,Ixy;Ixy,Iyy];
        tr=Ixx+Iyy;
        lmin=det(P)/tr;
        Q=[Ixt;Iyt];
        
        if lmin>tau
            UV=P\Q;
            U(i,j)=UV(1,1);
            V(i,j)=UV(2,1);
        end
    end
end
U=U(k:M+k-1,k:N+k-1);
V=V(k:M+k-1,k:N+k-1);

end