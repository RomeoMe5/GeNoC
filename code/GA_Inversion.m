function [ newIndivid ] = GA_Inversion( individ )
%cyclic shift of the chromosomes
%
%Syntax:
%  [ newIndivid ] = GA_Inversion( individ )
%Arguments:
%   individ     -  current individual
%
%Outputs:
%   newIndivid  -  new individual
%
% SEE ALSO: GA_CROSSOVER, GA_MUTATION.
%


chromosomeC = length(individ);
ChrC = floor(chromosomeC * rand(1,1));
ChrC(ChrC == 0) = 1;

indS = size(individ);

if indS(1) < indS(2)
    newIndivid = circshift(individ', ChrC);
    newIndivid = newIndivid';
else
    newIndivid = circshift(individ, ChrC);
end

end

