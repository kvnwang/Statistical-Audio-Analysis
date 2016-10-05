function [ bpm,lengths,keys ] = getValues( myFiles, count, songName )
%returns bpm, length, and keys 

% empty vector created
bpm=[];
lengths=[];
keys=[];
year=1;
%goes througha all songs in file
for k = 1:length(myFiles)
  baseFileName = myFiles(k).name;
  fullFileName = fullfile(songName, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
 %reads the songs for all songs in file
  [wavData, Fs] = audioread(fullFileName);
  tempo=getTempo(wavData, Fs);
  %adds the tempo, length, and keys to vector at each iteration
  bpm(year)=tempo;
  lengths(year)=getLength(wavData, Fs);
  keys(year)=getKey(wavData, Fs);
  year=year+1;
  
  
end



end

