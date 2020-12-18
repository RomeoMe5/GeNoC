function [ gr_S ] = GR_Size( aVar )
%Return size of graph
%
%Syntax:
% [ gr_S ] = GR_Size( aVar )
%Arguments:
%   aVar        -  graph or amount of graph's node
%Outputs:
%   gr_S        -  count of nodes (if aVar - graph vector)
%               -  or size of vector (if aVar - count of nodes) 
%


aVarS = length(aVar);

if  aVarS > 1
    % aVar - graph vector
    gr_S = floor(sqrt(2 * aVarS)) + 1;
else
    % aVar- count of nodes
    gr_S = sum(1:aVar - 1);
end
end

