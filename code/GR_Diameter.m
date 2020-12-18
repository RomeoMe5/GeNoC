function [ d ] = GR_Diameter( DG )
%Calc diameter of graph
%
%Syntax:
% [ d ] = GR_Diameter( DG )
%Arguments:
%   DG  -   N-by-N sparse matrix that represents a graph. 
%           Nonzero entries in matrix G represent the weights of the edges.
%           or N-by-N connection matrix
%Outputs:
%   d   -  diameter of graph
%
% See also: GR_Filter, GR_Size.
%
%   $Revision: 1.2.0 $  $Date: 18-Sep-2012 20:03:29 $

if ~issparse(DG)
    DG = GR_CreateSparse(DG);
end

d = max(max( graphallshortestpaths(DG) ));

end

