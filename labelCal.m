function [labelName, label, freq] = labelCal(threshim, perc)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

label = bwlabel(threshim,8);
lablist = unique(label);
count = histc(label(:),lablist);
freq = [lablist count];
freq = sortrows(freq,2);
labelName = 0;
i = size(freq,1)-1;
while (i > 1)
    labelName = [labelName freq(i,1)];
    if ((freq(i,2) - freq(i-1,2))/freq(i,2) > perc)
        break;
    end
    i = i -1;
end
labelName = labelName(2:length(labelName));
end

