function [ handler, GR_IM ] = GR_View( DG )
%Create new window and view the graph
%
%Syntax:
% [ h ] = GR_View( DG )
%Arguments:
%   DG      -  N-by-N sparse matrix that represents a graph. 
%              Nonzero entries in matrix G represent the weights of the edges.
%   screen_size - size of screen
%Outputs:
%   h       -  handle to window
%
% See also: GR_Filter, GR_Size, GR_IsGrapCool, GR_Diameter.
%
%   $Revision: 1.5 $  $Date: 29-Sep-2012 15:12:00 $

% Rev log {
%   added next options: 
%       - get handler to figure
%       - get image from figure.
% } endlog

aS = size(DG, 1);

for i = 1 : aS
    for j = 1 : aS
        if(i > j)
            DG(i, j) = DG(1, 1);
        end
    end
    nodeIDS{i} = num2str(i);
end

BGobj = biograph(DG,nodeIDS,'ShowWeights','off', 'ShowArrows', 'off');
g = biograph.bggui(BGobj);
handler = get(g.biograph.hgAxes,'parent');
set(handler, 'Units','normalized', 'Position', [0 0 1 1 ] );
GR_IM = getframe(handler);

end

