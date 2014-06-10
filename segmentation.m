im = imread('image1.jpg');
im = im2double(rgb2gray(im));
imean = mean(mean(im));
isd = std(std(im));
%thresh = mean(im(:,20));
thresh = imean+3*isd;
threshim = im<thresh;
figure,imshow(threshim,'InitialMagnification','fit');
str = ones(3);
threshim = imopen(threshim,str);
threshim = bwmorph(threshim,'clean');

cc = bwconncomp(threshim,4);

numPixels = cellfun(@numel,cc.PixelIdxList);
numP = numPixels;
for i = 1:length(cc.PixelIdxList)
    if(numP(1,i) <600)
        numP(1,i) = 0;
    end
end

for i = 1:length(cc.PixelIdxList)
    if numP(i)==0
        threshim(cc.PixelIdxList{i}) = 0;
    else
        threshim(cc.PixelIdxList{i}) = cc.PixelIdxList{i};
    end
end

figure,imshow(threshim,'InitialMagnification','fit');




