function [img1,imgChange,stopCol] = connectedSeparate(imgChange,p)






threshim = 0 + (imgChange >0.8);
%figure, imshow(threshim);

vertCount = histc(threshim,0,1);
vmean = mean(vertCount);
vsd = std(vertCount);
rowCount = histc(threshim,0,2);
rmean = mean(rowCount);
rsd = std(rowCount);
startRow = 0;
startCol = 0;
stopRow = 0;
stopCol = 0;

for i = p:length(vertCount)-2
    if (startCol+10 < i)
        if (startCol ~=0 && stopCol == 0)
            if(vertCount(i)*0.4 > vertCount(i+1) && (vertCount(i)*0.4 > vertCount(i+2)||vertCount(i+2)==0))
            %if(vertCount(i) > (vertCount(startCol) - 20) && (vertCount(i-1) < vertCount(i) && vertCount(i+1) < vertCount(i)))
                stopCol = i;
            end
        end
    end
    if (startCol == 0)
        if (vertCount(i-2)~=0&&vertCount(i-1)~=0 &&vertCount(i)~=0 && vertCount(i+1)~=0&&vertCount(i+2)~=0)
            %if (vertCount(i-1) < vertCount(i) && vertCount(i+1) < vertCount(i))
            if (vertCount(i) > (vmean))
                startCol = i;
            end
        end
    end
end

if startCol == 0
    startCol = 2;
end
if stopCol == 0
    stopCol = length(vertCount)-1;
end


for i = 3:length(rowCount)-2
    if (startRow+10 < i)
        if (startRow ~=0 && stopRow == 0)
            if(rowCount(i)*0.6 > rowCount(i+1) && (rowCount(i+1)*0.6 > rowCount(i+2)||rowCount(i+2)==0) )
            %if(rowCount(i) > (rowCount(startRow) - 10) && max(rowCount(i-1) < rowCount(i) && rowCount(i+1) < rowCount(i)))
                stopRow = i+2;
            end
        end
    end
    if (startRow == 0)
        if (rowCount(i-2)~=0&&rowCount(i-1)~=0 &&rowCount(i)~=0 && rowCount(i+1)~=0&&rowCount(i+2)~=0)
        %if (rowCount(i-1) < rowCount(i) && rowCount(i+1) < rowCount(i))
        %if (rowCount(i) > rmean)
             startRow = i;
        %end
        end
    end    
end

if startRow == 0
    startRow = 2;
end
if stopRow == 0
    stopRow = length(rowCount)-1;
end

rect = [startCol startRow (stopCol-startCol) (stopRow-startRow)];

img1 = imcrop(imgChange, rect);
%figure, imshow(img1);
imgChange(1:stopRow+1,1:stopCol+1) = 1;
%imgChange(startRow-1:stopRow+1,startCol-1:stopCol+1) = 1;
%figure, imshow(imgChange);



% Change the values of added white pixels for adding 1 betwwen startcol and
% stopcol.

%{
for i = startRow:size(threshim,1)
    if (threshim(i,startCol) == 1 && threshim(i,stopCol) == 1)
        if (sum(threshim(i,:))/size(threshim,2) > 0.8 && sum(threshim(i,:))/size(threshim,2) <0.95 )
            threshim(i,startCol:stopCol) = 1;
            %threshim(i+1,startCol:stopCol) = 1;
            %threshim(i+2,startCol:stopCol) = 1;
            
        end
    end
end


for i = startCol:size(threshim,2)
    if (threshim(startRow,i) == 1 && threshim(stopRow,i) == 1)
        if (sum(threshim(:,i))/size(threshim,1) > 0.8 && sum(threshim(:,i))/size(threshim,1) <0.95 )
            threshim(startRow:stopRow,i) = 1;
            %threshim(startRow:stopRow,i+1) = 1;
            %threshim(startRow:stopRow,i+2) = 1;
        end
    end
end


figure, imshow(threshim);

[labelNameSeg, labelSeg, freqSeg] = labelCal(threshim, 0.7);

for i=1:length(labelNameSeg)
    kl = 0 + (labelSeg==labelNameSeg(i));
    %figure, imshow(kl);
    
    
    rectmap = segmentFrame(kl);
    segImLabel = imcrop(im, rectmap);
    figure, imshow(segImLabel);
end
%}
end