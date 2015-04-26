% This function calculates the morphed image using the affine wrap of each
% triangle and the bayecentric co ordiantes of each pixels in that
% triangles and then mapping it into the final image


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function morphed_im= imWrap(imgS, tri, affineWrap)
    
    numT = size(tri,1); 

    % Default target image
    imgTR = imgS(:,:,1);
    imgTG = imgS(:,:,2);
    imgTB = imgS(:,:,3);
    
    imgSR = imgS(:,:,1);
    imgSG = imgS(:,:,2);
    imgSB = imgS(:,:,3);


    [imgH, imgW] = size(imgTR);
    
    % Identify the Delaunay triangle in imgT
     idxMat = ones(imgH, imgW);
    [rows, cols] = (find(idxMat));
    
    
    %calculating the location of all the pixels in the image
    T = pointLocation(tri, cols, rows);
    indInvalid = isnan(T);
    indValid = ~indInvalid;
    
    TValid = T(indValid);
    colsValid = cols(indValid);
    rowsValid = rows(indValid);
    

    for indT = 1: numT
 
        affine_triang = affineWrap(:,:,indT);
        ind_triang = find(TValid==indT);
        num_Triang = length(ind_triang);
        
        %calculating the bayecentric co ordinates
        b = [colsValid(ind_triang)'; rowsValid(ind_triang)'; ones(1, num_Triang)];
        x=pinv(affine_triang)*b;
        x=floor(x);
        
        %eliminating all the out of border and negative values
        validInd = (x(1,:)>0 & x(1,:)<=imgW & x(2,:)>0 & x(2,:)<=imgH);
        
        x = x(:,validInd);
        b = b(:,validInd);
        
        ind_inter = sub2ind([imgH, imgW], b(2,:), b(1,:)); ind_inter = round(ind_inter);
        ind_source = sub2ind([imgH, imgW], x(2,:), x(1,:)); ind_source = round(ind_source);
        
        %Mapping the R G B values from the source to the morphed image
        imgTR(ind_inter) = imgSR(ind_source);
        imgTG(ind_inter) = imgSG(ind_source);
        imgTB(ind_inter) = imgSB(ind_source);

    end
    morphed_im = cat(3, imgTR, imgTG, imgTB);
end