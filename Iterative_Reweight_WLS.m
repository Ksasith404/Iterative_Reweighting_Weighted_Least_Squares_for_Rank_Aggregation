function [hrank, scores, W_final] = Iterative_Reweight_WLS(PHat, W0)

n = size(PHat, 1);

Y = PHat - PHat';

W = W0;
maxIter = 15;
tol = 1e-5;
penalty_strength = 1;

for iter = 1:maxIter

    deg = sum(W, 2);
    L = diag(deg) - W;

    b = sum(W .* Y, 2);

    scores = pinv(L) * b;

    % Compute pairwise gradients
    [Fi, Fj] = meshgrid(scores, scores);
    GradF = Fi - Fj; %Calculates negative gradient (-Grad_f) due to meshgrid structure

    % Residuals
    Residual = abs(Y - GradF); %Therefore calculate Residual=|Y + GradF|

    % Penalized reweighting
    Res_weight = 1 ./ (1 + penalty_strength * Residual);

    % Updated weights
    Wnew = W .* Res_weight;

    % Convergence
    if norm(Wnew - W, 'fro') / norm(W, 'fro') < tol
        W = Wnew;
        break;
    end

    W = Wnew;
end

W_final = W;

[~, order] = sort(scores, 'descend');
hrank = zeros(n,1);
hrank(order) = 1:n;

end