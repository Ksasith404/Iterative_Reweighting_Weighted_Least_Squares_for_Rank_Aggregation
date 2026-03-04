function P_BTL = createBTL(pi)

n = length(pi);
P_BTL = zeros(n);

for i = 1:n
    for j = 1:n
        if i ~= j
            P_BTL(i,j) = pi(i) / (pi(i) + pi(j));
        end
    end
end

%disp("BTL probability matrix P_BTL (i beats j):");
%disp(round(P_BTL, 4));
end
