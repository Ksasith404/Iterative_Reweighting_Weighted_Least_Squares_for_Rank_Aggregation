function hrank = unweighted_hodge_rank(PHat)

n = size(PHat,1);
Y = PHat - PHat';

W = double(PHat ~= 0);
deg = sum(W,2);
L = diag(deg) - W;

d = sum(W .* Y, 2);
scores = pinv(L) * d;
scores = scores - mean(scores);

[~, order] = sort(scores, 'descend');
hrank = zeros(n,1);
hrank(order) = 1:n;

end