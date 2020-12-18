function [ grPow ] = GR_MaxGraphPower( A )
%Return max power of graph nodes
%
%Syntax:
% [ grPow ] = GR_MaxGraphPower( A )
%Arguments:
%   A           -   N-by-N matrix  (connection matrix) or 
%                   N-by-N sparse matrix that represents a graph. 
%Outputs:
%   grPow        -  max power of graph nodes
%
% SEE ALSO: @todo: add similar functions
%
%   $Revision: 1.1.3 $  $Date: 15-Sep-2012 12:35:36 $

if ~issparse(A)
    grPow = max([sum(A,1)'; sum(A, 2)]);
else
    for i = 1 : size(A, 1)
        a(i) = nnz(A(i,:));
        b(i) = nnz(A(:,i));
    end
    grPow = max([a b]);
end


end

