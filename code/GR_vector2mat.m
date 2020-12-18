function [ mat ] = GR_vector2mat( vec )
%Convert vector to N-by-N connection matrix
%
%Syntax:
% [ mat ] = GR_vector2mat( vec )
%Arguments:
%   vec     -   vector that represents a graph(Upper triangular part of 
%               matrix). Nonzero entries in matrix G represent the 
%               connection between nodes.
%
%Outputs:
%   mat     -   N-by-N connection matrix that represents a graph.

% See also: GR_Filter, GR_Size. @todo: add more similar
%

  
    aS = floor(sqrt(2 * length(vec))) + 1;
    tmp_mat = zeros(aS);
    ind_prev = 1 - aS;
    for i = 1 : aS - 1
        ind_prev = ind_prev + aS - i + 1;
        tmp_mat(i + 1 : end, i) = ...
            vec(ind_prev : ind_prev + aS - i - 1);
    %    ind_prev : ind_prev + aS - i - 1 %debugging
        tmp_mat(i, i + 1 : end) = tmp_mat(i + 1 : end, i);
    end
    mat = tmp_mat;
end

