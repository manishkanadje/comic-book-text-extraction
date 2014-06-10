function [rectmap] = segmentFrame(kl)
%This function returns the boudaries of frame present in the input image.
% Input : kl - binary input image from which the frame needs to be extracted
% output : rectmap - it is a vector start column and start row along with
%          the length and height of the frame.
%
%Author: Manish Kanadje
%Date: December 1, 2013


%colnum = unique(kl);
colin = histc(kl,1);
start = 0;
i = 1;
stop = 0;
while (i <= length(colin))
    if (colin(i) ~= 0 && start==0)
        start = i;
    end
    if (start ~= 0 && colin(i) == 0 && stop==0)
        stop = i;
    end
    i = i + 1;
end
if stop == 0
    stop = length(colin);
end
%kl = kl(:,start:stop);
%rownum = unique(kl);
rowin = histc(kl,1,2);
startrow = 0;
p = 1;
stoprow = 0;
while (p <= length(rowin))
    if (rowin(p) ~= 0 && startrow==0)
        startrow = p;
    end
    if (startrow ~= 0 && rowin(p) == 0 && stoprow ==0)
        stoprow = p;
    end
    p = p + 1;
end
if stoprow == 0
    stoprow = length(rowin);
end
rectmap = [start startrow (stop-start) (stoprow-startrow)];


end

