function plot_kendall_comparison(n, runs)

maxComparisons = n*(n-1)/2;

M = 2.6 * maxComparisons;

tauCurves = zeros(6, M);

for m = 1:M

    tauCurves(:,m) = kendall_compare_methods(n, m, runs);

    % progress indicator
    if mod(m,50)==0
        disp(['Completed m = ', num2str(m)]);
    end

end

% Plot
figure;
hold on;
grid on;

plot(1:M, tauCurves(1,:), 'LineWidth', 2, 'Color', 'b');
plot(1:M, tauCurves(2,:), 'LineWidth', 2, 'Color', 'r');
plot(1:M, tauCurves(3,:), 'LineWidth', 2, 'Color', [0.5 0 0.5]); %purp
plot(1:M, tauCurves(4,:), 'LineWidth', 2, 'Color', [0 0.5 0]); %darkgren
plot(1:M, tauCurves(5,:), 'LineWidth', 2, 'Color', [0.65 0.16 0.16]); %brown
plot(1:M, tauCurves(6,:), 'LineWidth', 2, 'Color', [0.9 0.7 0]); %dark yellow

xlabel('Number of comparisons (m)', 'FontSize', 12, 'Interpreter', 'latex');

ylabel('Average Kendall $\tau$', 'FontSize', 12, 'Interpreter', 'latex');

%title(['\textbf{Ranking Algorithm Comparison under BTL Model - Deterministic Outcomes (n = ', num2str(n), ')}'], 'FontSize', 12, 'Interpreter', 'latex' );

legend('Least Squares', ...
       'Weighted LS', ...
       'Borda Count', ...
       'Rank Centrality', ...
       'SVM ',......
       'IRWLS (Proposed) ',......
       'Location', 'southeast');

set(gca,'FontSize',11);

hold off;

end