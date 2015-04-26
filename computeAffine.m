%this function basically calculates the affine transformation for each
%triangle in the triangulation

function affineWrap = computeAffine(im1_pts, im2_pts)

%computing affine wrap
    
A = zeros(6,6);
    A(1:3, 1:2) = im1_pts;
    A(1:3, 3) = ones(1,3);
    A(4:6, 4:5) = im1_pts;
    A(4:6, 6) = ones(1,3);
    
    b = zeros(6,1);
    b(1:3,1) = im2_pts(:,1);
    b(4:6,1) = im2_pts(:,2);

    x = A\b;
    
    affineWrap = [x(1), x(2), x(3); x(4), x(5), x(6); 0, 0, 1];
    
    