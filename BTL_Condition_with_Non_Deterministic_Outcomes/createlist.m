function L = createlist(n, m)
% Generate m random unordered item pairs

base_pairs = nchoosek(1:n, 2);
numPairs = size(base_pairs, 1);

L = zeros(m, 2);
for k = 1:m
    r = randi(numPairs);
    L(k, :) = base_pairs(r, :);
end

end
