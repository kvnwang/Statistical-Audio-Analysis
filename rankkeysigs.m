function keystrengths = rankkeysigs(rankedtones)
%Given the relative strength of tones in a song, returns a vector of the
%most likely keys.
%   Detailed explanation goes here

keys = zeros(12, 7);
keys(1,:) = [1 3 5 6 8 10 12];
keys(2,:) = [2 4 6 7 9 11 1];
keys(3,:) = [3 5 7 8 10 12 2];
keys(4,:) = [4 6 8 9 11 1 3];
keys(5,:) = [5 7 9 10 12 2 4];
keys(6,:) = [6 8 10 11 1 3 5];
keys(7,:) = [7 9 11 12 2 4 6];
keys(8,:) = [8 10 12 1 3 5 7];
keys(9,:) = [9 11 1 2 4 6 8];
keys(10,:) = [10 12 2 3 5 7 9];
keys(11,:) = [11 1 3 4 6 8 10];
keys(12,:) = [12 2 4 5 7 9 11];

keystrengths = zeros(12, 1);

for i = 1:12
    currentkeystrength = 0;
    for j = 1:7
        currentnote = keys(i, j);
        currentkeystrength = currentkeystrength + rankedtones(currentnote);
    end
    keystrengths(i) = currentkeystrength;
end



end

