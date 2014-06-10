function [labelName, label, freq] = labelBalloon(threshim)

%This function selects the the connected components which can be a text
%balloon from given frame.
% input : frame from which balloons need to be extracted
% output : labeName : name of the label which can be a text balloon
%          label : matrix representing label of each pixel of the input
%          image
%          freq : matrix showing the count of each label
%
%Author: Manish Kanadje
%Date : December 1, 2013


label = bwlabel(threshim,8);
lablist = unique(label);
count = histc(label(:),lablist);
freq = [lablist count];
freq = sortrows(freq,2);
%labelName = 0;
i = 1; % size(freq,1)-2;
labelName = freq(size(freq,1)-1,1);

while (i < 6)    
    if (size(freq,1)-1-i > 2)
        if (freq((size(freq,1)-1),2)*0.1 > (freq((size(freq,1))-1-i,2)));
            break;
        end
    
    labelName = [labelName freq((size(freq,1))-1-i,1)];
    end
    i = i + 1;
end
%labelName = labelName(2:length(labelName));
end



