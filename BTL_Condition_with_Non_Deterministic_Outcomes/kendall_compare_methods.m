function tauVals = kendall_compare_methods(n, m, runs)

% 1 = WLS
% 2 = LS
% 3 = Borda
% 4 = Rank Centrality
% 5 = IRWLS

tauVals = zeros(6,1);

for r = 1:runs

    [pi, trank] = scorevector(n);
    L = createlist(n, m);
    P_BTL = createBTL(pi);
    [PHat, W] = Empirical_pref(P_BTL, L);

    % ----- Algorithms -----
    r1 = weighted_hodge_rank(PHat, W);          % WLS
    r2 = unweighted_hodge_rank(PHat);           % LS
    r3 = borda_rank(PHat);                      % Borda
    r4 = rank_centrality(PHat, W);              % Rank Centrality
    r5 = svm_rank_aggregate(PHat, W);           % SVM
    r6 = Iterative_Reweight_WLS(PHat, W);       % IRWLS

    % ----- Kendall Tau -----
    tauVals(1) = tauVals(1) + kendall_tau(trank, r1);
    tauVals(2) = tauVals(2) + kendall_tau(trank, r2);
    tauVals(3) = tauVals(3) + kendall_tau(trank, r3);
    tauVals(4) = tauVals(4) + kendall_tau(trank, r4);
    tauVals(5) = tauVals(5) + kendall_tau(trank, r5);
    tauVals(6) = tauVals(6) + kendall_tau(trank, r6);

end

tauVals = tauVals / runs;

end