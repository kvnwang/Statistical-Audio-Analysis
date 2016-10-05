function absPitches = findabsPitches(fva)
%TTakes in an n x 2 matrix where the first column represents frequencies of
%a signal and the second column the amplitudes of those frequencies. This
%function uses a window to find pitches in a signal and create a vector
%with their absolute weight.
%   Detailed explanation goes here
%author: mike nagler
%  date: 4/7/2016

%the following block of code creates a vector represented hz values of
%musical pitches. The first element is C2 and the last is B5. The vector is
%created based on the Hz values of notes in the lowest octave and the rest
%are generated with relaively good precision based on the principle that
%the same note an octave up is twice the frequency.
baseTones = [65.4, 69.3, 73.4, 77.8, 82.4, 87.3, 92.5, 98, 103.8, 110, 116.5, 123.5];
tonevec = zeros(1, 48);
tonevec(1:12) = baseTones;
tonevec(13:24) = baseTones.*2;
tonevec(25:36) = baseTones.*4;
tonevec(37:48) = baseTones.*8;

%finds increment between frequencies 
inc = fva(2,1) - fva(1,1);

%in absPitches I will store the sum of the amplitudes of each tone. ie in
%absPitches(1) will be amp(C2)+...+amp(C5). Here we initialize to zero.
absPitches = zeros(1, 12);

%this is the main loop of this function
%its purpose is to find the  amplitudes of each important pitch and put
%that value into absPitches in the appropriate bin. It uses a window to
%account for musicians being slightly out of tune. Idealy the function
%generates a window of about 1/4 tone on each side
for i = 1:length(tonevec)
    
    currentpitch = tonevec(i);%value of the pitch for this iteration
    pitchindex = floor(currentpitch/inc);%finds the row in fva of the pitch
    relpitch = mod(i, 12);
    if relpitch == 0
        relpitch = 12;
    end
    %basepitchpair = [relpitch, currentpitch, baseTones(relpitch)]
    
    %now to generate the window
    %the first attempt will be the function 2*(currentpitch/basetone)
    %which will represent variance on either side of the pitch
    %for now i will not consider a case where we have an index out of
    %bounds
    halfwin = 2*(currentpitch/baseTones(relpitch));
    numindices = floor(halfwin/inc);
    wintop = pitchindex + numindices;
    winbot = pitchindex - numindices;
    
    pitchamp = 0;
    
    %this inner loop handles the sum
    for j = winbot:wintop
        pitchamp = pitchamp + fva(j,2);
    end
    
    %gets the pitch ignorate of octave
    absPitches(relpitch) = pitchamp;
end
end