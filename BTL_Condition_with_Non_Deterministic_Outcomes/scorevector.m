function [pi, trank] = scorevector(n)

pi = rand(1, n);

[~, sigma] = sort(pi, 'descend');

trank = zeros(1, n);
trank(sigma) = 1:n;

end
