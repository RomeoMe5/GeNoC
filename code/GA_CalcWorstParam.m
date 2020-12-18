function [ COST_PARAM ] = GA_CalcWorstParam( grSize )
%Calculate cost parameters (maximum minDiam, maximum power etc)
%
%Syntax:
% [ COST_PARAM ] = GA_CalcWorstParam( grSize )
%Arguments:
%   COST_PARAM      -  count of graphs nodes
%
%Outputs:
%   COST_PARAM      -  cost parameters
%
% SEE ALSO: GA_COSTF_MDISTMDIAMMEDGE_
%
%   $Revision: 1.0 $  $Date: 28-Oct-2012 09:30:00 $


COST_PARAM.MAX_D = 2*(grSize.^(0.5)-1);%grSize - 1;
COST_PARAM.MAX_E = 2*(grSize-grSize.^(0.5));%sum(1:COST_PARAM.MAX_D);
COST_PARAM.MAX_DS = (2*grSize-1)/(3*(grSize.^(0.5)));%GR_medianDistance( GR_WorstMat(grSize) );
COST_PARAM.MAX_P = 4;%COST_PARAM.MAX_D;

end

