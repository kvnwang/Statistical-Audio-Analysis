clc
clear

%gets data for 2000

myFiles2000 = dir(fullfile('2000','*.wav')); %gets all wav files in struct
count2000 = length(myFiles2000(not([myFiles2000.isdir]))); 
[bpm2000,lengths2000,keys2000]=getValues(myFiles2000, count2000, '2000');
uk2000 = length(unique(keys2000));
%averagestats(keyvec, tempovec, lengthvec)


%gets data for 2005
myFiles2005 = dir(fullfile('2005','*.wav')); %gets all wav files in struct
count2005 = length(myFiles2005(not([myFiles2005.isdir]))); 
[bpm2005,lengths2005,keys2005]=getValues(myFiles2005, count2005, '2005');
uk05 = length(unique(keys2005));


%gets data for 2010
myFiles2010 = dir(fullfile('2010','*.wav')); %gets all wav files in struct
count2010 = length(myFiles2010(not([myFiles2010.isdir]))); 
[bpm2010,lengths2010,keys2010]=getValues(myFiles2010, count2010, '2010');
uk10 = length(unique(keys2010));

%gets data for 2015
myFiles2015 = dir(fullfile('2015','*.wav')); %gets all wav files in struct
count2015 = length(myFiles2015(not([myFiles2015.isdir]))); 
[bpm2015,lengths2015,keys2015]=getValues(myFiles2015, count2015, '2015');
uk15 = length(unique(keys2015));

time=[2000 2005 2010 2015]

%creates a year vs time
lengths=[mean(lengths2000), mean(lengths2005), mean(lengths2010), mean(lengths2015)];
figure; plot(time, lengths)
xlabel('Year');
ylabel('Time(Sec)');
title('Country Songs Year vs Time');

%gets unique keys and graph
uniquekeys = [uk2000 uk05 uk10 uk15];
figure;
keys=plot(time, uniquekeys);
xlabel('Year');
ylabel('No. of Unique Keys');
ylim([2, max(uniquekeys)+1])
title('Unique keys in groups of songs over time');

%averages the years tempos and creates a year vs tempo graph
tempos=[mean(bpm2000), mean(bpm2005), mean(bpm2010), mean(bpm2015)];
figure; plot(time, tempos)
xlabel('Year');
ylabel('Tempo');
title('Countåry Songs Year vs Tempo');

%prints average stats
%averagestats reports the statistics on a single set of songs and prompts
%the user for an input song and predicts whether or not that song belongs
%in the set. The call is commented out because to perform our analysis over
%time we're looking at sets of sets of songs.
%averagestats(keyvec, tempovec, lengthvec)



