function [ startPStruct ] = GA_GenerateStartPop_V2( ...
                                                         grSize,...
                                                         countPerEdge,...
                                                         COST_F_OPT,...
                                                         COST_PARAM,...
                                                         GR_OPTIONS...
                                                     )
                                                     
%Generate start population
%
%Syntax:
%Arguments:
%
%Outputs:
%   startPopulation -  generated population
%
%   SEE ALSO: ...
%
%   $Revision: 1.1 $  $Date: 18-Sep-2012 19:21:47 $


chrCount = GR_Size(grSize);

if round(sqrt(grSize))^2 - grSize == 0
    startPopulation(1, :) = GR_mat2vector( GR_THOR(sqrt(grSize)) );
else
    startPopulation = [];
end

if isempty( GR_OPTIONS.eg )
    MIN_E = grSize - 1;
else
    MIN_E = GR_OPTIONS.eg;
    MIN_E(MIN_E > grSize - 1) = grSize - 1;
end

if isempty( GR_OPTIONS.el )
    MAX_E = COST_PARAM.MAX_E;
else
    MAX_E = GR_OPTIONS.el;
    MAX_E(MAX_E > COST_PARAM.MAX_E) = COST_PARAM.MAX_E;
end

if ~isempty( GR_OPTIONS.ee )
    MIN_E = GR_OPTIONS.ee;
    MAX_E = GR_OPTIONS.ee;
end


MEAN_E = round( (MAX_E + MIN_E) / 2 );

indx(1) = MEAN_E;
for k = MIN_E + 1 : 1 : MAX_E
    indx(k - MIN_E + 1) = indx(k - MIN_E) + (-1)^(k - MIN_E) *(k - MIN_E);
end

for i = 1 : length(indx)
    startV = [ones(indx(i), 1); zeros(chrCount - indx(i), 1)];
    for j = 1 : countPerEdge
        startPopulation(end + 1, :) = Shuffle(startV);
    end  
end

startPStruct = GR_CreateGraphStruct(startPopulation, @GA_CostF_MDistMDiamMEdge_, COST_F_OPT);

end

