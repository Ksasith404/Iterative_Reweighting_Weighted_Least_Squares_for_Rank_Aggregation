function r = rank_centrality(PHat, W)
% Rank Centrality Algorithm
%
% Inputs:
%   PHat : empirical probability matrix (PHat(i,j) = prob i beats j)
%   W    : comparison count matrix
%
% Output:
%   r    : ranking vector (1 = best rank)

n = size(PHat,1);

% Weighted degree of each node
d = sum(W,2);

% Maximum degree (normalization constant)
dmax = max(d);

% Transition matrix
P = zeros(n,n);

for i = 1:n
    for j = 1:n
        
        if i ~= j && W(i,j) > 0
            
            % Transition from i -> j proportional to
            % probability that j beats i
            P(i,j) = (W(i,j) / dmax) * PHat(j,i);
            
        end
        
    end
end

% Add self-loop to make rows sum to 1
for i = 1:n
    P(i,i) = 1 - sum(P(i,:));
end

% Fix numerical issues
P(P < 0) = 0;
P = P ./ sum(P,2);

% Power iteration to find stationary distribution
pi = ones(n,1) / n;

maxIter = 1000;
tol = 1e-12;

for iter = 1:maxIter
    
    pi_new = P' * pi;
    
    if norm(pi_new - pi, 1) < tol
        break;
    end
    
    pi = pi_new;
    
end

% Convert stationary probabilities to ranking
[~, order] = sort(pi, 'descend');

r = zeros(1,n);
r(order) = 1:n;

end