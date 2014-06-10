function [label,c] = tracer(i,j,label, c, threshim)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here.

if (i > 1 && j >1)
if (threshim(i-1,j) == 1 && label(i-1,j) == 0)
    label(i-1,j) = c;
    [label,c] = tracer(i-1,j,label,c, threshim);
end

if (i > 1 && j >1)
if (threshim(i-1,j+1) == 1 && label(i-1,j+1) == 0)
    label(i-1,j+1) = c;
    [label,c] = tracer(i-1,j+1,label,c, threshim);
end 
end
if (i > 1 && j >1)
if (threshim(i,j+1) == 1 && label(i,j+1) == 0)
    label(i,j+1) = c;
    [label,c] = tracer(i,j+1,label,c, threshim);
end
end

if (i > 1 && j >1)
if (threshim(i+1,j+1) == 1 && label(i+1,j+1) == 0)
    label(i+1,j+1) = c;
    [label,c] = tracer(i+1,j+1,label,c, threshim);
end
end
if (i > 1 && j >1)
if (threshim(i+1,j) == 1 && label(i+1,j) ==0)
    label(i+1,j) = c;
    [label,c] = tracer(i+1,j,label,c, threshim);
end    
end
if (i > 1 && j >1)
if (threshim(i+1,j-1) == 1 && label(i+1,j-1) == 0)
    label(i+1,j-1) = c;
    [label,c] = tracer(i+1,j-1,label,c, threshim);
end
end
if (i > 1 && j >1)
if (threshim(i,j-1) == 1 && label(i,j-1) == 0)
    label(i,j-1) = c;
    [label,c] = tracer(i,j-1,label,c, threshim);
end
end
if (i > 1 && j >1)
if (threshim(i-1,j-1) == 1 && label(i-1,j-1) ==0)
    label(i-1,j-1) = c;
    [label,c] = tracer(i-1,j-1,label,c, threshim);
else
    c = c+1;
end
end

end
end

