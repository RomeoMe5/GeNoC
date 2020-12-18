function [ startPopulation ] = GA_GenerateStartPop( chrCount, indNeeded, hardmode, edgesC )
%Generate start population
%
%Syntax:
% GA_GenerateStartPop( chrCount, indNeeded, hardmode )
%Arguments:
%   chrCount     -   numbers of individual's chromosomes
%   indNeeded    -   count of generated population
%   hardmode     -   select modes. 2 - hardmode, 1 -medium (edges count)
%                    0 - simple mode (default).
%
%Outputs:
%   startPopulation -  generated population
%
%   SEE ALSO: GA_MUTATION.
%

%   $Revision: 1.1 $  $Date: 18-Sep-2012 19:21:47 $


%set default simple mode
if nargin < 3
    hardmode = 0;
    edgesC = chrCount - floor(chrCount / 2.5);
end

if hardmode
%This mode should be enabled when simple mode was unable to create the 
%required number of examples. But we reccomended use only simple mode.
    if hardmode == 2
        k = chrCount - 1 : -1 : chrCount - 5;
    else
        k = edgesC + 3 : -1 : edgesC - 3;
    end
        
    k(k <= 0) = [];                 %if k  <= 0
    k(k > chrCount) = chrCount;     %if k >= chrCount
    
    %preallocating the memory
    startV = cell(length(k), 1);
    startPopulation = zeros(indNeeded, chrCount);
       
    for i = 1 : length(k)
        startV{i} = [ones(k(i), 1); zeros(chrCount - k(i), 1)];
    end
    
    for i = 1 : indNeeded
        startPopulation(i, :) = Shuffle(startV{GR_rand(length(k))});
    end
else
    startPopulation = round(rand(indNeeded, chrCount));
end

end

