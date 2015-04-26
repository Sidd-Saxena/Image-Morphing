%the function wraps the two images and then performs cross dissolve on them

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function z=morph_tps_wrapper(im1,im2,im1_pts,im2_pts,warp_frac,dissolve_frac)

%function for overall morphing of two images using tps
     mean_pts=(1-warp_frac)*im1_pts+(warp_frac)*im2_pts;
    
     %wrapping image 1
      z1=wrapper_tps(im1,im1_pts,mean_pts);
      
     %wrapping image 2
     z2=wrapper_tps(im2,im2_pts,mean_pts);
    
     %dissolving two images
     z=uint8((1-dissolve_frac)*z1+(dissolve_frac)*z2);
     
end