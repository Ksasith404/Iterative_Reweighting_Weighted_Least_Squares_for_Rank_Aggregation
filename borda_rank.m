function brank = borda_rank(PHat)

scores = sum(PHat,2);
[~, order] = sort(scores,'descend');

n = length(scores);
brank = zeros(n,1);
brank(order) = 1:n;

end