function key = determineKey(tonic, weightednotes)
%Takes a tonic value and a vector represented the notes in the 12-note
%chromatic scale. Determines key by comparing the major and minor 3rd.
%   Detailed explanation goes here
%author: mike nagler
%  date: 4/10/2016

key = tonic;

maj3rd = mod(tonic + 4, 12);
if maj3rd == 0
    maj3rd = 12;
end
min3rd = mod(tonic + 3, 12);
if min3rd == 0;
    min3rd = 12;
end

if min3rd > maj3rd
    key = key + 12;
end
end

