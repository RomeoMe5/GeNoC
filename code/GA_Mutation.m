function [ pop ] = GA_Mutation( individ, chr2changes )
%Make mutation at the individual
%
%Syntax:
% [ pop ] = GA_Mutation( individ, chr2changes )
%Arguments:
%   individ     -  individual who becomes a mutant
%   individ2    -  second individual
%   chr2changes -  numbers of chromosomes that might be changed
%   (default set by 1)
%
%Outputs:
%   pop         -  new mutant
%
% SEE ALSO: GA_CROSSOVER, GA_INVERSION.
%


if nargin < 2
    chr2changes = 1;
end

chr2changes(chr2changes > length(individ)) = length(individ);

chromosomeC = length(individ);

randChr = floor(chromosomeC * rand(chr2changes,1));
randChr(randChr == 0) = 1;  
randChr = unique(randChr);

pop = individ;
pop(randChr) = 1 - pop(randChr); 
    
end

