%this function performs the calculation of TPS equation in order to porph
%the two images to the intermediate ones 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55


function z=wrapper_tps(img,img_pts,intermediate_pts)

     %function called for warping an image using tps in x and y directions seperately
     [a1_x,ax_x,ay_x,w_x]=est_tps(intermediate_pts,img_pts(:,1));
     [a1_y,ax_y,ay_y,w_y]=est_tps(intermediate_pts,img_pts(:,2));
     
     %ctr_pts is the intermediate point which needed to be wrapped into
     %source image
     ctr_pts=intermediate_pts;
     %sz is the size of the desired morphed image
     sz=[size(img,1) size(img,2)];
     z=morph_tps(img,a1_x,ax_x,ay_x,w_x,a1_y,ax_y,ay_y,w_y,ctr_pts,sz);
end