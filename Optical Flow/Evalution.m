clear all;clc

flow_GT=readFlowFile('rubber.flo');

current_frame=(im2double(imread('frame10.png')));
next_frame=(im2double(imread('frame11.png')));

max_iter=1000;U0=0;V0=0;alpha=1;win_size1=9;

% flow_HS = horn_schnuck(current_frame,next_frame,U0,V0,max_iter,alpha);

% flow_LK1=lucas_kanade_final(current_frame,next_frame,win_size1,'lk');

n_lev=8;
flow_PLK= optical_flow_pyramids(current_frame,next_frame,win_size1,n_lev);


epe = endpointerror(flow_GT,flow_PLK);
ae = angularerror(flow_GT,flow_PLK);
