function tonic = determineTonic(weightednotes)
%Takes in a lenght-12 row vector representing the 12 tones in western music
%and returns the most likely tonic.
%This is the first attempt at a key-determining algorithm, based on the
%success of this more will come.
%   Detailed explanation goes here
%author: mike nagler
%  date: 4/10/2016

%gets the value of the highest valued note
maxval = max(weightednotes);
maxindex = find(weightednotes == maxval);

%if there is no tie, we assume that the note with the highest rank is the
%tonic of the song
if length(maxindex) == 1
    tonic = maxindex;
%in the case of a tie we must find a way to get the most likely tonic. in
%this version of the algorithm i will choose to look at the perfect 4th for
%each
else
    fourths = zeros(1, maxindex);
    for i = 1:length(maxindex)
        fourthindex = mod(maxindex(i) + 5, 12);
        if fourthindex == 0
            fourthindex = 12;
        end
        fourths(i) = weightednotes(fourthindex);
    end    
    maxfourth = max(fourths);
    indexofmax4th = find(fourths == maxfourth);
    correspondingtonic = maxindex(indexofmax4th(1));
    tonic = find(weightednotes == correspondingtonic);
end


end

