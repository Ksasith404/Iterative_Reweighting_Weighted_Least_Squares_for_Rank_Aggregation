function brank = borda_rank(PHat)

scores = sum(PHat,2);
[~, order] = sort(scores,'descend');

n = length(scores);
brank = zeros(1,n);
brank(order) = 1:n;

end
