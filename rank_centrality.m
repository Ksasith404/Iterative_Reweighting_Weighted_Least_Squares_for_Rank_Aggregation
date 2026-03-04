function r = rank_centrality(PHat, W)

n = size(PHat,1);

% Weighted degree
d = sum(W,2);
dmax = max(d);

% Transition matrix
P = zeros(n);

for i = 1:n
    for j = 1:n
        if i ~= j && W(i,j) > 0
            % Correct Rank Centrality direction:
            % Flow from i to j proportional to probability j beats i
            P(i,j) = PHat(j,i) * W(i,j) / dmax;
        end
    end
end

% Self-loops for stochasticity
for i = 1:n
    P(i,i) = 1 - sum(P(i,:));
end

% Ensure no negative due to floating error
P = max(P,0);

% Make row-stochastic
P = P ./ sum(P,2);

% Power iteration
pi = ones(n,1) / n;
max_iter = 1000;
tol = 1e-10;

for iter = 1:max_iter
    pi_new = P' * pi;
    if norm(pi_new - pi, 1) < tol
        break;
    end
    pi = pi_new;
end

% Higher stationary probability = higher rank
[~, order] = sort(pi, 'descend');
r = zeros(1,n);
r(order) = 1:n;

end