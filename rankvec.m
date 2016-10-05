function rankedvec = rankvec(vec)
%Ranks a vector OF ALL POSITIVE NUMBERS. Does not work if any element in
%the input is negative.
%   Detailed explanation goes here

len = length(vec);

for i = len:-1:1
    maxval = max(vec);
    maxind = find(vec == maxval);
    vec(maxind) = -1*i;
end

rankedvec = vec.*-1;

end

