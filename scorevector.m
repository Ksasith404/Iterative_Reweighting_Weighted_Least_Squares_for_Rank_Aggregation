function [pi, trank] = scorevector(n)
% Random intrinsic scores and corresponding true ranking

pi = rand(1, n);               % intrinsic strengths
[~, sigma] = sort(pi, 'descend');

trank = zeros(1, n);
trank(sigma) = 1:n;
end
