%this function displays the morphed images in the form of an video
%VideoWriter has been used instead of avifile because that was giving an
%error in MATLAB R2013a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

function display_video(imgarray)

%displaying the images in the form of video

writerObj = VideoWriter('Project2_triangulation.avi');

for i = 1 : 60
    open(writerObj);
    %considering one image at a time from the cell
    fimage=imgarray{i};
    
    %writing the image into the image object
    writeVideo(writerObj,fimage);

end
close(writerObj);

% Playing the final obtained video
implay('Project2_triangulation.avi');

end
