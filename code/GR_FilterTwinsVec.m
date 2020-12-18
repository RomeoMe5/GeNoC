function [ filtered_individs ] = GR_FilterTwinsVec( vec )
%Delete twins

filtered_individs = unique(vec, 'rows');

end

