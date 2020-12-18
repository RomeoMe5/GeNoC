function [ costFRes ] = GA_CostF_MDistMDiamMEdge_( graphStruct, options, COST_PARAM )
%Calculate cost (goal, target) function
%
%Syntax:
% [ costFRes ] = GA_CostF_DistDiamEdgePow_( graphStruct, options )
%Arguments:
%   graphStruct     -  graph struct
%   options         -  cost function options -> see init_gr
%
%Outputs:
%   costFRes        -  calculated goal function
%
% SEE ALSO: GA_CROSSOVER, GA_FILTER.
%
%   $Revision: 1.1.0 $  $Date: 28-Oct-2012 03:37:00 $

if nargin < 2 %default options
    options = struct( ...
    'power',    1, ...
    'diam',     1, ...
    'medDs',    1, ...
    'edgeC',    1 ...
    );
end
if nargin < 3
    COST_PARAM = GA_CalcWorstParam(graphStruct.Size);
end

MAX_D = COST_PARAM.MAX_D;
MAX_E = COST_PARAM.MAX_E;
MAX_DS = COST_PARAM.MAX_DS;
MAX_P = COST_PARAM.MAX_P;

costFRes =...
        options.diam  * (graphStruct.Diameter   / MAX_D) +...
        options.edgeC * (graphStruct.EdgeCount  / MAX_E) +...
        options.medDs * (graphStruct.MedDist    / MAX_DS) +...
        options.power * (graphStruct.Power      / MAX_P);

end

