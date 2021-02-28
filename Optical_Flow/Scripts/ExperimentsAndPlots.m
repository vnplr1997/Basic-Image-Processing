current_frame=(im2double(imread('frame10.png')));
next_frame=(im2double(imread('frame11.png')));

flow_GT=readFlowFile('rubber.flo');
flow_GT = flowToColor(flow_GT);


win_size1=3;win_size2=5;win_size3=7;win_size4=15;
U0=0;V0=0;max_iter=1000;alpha=3;

% flow_HS1 = horn_schnuck(current_frame,next_frame,U0,V0,max_iter,alpha);
% flow_HS2 = horn_schnuck(current_frame,next_frame,U0,V0,max_iter,1/2*alpha);
% flow_HS3 = horn_schnuck(current_frame,next_frame,U0,V0,max_iter,2*alpha);
% flow_HS4 = horn_schnuck(current_frame,next_frame,U0,V0,max_iter,4*alpha);


% flow_LK1=lucas_kanade_final(current_frame,next_frame,win_size4,'lk');
% flow_LK2=lucas_kanade_final(current_frame,next_frame,win_size2,'lk');
% flow_LK3=lucas_kanade_final(current_frame,next_frame,win_size3,'lk');
% flow_LK4=lucas_kanade_final(current_frame,next_frame,win_size4,'lk');
% 

n_lev1=2;
n_lev2=4;
n_lev3=6;
n_lev4=8;

% flow_PLK1=optical_flow_pyramids(current_frame,next_frame,win_size4,n_lev1);
% flow_PLK2=optical_flow_pyramids(current_frame,next_frame,win_size,n_lev2);
% flow_PLK3=optical_flow_pyramids(current_frame,next_frame,win_size,n_lev3);
% flow_PLK4=optical_flow_pyramids(current_frame,next_frame,win_size,n_lev4);
% 

figure;

% subplot(2,2,1)
imshow(flow_GT)
title('Ground Truth')

% subplot(2,2,2)
% img = flowToColor(flow_HS1);
% imshow(img)
% title('Horn Schunck')

% subplot(2,2,3)
%  img = flowToColor(flow_LK1);
%  imshow(img)
%  title('Lucas Kanade')
% 
% subplot(2,2,4)
% img = flowToColor(flow_PLK1);
% imshow(img)
% title('Pyramids')
