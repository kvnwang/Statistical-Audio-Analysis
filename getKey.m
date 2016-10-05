function keynum = getKey(y, fs)
%Given the name of a song, returns its key as a number. 1-12 are major keys
%and 13-24 are all the minor keys.
%songname should be a filename of a .wav file.
%   Detailed explanation goes here

%[twocolsig, fs] = audioread(songname);
%y = twocolsig(:,1);
fva = getFreqsAmps(y, fs);
weightednotes = findabsPitches(fva);

%use these 2 lines for the tonic-tonality method
%tonic = determineTonic(weightednotes);
%keynum = determineKey(tonic, weightednotes);

%use the next section to find the key signature, no tonality found by
%adding amplitudes of all notes in that key
rankedpitches = findrelPitches(fva);
keystrengths = rankkeysigs(rankedpitches);
strongestkeys = find(keystrengths == max(keystrengths));
keynum = strongestkeys(1);

end

