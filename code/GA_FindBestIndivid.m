function [ bestIndivids ] = GA_FindBestIndivid( individs, indC, type )
%FindBestIndivid Summary of this function goes here
%   Detailed explanation goes here

if indC > length(individs)
    bestIndivids = individs;
    return;
end

if nargin < 3
    type = 1;
end

cost_f = [individs(:).Goal];

if type
    [~, index] = sort(cost_f);
else
    [~, index] = sort(cost_f, 'descend');
    index = Shuffle(index);
end

bestIndivids = individs(index(1 : indC));

end

