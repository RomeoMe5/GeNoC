function [ vector ] = GR_mat2vector( A )
%Convert N-by-N connection matrix to vector
%
%Syntax:
% [ vector ] = GR_mat2vector( A )
%Arguments:
%   A       -  N-by-N connection matrix that represents a graph 
%Outputs:
%   vector  - vector that represents a graph(Upper triangular part of 
%             matrix). Nonzero entries in matrix G represent the 
%             connection between nodes.
%
% See also: GR_Filter, GR_Size.
%

  
aS = length(A);

vector = [];

for i = 1 : aS
    vector = [vector A(i, i + 1 : end)];
end

