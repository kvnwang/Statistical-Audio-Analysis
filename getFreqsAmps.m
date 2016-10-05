function freqsAmps = getFreqsAmps(y, fs)
%Takes a signal, wav, and returns a vector of frequencies and amps
%represented as an n x 2 matrix, where n is the number of frequencies
%found.
%   Input signal y is transformed to the frequency domain using FFT. From
%   there it is simple to get frequencies using the sampling rate, fs and
%   amplitutes from the absolute value of the transformed vector. We then
%   cut off extraneous data. Since western music is defined by the range of
%   a piano, I only concern myself with a range that's confortable to play
%   on piano, which is (arbitrarily) 2 octaves below to 2 octaves above
%   middle C. This should be sufficient for any kind of music.
%author: mike nagler 
%  date: 4/7/2016

%y is suspected to be a colums vector representing a signal, so Y will be
%the FFT of y
l = length(y);%length of the signal
T = 1/fs; %time is seconds of each sample (1/44100s for a CD)
t = (0:l-1)*T; %vector of each time (in seconds) in the signal
NFFT = 2^nextpow2(l);
Y = fft(y, NFFT)/l;

%creates a row vector of all the frequencies of the signal
f = fs/2*linspace(0,1,NFFT/2+1);

%creates a column vector of the amplitutes (one for each frequency)
a = abs(Y(1:NFFT/2+1));
%take the transpose...
amps = a';

freqsAmps = zeros(length(f), 2);
freqsAmps(:,1) = f;
freqsAmps(:,2) = amps;

inc = f(2) - f(1);%discrete difference between frequencies

%2 octaves above middle c, a 0 to maxFreq is a very reasonable range to
%analyze a songs pitch. We're really only losing very high harmonics which
%we don't care about
maxFreq = 1150;
maxIndex = floor(maxFreq/inc); %how many increments until the max frequency

%2 octaves below middle c is about 65hz, and is a reasonable bottom end of
%the range we care about, so I will not cut more extraneous data
minFreq = 63;
minIndex = floor(minFreq/inc);

freqsAmps = freqsAmps(minIndex:maxIndex,:);


end

