function [ randN ] = GR_rand( N )
%generate random number in range from 1 to N

randN = round(rand(1,1) * N);
randN(randN == 0) = 1;

end