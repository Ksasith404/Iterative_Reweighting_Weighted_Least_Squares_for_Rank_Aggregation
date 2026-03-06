function [PHat, W] = Empirical_pref(P_BTL, L)

n = size(P_BTL, 1);
m = size(L, 1);

outcomes = zeros(m,1);

for t = 1:m
    a = L(t,1);
    b = L(t,2);

    u = rand;

    if P_BTL(a,b) >= u
        outcomes(t) = 1;
    else
        outcomes(t) = 0;
    end
end

N  = zeros(n);
N1 = zeros(n);

for t = 1:m
    a = L(t,1);
    b = L(t,2);

    N(a,b) = N(a,b) + 1;

    if outcomes(t) == 1
        N1(a,b) = N1(a,b) + 1;
    end
end

PHat = zeros(n);

for i = 1:n
    for j = i+1:n
        if N(i,j) > 0
            PHat(i,j) = N1(i,j) / N(i,j);
            PHat(j,i) = 1 - PHat(i,j);
        end
    end
end

W = N + N.';

end
