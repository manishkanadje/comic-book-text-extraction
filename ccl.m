im1 = imread('image1.jpg');
im = im2double(rgb2gray(im));
imean = mean(mean(im));
isd = std(std(im));
thresh = imean;
threshim = im < thresh;
figure, imshow(threshim, 'InitialMagnification','fit');
label = bwlabel(threshim,8);
lablist = unique(label);
count = histc(label(:),lablist);
freq = [lablist count];
%{
label = zeros(size(im));
figure, imshow(label, 'InitialMagnification','fit');
c = 1;
for i=2:size(im,1)-1
    for j = 2:size(im,2)-1
        if (threshim(i,j) == 1)
            label(i,j) = c;
            [label,c] = tracer(i,j,label,c,threshim,startrow,startcol);
        end
    end
end
%}
