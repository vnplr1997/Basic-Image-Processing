# Optical Flow Methods

Script files

1.ExperimentsAndPlots.m : comparing various methods with ground truth

2.Evalution.m : evalution of methods ,runs endpointerror.m and angularerror.m


Funcions:

1.Lucas_Kanade_basic.m : implements LK algorithm

2.Lucas_Kanade_final.m : implements iterative LK algorithm

3.optical_flow_pyramids.m : implements iterative LK algorithm with pyramids

4.horn_schnuck.m : implements HS algorithm

5.forward_warp.m : calculates estimated next frame using current frame and optical flow 

6.reverse_warp.m : changes the position of flow vectors back to original position

7.angularerror.m : calculates average angular error between 2 flows

8.endpointerror.m : calculates mean square error between 2 flows

## remaining functions are for color coding taken from middlebury vision/flow website
