function [ grStructArr ] = GR_CreateGraphStruct( grVector, CostF, options)
%Create graphs struct that represents a graph and all it's parameters
%
%Syntax:
%   [ grStructArr ] = GR_CreateGraphStruct( grVector, CostF)
%Arguments:
%   grVector   -   vectors that represents a graph. 
%   options    -   cost function options
%
%Outputs:
%   grStructArr  -   array of graphs structs
%
% SEE ALSO: GR_FILTER, GR_SIZE.
%
%18-Sep-2012 20:14:30: added preallocation
   
grCount = 1;
tmpStruct(1, 1 : size(grVector, 1)) = struct( ...
                                            'Matrix', [], ...
                                            'DG', [], ...
                                            'Vector', [], ...
                                            'EdgeCount', [], ...
                                            'MedDist', [], ...
                                            'Diameter', [], ...
                                            'Power', [], ...
                                            'Size', [], ...
                                            'Goal', [] ...
                                            );
for i = 1 : size(grVector, 1)
    tmpStruct(grCount).Matrix = GR_vector2mat( grVector(i, :) );
    tmpStruct(grCount).DG = GR_CreateSparse( tmpStruct(grCount).Matrix );
    tmpStruct(grCount).Vector = grVector(i, :);
    tmpStruct(grCount).EdgeCount = GR_EdgesCount( grVector(i, :) );
    tmpStruct(grCount).MedDist = GR_medianDistance( tmpStruct(grCount).DG );
    tmpStruct(grCount).Diameter = GR_Diameter( tmpStruct(grCount).DG );
    tmpStruct(grCount).Power = GR_MaxGraphPower( tmpStruct(grCount).Matrix );
    tmpStruct(grCount).Size = GR_Size( grVector(i, :) );
    tmpStruct(grCount).Goal = feval( CostF, tmpStruct(grCount), options );
    grCount = grCount + 1;
end

grStructArr = tmpStruct(~isinf([tmpStruct(:).Goal]));

end

