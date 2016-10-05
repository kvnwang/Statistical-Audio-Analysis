function tonevals = gettonevals(tones, fva, inc)
%Takes in a vector of frequencies and returns a vector of their values.
%   Detailed explanation goes here

%start = floor(tones(1)/inc);
%fin = floor(tones(12)/inc);

tonevals = zeros(1, length(tones));

for i = 1:length(tones)
    ind = floor(tones(i)/inc);
    %margin = floor((tones(i)/60)/inc);
    %wintop = ind + margin;
    %winbot = ind - margin;
    %for j = winbot:wintop
    %    tonevals(i) = tonevals(i) + fva(j, 2);
    %end
    tonevals(i) = fva(ind, 2);
end
end

