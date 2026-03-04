function [PHat, W, N, N1] = Empirical_pref(P_BTL, L, k)

% ---------------------------------------------------------
% DEFAULT k IF NOT PROVIDED
% ---------------------------------------------------------
if nargin < 3
    k = 0;
end

n = size(P_BTL, 1);
m = size(L, 1);

%% Generate outcomes
outcomes = zeros(m,1);

for t = 1:m
    a = L(t,1);
    b = L(t,2);

    if P_BTL(a,b) >= 0.5
        outcomes(t) = 1;
    else
        outcomes(t) = 0;
    end
end

%% Add noise (k will be 0 unless user sets it)
num_flip = round(m * k);
flip_idx = randperm(m, num_flip);
outcomes(flip_idx) = 1 - outcomes(flip_idx);

%% Count comparisons
N  = zeros(n);
N1 = zeros(n);

for t = 1:m
    a = L(t,1);
    b = L(t,2);

    if outcomes(t) == 1
        N(a,b)  = N(a,b) + 1;
        N1(a,b) = N1(a,b) + 1;
    else
        N(a,b)  = N(a,b) + 1;
    end
end

%% Empirical preference matrix
PHat = zeros(n);

for i = 1:n
    for j = i+1:n
        if N(i,j) > 0
            PHat(i,j) = N1(i,j) / N(i,j);
            PHat(j,i) = 1 - PHat(i,j);
        end
    end
end

%% Weight matrix (number of comparisons)
W = N + N';

end