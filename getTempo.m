function [ bpm ] = getTempo( signal, fs )
%	Tempo Tracking

min_tempo = 40;
max_tempo = 180;
tempo = min_tempo:max_tempo;
%the next four lines set rows 1 through (1/4)r to empty, then reevaluates
%the size of the matrix, and sets the last fourth of the rows (3r/4 -> r)
%empty in order to measure only the middle half of the matrix
[r, c] = size(signal);
signal(1:r/4,:) = [];
[r,c] = size(signal);
signal(floor(3*r/4):r,:) = [];
if (fs > 8000)
    downsample(signal, round(fs/8000));
    fs = 8000;
end



% Force the file to mono
signal = signal(:, 1);


fn = fs/2;
t = length(signal/fs);

f_cutoff = [200, 400, 800, 1600, 3200, 6400];
f_cutoff = f_cutoff./fn;

% Create 6 bands of ellpitic filters

% ord2 = ellipord(f_cutoff(1), f_cutoff(2), 3, 40);
% ord3 = ellipord(f_cutoff(2), f_cutoff(3), 3, 40);
% ord4 = ellipord(f_cutoff(3), f_cutoff(4), 3, 40);
% ord5 = ellipord(f_cutoff(4), f_cutoff(5), 3, 40);

[b1, a1] = ellip(6, 3, 40, f_cutoff(1), 'low');
[b2, a2] = ellip(6, 3, 40, [f_cutoff(1), f_cutoff(2)], 'bandpass');
[b3, a3] = ellip(6, 3, 40, [f_cutoff(2), f_cutoff(3)], 'bandpass');
[b4, a4] = ellip(6, 3, 40, [f_cutoff(3), f_cutoff(4)], 'bandpass');
[b5, a5] = ellip(6, 3, 40, [f_cutoff(4), f_cutoff(5)], 'bandpass');
[b6, a6] = ellip(6, 3, 40, f_cutoff(5), 'high');

% % Display the filters' frequency responses
% H = fvtool(b1, a1, b2, a2, b3, a3, b4, a4, b5, a5, b6, a6)
% set(H, 'FS', fs);

% Create a LPF with decay time of 200 ms
lpf2 = hann(.2*fs);
lpf2 = lpf2(round(length(lpf2)/2):end);

% Extract the envelop of each band from the elliptic filters
band1 = conv(lpf2, filtfilt(b1, a1, signal));
band2 = conv(lpf2, filtfilt(b2, a2, signal));
band3 = conv(lpf2, filtfilt(b3, a3, signal));
band4 = conv(lpf2, filtfilt(b4, a4, signal));
band5 = conv(lpf2, filtfilt(b5, a5, signal));
band6 = conv(lpf2, filtfilt(b6, a6, signal));

% Concatenate filters into matrix filterbank
bands = [band1, band2, band3, band4, band5, band6];

% Decimate the signals to fs = 200 (for  computational efficiency)
new_fs = 200;
bands = downsample(bands, ceil(fs/new_fs));

% Differentiate each band
bands = diff(bands);

% Half-wave Rectify each band
bands(find(bands<0)) = 0;

% Build comb filter banks in frequency domain
R = 0.9999;

filtered_signal = zeros(size(bands));
energy = zeros(1, length(tempo));

%t = 1.5*new_fs;
alpha = .7;


for bpm = min_tempo:max_tempo
	% Calculates the number of poles for the given BPM calculation
	L = round((new_fs*60)/bpm);
    
    b = 1 - alpha;
 	a = [1, zeros(1, L-1), -1*alpha];
    	
	filtered_signal = filter(b, a, bands);
	energy(bpm-min_tempo+1) = sum(sum(filtered_signal.^2));
end



plot(tempo, energy), grid on;
hold on;

% Finds the peak point

%%%%%%%%%%%%%%%%%%%%%%%%%%
%lines 107 and 108 were previously used to set the peak to zero in order to
%find the second highest peak, but we dropped that approach
%%%%%%%%%%%%%%%%%%%%%%%%%%

%[row, col] = find(energy == max(energy));
%energy(row, col) = 0;
[peak, sample] = max(energy);

sample = sample + min_tempo - 1;

bpm = find(energy == peak) + min_tempo;
if (length(bpm) > 1)
	%bpm = bpm(round(length(bpm)/2));
    bpm = bpm(1);
end

data_label_left = strcat(' \leftarrow   Tempo: ',num2str(bpm), ' bpm');
data_label_right = strcat('Tempo: ',num2str(bpm), ' bpm', ' \rightarrow ');

if (bpm > max_tempo/2)
    text(sample, peak, data_label_right, 'HorizontalAlignment','right');
else
    text(sample, peak, data_label_left, 'HorizontalAlignment','left');
end



%plot_title = sprintf('Tempo Strengths for "%s"', filename);
%title(plot_title);

%RESULT = sprintf('Tempo Estimation (bpm) for "%s": %d', filename, bpm)

%soundsc(signal, fs)
%tempovals = cell(bpm, tempo, energy)
end
