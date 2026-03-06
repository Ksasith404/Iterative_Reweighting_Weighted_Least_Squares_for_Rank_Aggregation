function plot_kendall_comparison(n, runs)

m_list = 10.^(1:7);
M = length(m_list);

tauCurves = zeros(6, M);   % NOW 5 METHODS

% Compute results
for k = 1:M
    m = m_list(k);
    tauCurves(:,k) = kendall_compare_methods(n, m, runs);
end

% --- Plot ---
figure; hold on; grid on;

set(gca, 'XScale', 'log');
set(gca, 'FontSize', 11);

plot(m_list, tauCurves(1,:), '-o', 'LineWidth', 2,'Color', 'r');
plot(m_list, tauCurves(2,:), '-s', 'LineWidth', 2,'Color', 'b');
plot(m_list, tauCurves(3,:), '-d', 'LineWidth', 2,'Color', [0.5 0 0.5]);
plot(m_list, tauCurves(4,:), '-^', 'LineWidth', 2,'Color', [0 0.5 0]);
plot(m_list, tauCurves(5,:), '-v',  'LineWidth', 2, 'Color', [0.65 0.16 0.16]); %brown
plot(m_list, tauCurves(6,:), '-v', 'LineWidth', 2,'Color', [0.9 0.7 0]);   % IRWLS

xlabel('Number of comparisons m', 'FontSize', 12, 'Interpreter', 'latex');
ylabel('Average Kendall $\tau$ ', 'FontSize', 12, 'Interpreter', 'latex');
%title(['Ranking Comparison (n = ' num2str(n) ') Non Deterministic Outcomes']);

xticks(m_list);
xticklabels(compose('10^{%d}', 1:7));

legend( ...
    'Weighted Least Squares', ...
    'Least Squares', ...
    'Borda Count', ...
    'Rank Centrality', ...
    'SVM ', ...
    'IRWLS (Proposed) ', ...
    'Location', 'southeast');

ylim([0 1]);

hold off;

end