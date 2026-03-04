function tauVals = kendall_compare_methods(n, m, runs)
% Compare ranking methods using average Kendall tau
%
% Methods:
% 1 - Least Squares
% 2 - Weighted Least Squares
% 3 - Borda Count
% 4 - Rank Centrality
% 5 - BTL MLE
% 6 - SVM Rank Aggregation
% 7 - Iterative Reweighted WLS (IRWLS)

tauVals = zeros(6,1);

for r = 1:runs

    % True intrinsic scores
    [pi, trank] = scorevector(n);

    % Random comparison graph
    L = createlist(n, m);

    % True BTL probability matrix
    P_BTL = createBTL(pi);

    % Empirical observations
    [PHat, W, ~, ~] = Empirical_pref(P_BTL, L);

    % Ranking algorithms
    r1 = unweighted_hodge_rank(PHat);

    r2 = weighted_hodge_rank(PHat, W);

    r3 = borda_rank(PHat);

    r4 = rank_centrality(PHat, W);

    r6 = Iterative_Reweight_WLS(PHat, W);

    r5 = svm_rank_aggregate(PHat, W);

    % Kendall tau computation
    tauVals(1) = tauVals(1) + kendall_tau(trank, r1);

    tauVals(2) = tauVals(2) + kendall_tau(trank, r2);

    tauVals(3) = tauVals(3) + kendall_tau(trank, r3);

    tauVals(4) = tauVals(4) + kendall_tau(trank, r4);

    tauVals(5) = tauVals(5) + kendall_tau(trank, r5);

    tauVals(6) = tauVals(6) + kendall_tau(trank, r6);

end

% Average
tauVals = tauVals / runs;

end