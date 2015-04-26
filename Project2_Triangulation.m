%                                                               Project 2
%Image Morphing of our own face with some another

%Name: Siddharth Saxena
%Penn Id :27304651

%In this program the face morphing has been achieved using triangulation

%Note : the code has been written in MATLAB R2013a. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

%reading base image
im1=imread('sidd.jpg');

%reading transition image
im2=imread('female-vampire.jpg');


[r1 c1 rgb1]=size(im1);
[r2 c2 rgb2]=size(im2);

%function in order to select the control points in the two images
[im1_pts,im2_pts]= click_correspondences(im1,im2);
im1_pts=[im1_pts;0 0;0 r1;c1 0;r1 c1];
im2_pts=[im2_pts;0 0;0 r2;c2 0;r2 c2];


%calcalculating the mean of the control points of the two images
mean_pts = (im1_pts+im2_pts)*0.5;


%performing delanauy triangulation
tri = delaunayTriangulation(mean_pts);
triplot(tri);


%creating image cells inorder to save 60 copies of the morphed image
imgarray=cell(60,1);
j=1;


%runing a loop in order to implement warping and dissolve  
for i=1:0.0167:2
    
    warp_func=(i-1);
    dissolve_func=(i-1);
    
%morphing of the image
morphed_im = morph(im1,im2,im1_pts,im2_pts,tri,warp_func,dissolve_func);
imgarray{j}=morphed_im;
j=j+1;

end


%calculating video
display_video(imgarray);