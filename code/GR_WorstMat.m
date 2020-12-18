function [ aMat ] = GR_WorstMat( aSize )
%Create the worst matrix

    aMat = zeros(aSize);

    for i = 1 : aSize - 1
        aMat(i, i + 1) = 1;
        aMat(i + 1, i) = 1;
    end
    
end

