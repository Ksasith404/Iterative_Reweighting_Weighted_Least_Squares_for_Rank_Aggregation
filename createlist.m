function L = createlist(n, m)
% Generate m random unique unordered item pairs (i, j)

base_pairs = nchoosek(1:n, 2);     % All possible pairs
numPairs = size(base_pairs, 1);

L = zeros(m, 2);
for k = 1:m
    r = randi(numPairs);
    L(k, :) = base_pairs(r, :);
end
end
