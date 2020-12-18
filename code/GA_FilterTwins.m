function [ filtered_individs ] = GA_FilterTwins( individs )
%Delete twins

[~, index] = unique(reshape([individs(:).Vector], length(individs(1).Vector), [])', 'rows');
filtered_individs = individs(index);

end

