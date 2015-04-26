%function in order to morph the two images into the intermediate using the
%thin plate sline equation

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function morphed_im= morph_tps(img1, a1_x, ax_x, ay_x, w_x, a1_y, ax_y, ay_y, w_y, ctr_pts,sz)
   

    %defining an zero image of th image sz in order to store the resultant
    %pixels
    morphed_im=double(zeros([sz 3]));
    
    [rows Cols rgb]=size(img1);
    
    %vectorisation the coloumn indices,number of rows times
    X_array=repmat([1:Cols],1,rows);
    
    %replicating the above array as per the number of of control points
    %selected  
    X1_array=repmat(X_array,size(ctr_pts,1),1);
    
    %vectorisation the rows indices,number of coloumn times
    Y1_array=reshape(repmat([1:rows],Cols,1),[1 Cols*rows]);
 
    %replicating the above array as per the number of of control points
    %selected   
    Y_array=repmat(Y1_array,size(ctr_pts,1),1);
     
    
    carrX=repmat(ctr_pts(:,1),1,size(X1_array,2));
    carrY=repmat(ctr_pts(:,2),1,size(Y_array,2));
    
    %Calculating the Eucledian Distances betwenn the point    
    diff_X=carrX-X1_array;
    diff_Y=carrY-Y_array;
    U=((diff_X.*diff_X)+(diff_Y.*diff_Y));
    
   
    %avoiding the zeros value of k as the log of it will be NAN
    temp=(U~=0);
    U=-1*U.*log(U);
    U(temp==0)=0;
     
    
    if (size(w_x,1)==1) 
        w_x=transpose(w_x);
    end
    if (size(w_y,1)==1)
        w_y=transpose(w_y);
    end   
    
    %Implementation of the thin platespline function
    
    fx=a1_x + ax_x*X_array + ay_x*Y1_array + transpose(w_x)*U; 
    fy=a1_y + ax_y*X_array + ay_y*Y1_array + transpose(w_y)*U;
    
    % rounding off the values of fx and fy
    fx_C=ceil(fx);
    fx_F=floor(fx);
    fy_C=ceil(fy);
    fy_F=floor(fy);
    
    wt__X=fx-fx_F;
    wtY=fy-fy_F;
    
    %Bounding all the negative pixels to 1 
    fx_F(fx_F<=0) =1;
    fy_F(fy_F<=0)=1;
    fx_C(fx_C<=0) =1;
    fy_C(fy_C<=0)=1;
    
   %Bounding all the out of range pixels to the borders
    fx_F(fx_F>Cols)=Cols;
    fy_F(fy_F>rows)=rows;
    fx_C(fx_C>Cols)=Cols;
    fy_C(fy_C>rows)=rows;
    
    
      %implementing a for loop in order to copy pixels from base image into the
    %morphed image
    for i=1:size(fx,2) 
        morphed_im(Y1_array(1,i),X_array(1,i),:)=(1-wt__X(1,i))*(1-wtY(1,i))*img1(fy_F(1,i),fx_F(1,i),:) ...
          + (wt__X(1,i))*(1-wtY(1,i))*img1(fy_F(1,i),fx_C(1,i),:) ...
          + (1-wt__X(1,i))*(wtY(1,i))*img1(fy_C(1,i),fx_F(1,i),:) ...
          +(wt__X(1,i))*(wtY(1,i))*img1(fy_C(1,i),fx_C(1,i),:);
     
    end
   
end