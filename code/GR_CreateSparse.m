function [ DG ] = GR_CreateSparse( A )
%Create sparse matrix that represents a graph
%
%Syntax:
%   [ DG ] = GR_CreateSparse( A )
%Arguments:
%   A   -   N-by-N connections matrix that represents a graph or vector. 
%   
%Outputs:
%   DG  -   N-by-N sparse matrix that represents a graph. 
%           Nonzero entries in matrix G represent the weights of the edges.
%
% See also: GR_Filter, GR_Size.
%


if min(size(A)) == 1
    A = GR_vector2mat(A);
end

[a0 b0] = find(A == 0);
w0 = zeros(length(a0),1);

[a1 b1] = find(A == 1);
w1 = ones(length(a1),1);

a = [a1; a0];
b = [b1; b0];
w = [w1; w0];

DG = sparse(a, b, w);

end

