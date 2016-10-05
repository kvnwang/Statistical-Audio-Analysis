%Roger LaCroix, a function that reports some data on a set. It takes in a key,
%tempo, and length vector, and later prompts the user for an input song and tells
%whether that song fits in the set and outputing print statements
function vecs = averagestats(keyvec, tempovec, lengthvec)
sort(lengthvec) %sorts the length vector so it's easier to work with
sminutes = floor(lengthvec(1)/60) %converts into number of minutes (of shortest song) by dividing by 60 and rounding down
sseconds = (lengthvec(1)/60-sminutes) *60 %calculates number of seconds by subtracting sminutes from the calculation and multiplying by 60
fprintf('The longest song in the set is %d minutes and %d seconds.', sminutes, sseconds)
lminutes = floor(lengthvec(length(lengthvec))/60) %performs the same operations as above for the longest song
lminutes = (lengthvec(length(lengthvec))/60-lminutes)*60
fprintf('The longest song in the set is %d minutes and %d seconds.', lminutes, lseconds)
avglength = sum(lengthvec)/length(lengthvec) %sums the length vec and divides by the number of values, then performs above calculations to find the average
aminutes = floor(avglength/60)
aseconds = (avglength/60-aminutes)*60
fprintf('The average song length in the set is %d minutes and %d seconds.', aminutes, aseconds)
sort(tempovec) %sorts the tempo vec so it's easier to work with
slowest = tempovec(1) %the slowest song is at the beginning of the vector
fprintf('The slowest song in the set is %d bpm.', slowest)
fastest = tempovec(length(tempovec)) %the longest song is at the end of the vector
fprintf('The fastest song in the set is %d bpm.', fastest)
fprintf('The average tempo in the set is %d bpm.', floor(sum(tempovec)/length(tempovec)))
countvec = zeros(1,length(keyvec)) %creates a new vector to store frequency
for i=1:length(keyvec)
    countvec(keyvec(i)) = countvec(keyvec(i)) + 1 %every time a value is found, its frequency is increased by 1
end
[val, index] = max(countvec) %reports the value and index of the maximum value in the frequency vector
mode = 'X' %placeholder for mode
%since different integers correspond to different tempo values in the getKey() function, this switch statement
%converts the integer value to the corresponding key
switch index
    case 1,
        mode = 'C'
    case 2,
        mode = 'C#'
    case 3,
        mode = 'D'
    case 4,
        mode = 'D#'
    case 5,
        mode = 'E'
    case 6,
        mode = 'F'
    case 7,
        mode = 'F#'
    case 8,
        mode = 'G'
    case 9,
        mode = 'G#'
    case 10,
        mode = 'A'
    case 11,
        mode = 'A#'
    case 12,
        mode = 'B'
end
fprintf('The mode key in this set is %s.', mode)
filename = input('Enter the .wav file you would like to compare.')
[signal, fs] = audioread(filename); %uses audioread on the specified file
tempovals = getTempo(signal, fs) %calls getTempo with the signal and fs from audioread
bpm = tempovals{1} %the first value in the cell array from getTempo is bpm
inputlength = getLength(signal, fs) %calls getLength() for the length of the input song
if((bpm > slowest && bpm > fastest) && (inputlength > lengthvec(1) && inputlength < lengthvec(length(lengthvec)))) %if the bpm and temop falls between the ranges of the set, it fits, if not, it doesn't
    disp('Your song fits in the set.')
else
    disp('Your song does not fit in the set')
end
end
