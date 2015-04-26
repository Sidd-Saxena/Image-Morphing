%                                                               Project 2
%Image Morphing of our own face with some another

%Name: Siddharth Saxena
%Penn Id :27304651

%In this program the face morphing has been achieved usingthin plate spline
%function

%Note : the code has been written in MATLAB R2013a. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5


%reading base image
im1=imread('sidd.jpg');

%reading transition image
im2=imread('female-vampire.jpg');

[r1 c1 rgb1]=size(im1);
[r2 c2 rgb2]=size(im2);

% % % %function in order to select the control points in the two images
[im1_pts,im2_pts]= click_correspondences(im1,im2);
im1_pts=[im1_pts;0 0;0 r1;c1 0;r1 c1];
im2_pts=[im2_pts;0 0;0 r2;c2 0;r2 c2];

%creating an cell in order to save various images into it
imgarray=cell(60,1);
j=1;

%implementing dissolve and wrapping function

%we are considering 60 intermediate samples
for i=1:0.0167:2
    dissolve_frac=(i-1);
    warp_frac=(i-1);
    
morphed_im = morph_tps_wrapper(im1,im2,im1_pts,im2_pts,warp_frac,dissolve_frac);

imgarray{j}=(morphed_im);
j=j+1;
end

%displaying the final created video to stream all the intermediate images
display_video(imgarray);


