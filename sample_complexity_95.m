function recovery_table = sample_complexity_95(n, runs)

algNames = {
    'Least Squares (LS)'
    'Weighted Least Squares (WLS)'
    'Borda Count'
    'Rank Centrality'
    'IRWLS'
    'SVM Rank Aggregation'
};

numAlgs = length(algNames);

% Allow oversampling
Mmax = 5 * n*(n-1)/2;

target_tau = 0.95;

required_m = nan(numAlgs,1);
found = false(numAlgs,1);

fprintf('Computing sample complexity for Kendall tau >= 0.95 (n = %d)...\n', n);

for m = 1:Mmax

    tau_sum = zeros(numAlgs,1);

    for r = 1:runs

        % True scores and rank
        [pi, trank] = scorevector(n);

        % Comparison list
        L = createlist(n, m);

        % True BTL matrix
        P_BTL = createBTL(pi);

        % Deterministic empirical preferences
        [PHat, W, ~, ~] = Empirical_pref(P_BTL, L);

        % Run algorithms
        r1 = unweighted_hodge_rank(PHat);          % LS
        r2 = weighted_hodge_rank(PHat, W);        % WLS
        r3 = borda_rank(PHat);
        r4 = rank_centrality(PHat, W);
        [r5, ~, ~] = Iterative_Reweight_WLS(PHat, W);
        r6 = svm_rank_aggregate(PHat, W);

        ranks = {r1, r2, r3, r4, r5, r6};

        % Compute Kendall tau
        for a = 1:numAlgs

            tau_sum(a) = tau_sum(a) + kendall_tau(trank, ranks{a});

        end

    end

    avg_tau = tau_sum / runs;

    % Store minimum m achieving tau ≥ 0.95
    for a = 1:numAlgs

        if avg_tau(a) >= target_tau && ~found(a)

            required_m(a) = m;
            found(a) = true;

        end

    end

    % Stop early if all found
    if all(found)
        break;
    end

end

% Ratio relative to full graph
ratio = required_m / (n*(n-1)/2);

% Create table
recovery_table = table(algNames, required_m, ratio, ...
    'VariableNames', ...
    {'Algorithm', 'm_required_for_tau_0_95', 'comparison_ratio'});

disp(' ');
disp('Sample Complexity Table (Average Kendall tau >= 0.95)');
disp(recovery_table);

end