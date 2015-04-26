%this function  basically morphs the two images firstly by calculating the
%affine wrap of each triangle in the triangulation and then calculating the
%bayecentric co ordinates of each pixel in the intermediate image and then
%mapping the corresponding points in the source image


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555
function morphed_im = morph(im1, im2, im1_pts, im2_pts, tri, warp_frac, dissolve_frac)

%computing average weighted shape
imMorph_pts =  (1-warp_frac)*im1_pts + (warp_frac)*im2_pts;

%affine wrapping between triangles
no_triang = size(tri, 1);
    affineWrap1 = zeros(3,3,no_triang);
    affineWrap2 = zeros(3,3,no_triang);
    
%calculating the affinewrap for each and every triangle
    for ind_triang = 1: no_triang
        affineWrap1(:,:,ind_triang) = computeAffine(im1_pts(tri(ind_triang,:),:), imMorph_pts(tri(ind_triang,:),:));
        affineWrap2(:,:,ind_triang) = computeAffine(im2_pts(tri(ind_triang,:),:), imMorph_pts(tri(ind_triang,:),:));
    end
    
%wraping both images to the new shape using the bayecentric co ordinates
    img1_wraped = imWrap(im1,tri, affineWrap1);
    img2_wraped = imWrap(im2,tri, affineWrap2);
    
%performing cross dissolve on two images    
    morphed_im = uint8((1-dissolve_frac)*double(img1_wraped) + (dissolve_frac)*double(img2_wraped));
    
    
    