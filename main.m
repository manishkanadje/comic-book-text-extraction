function[] = main(name)

%This matlab function extracts the text from comic book page and diplays that
%as image. This acts as a main function for this code.
%Name of the input image needs to be changed for ruuning the code.
%
%Author: Manish Kanadje
%Date : December 1, 2013


im1 = imread(name);
im2 = rgb2hsv(im1);
im = im2double(rgb2gray(im1));
imean = mean(mean(im));
isd = std(std(im));
thresh = imean;
threshim = im < thresh;
%figure, imshow(threshim, 'InitialMagnification','fit');


strel = [1;0;1];



[labelName, label, freq] = labelCal(threshim, 0.6);


for i=1:length(labelName)
    kl = 0 + (label==labelName(i));
    %figure, imshow(kl);
    
    
    rectmap = segmentFrame(kl);
    
    

    segImLabel = imcrop(im, rectmap);
    %figure, imshow(segImLabel);
    
    segImLabelChange = segImLabel;
    imgChange = zeros(size(segImLabel));
    p = 3;
    while (mean(mean(segImLabelChange)) <0.9)
            %figure, imshow(segImLabelChange);
            img1 = segImLabelChange;
            if (size(segImLabelChange,1) >= size(im,1)*0.6 || size(segImLabelChange,2) >= size(im,2)*0.6)
                if (p == size(segImLabelChange,2))
                    p = p - 2;
                end
                [img1,segImLabelChange] = connectedSeparate(segImLabelChange,p);
                p = p + 2;
            else
                segImLabelChange = 1;
            end
            %figure, imshow(img1);

            if (size(img1,1)<size(segImLabelChange,1)*0.2||size(img1,2)<size(segImLabelChange,2)*0.2)
                img1 = segImLabelChange;
                segImLabelChange = 1;
            end
            figure, imshow(img1);
      
      
        %First line
        segImLabel1 = img1 > 0.95;

       

        [labelName1, label1, frq1] = labelBalloon(segImLabel1);

        textMean = 0.3;

        for z=1:length(labelName1)
            a = 0 + (label1==labelName1(z));

            b = segmentFrame(a);
            c = imcrop(img1,b);
            threshText =  c < 0.7;
            figure, imshow(imcomplement(threshText));

            if (mean(mean(threshText)) < (textMean + 0.2) || mean(mean(threshText)) > (textMean - 0.2));
                %figure, imshow(c);
                
                %disp('extract Text');


                [labelNameText, labelText, frqTx] = labelCal(threshText,0.1);

                f = 0;
                l = 1;
                k = size(frqTx,1)-1;
                while (k > 1)
                    textSeg = 0 + (labelText==frqTx(k,1));
                    %figure, imshow(textSeg);
                    f = length(find(textSeg==1));
                    %disp(f);
                    if (f < 500 && f > 85)
                        textMap = segmentFrame(textSeg);
                        textWord = imcrop(textSeg,textMap);
                        figure, imshow(imcomplement(textWord));
                    end
                    k = k - 1;
                    l = l + 1;
                end
            end
        end
   %}
    end       
end
end




