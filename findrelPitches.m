function relPitches = findrelPitches(fva)
%A second approach to ranking pitches in a song. Instead of summations of
%amplitudes, this ranks each note in each octave and sums the rank relative
%to each other.
%   Detailed explanation goes here

baseTones = [65.4, 69.3, 73.4, 77.8, 82.4, 87.3, 92.5, 98, 103.8, 110, 116.5, 123.5];
%tonevec = zeros(1, 48);
octave1 = baseTones;
octave2 = baseTones.*2;
octave3 = baseTones.*4;
octave4 = baseTones.*8;

inc = fva(2,1) - fva(1,1);

relPitches = zeros(1, 12);

weights1 = gettonevals(octave1, fva, inc);
weights2 = gettonevals(octave2, fva, inc);
weights3 = gettonevals(octave3, fva, inc);
weights4 = gettonevals(octave4, fva, inc);

relweights1 = rankvec(weights1);
relweights2 = rankvec(weights2);
relweights3 = rankvec(weights3);
relweights4 = rankvec(weights4);

for i = 1:length(relPitches)
    relPitches(i) = relweights1(i) + relweights2(i) + relweights3(i) + relweights4(i);
end





end

