function [ medianD ] = GR_medianDistance( DG )
%Calculate median shortest distance
%
%Syntax:
%   [ medianD ] = GR_medianDistance( DG )
%Arguments:
%   DG      -   N-by-N sparse matrix that represents a graph or
%               N-by-N matrix  (connection matrix)
%
%Outputs:
%   medianD -  median shortest distance
%
%   SEE ALSO: GR_MaxGraphPower, GR_Diameter, GR_EdgesCount
%
%   $Revision: 1.1.3 $  $Date: 18-Sep-2012 19:56:36 $

if ~issparse(DG)
    DG = GR_CreateSparse(DG);
end

medianD = mean(GR_mat2vector( graphallshortestpaths(DG) ));

end
