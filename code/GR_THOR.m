function [ mat ] = GR_THOR( N )

% 1: 2 4 3 7
%
mat = zeros(N * N);

for i = 1 : N * N
    tmp = zeros(1, N * N);
    
    if mod(i, N) == 1
        if i == 1 || i == N * (N - 1) + 1
           tmp(i + 1) = 1;
           tmp(i + N - 1) = 1;
           if i == 1
               tmp(N * (N - 1) + 1) = 1;
               tmp(i + N) = 1;
           else
               tmp(1) = 1;
               tmp(i - N) = 1;
           end
        else
            tmp(i + 1) = 1;
            tmp(i + N - 1) = 1;
            tmp(i + N) = 1;
            tmp(i - N) = 1;
        end
    elseif mod(i, N) == 0
        if i == N || i == N * N
           tmp(i - 1) = 1;
           tmp(i - N + 1) = 1;
           if i == N
               tmp(N * N) = 1;
               tmp(i + N) = 1;
           else
               tmp(N) = 1;
               tmp(i - N) = 1;
           end
        else
            tmp(i - 1) = 1;
            tmp(i - N + 1) = 1;
            tmp(i + N) = 1;
            tmp(i - N) = 1;
        end
    elseif i < N || i > N * (N - 1)
        tmp(i - 1) = 1;
        tmp(i + 1) = 1;
        if i < N
            tmp(i + N) = 1;
            tmp(i + N * N - N) = 1;
        else
            tmp(i - N * N + N) = 1;
            tmp(i - N) = 1;
        end
    else
        tmp(i - 1) = 1;
        tmp(i + 1) = 1;
        tmp(i + N) = 1;
        tmp(i - N) = 1;
    end
    
    mat(i, :) = tmp;
end


end

