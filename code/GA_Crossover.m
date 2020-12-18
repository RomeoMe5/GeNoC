function [ popV ] = GA_Crossover( individ1, individ2, childCount, CR_type )
%Generate new individual (chromosome) from parents
%
%Syntax:
% [ d ] = GA_Crossover( individ1, individ2, childCount, CR_type )
%Arguments:
%   individ1    -   first individual
%   individ2    -   second individual
%   childCount  -   numbers of child (population size) that will be
%   generated (default set by 1)
%   CR_type     -   type of crossover: 
%                   1 - one point (default)
%                   2 - two point
%                   3 - median
%Outputs:
%   popV        -  populations vector
%
% SEE ALSO: GA_MUTATION, GA_INVERSION.
%


if nargin < 4
    CR_type = 1;
end

if nargin < 3
    childCount = 1;
end

if size(individ1) ~= size(individ2)
    popV = [];
    warning('Count of chromosome in parents must be equal');
    return;
end

chromosomeC = length(individ1);

for i = 1 : childCount
    if CR_type == 2
        %choose random count of chromosome
        randChrC1 = GR_rand(chromosomeC);   
        randChrC2 = GR_rand(chromosomeC); 
        while randChrC1 == randChrC2
            randChrC2 = GR_rand(chromosomeC); 
        end
        rndChr1 = min([randChrC1 randChrC2]);
        rndChr2 = max([randChrC1 randChrC2]);
        
        rndChr1(rndChr1 == 0) = 1;
        
        popV(i, :) = [individ1(1:rndChr1) individ2(rndChr1 + 1:rndChr2)...
            individ1(rndChr2 + 1:end)];
    else
        %choose random count of chromosome
        if CR_type == 3
            randChrC = ceil(chromosomeC / 2);
        else
            randChrC = GR_rand(chromosomeC);
        end       
        popV(i, :) = [individ1(1:randChrC) individ2(randChrC + 1:chromosomeC)];
    end
end
end

