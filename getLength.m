function [ time ] = getLength( y, fs )
    %gets the length of an entire song by passing in a filename
    time = length(y)./fs; 
end

