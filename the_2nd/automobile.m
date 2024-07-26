% CSVファイルの読み込み
data = readtable('Automobile.csv');

X = table2array(data(:, 2:6)); % 説明変数X
y = table2array(data(:, 7)); % 目的変数y
X(isnan(X)) = 0;  % NaNがある場合0に置き換える

% 標準化
X_m = mean(X);
X_std = std(X);
X_scaled = (X - X_m) ./ X_std;
y_m = mean(y);
y_std = std(y);
y_scaled = (y - y_m) ./ y_std;

N = size(data,1);
M = rank(X_scaled);

% 主成分分析
V = 1/(N - 1) * (X_scaled' * X_scaled); % 共分散行列
[W, Lambda] = eig(V); % Wは固有ベクトル行列，Lambdaは固有値行列
[~, idx] = sort(diag(Lambda), 'descend'); % 固有値を大きい順に並び替え
W = W(:, idx);
T = X_scaled * W;  % 主成分得点の計算

% PCRの累積寄与率の計算
T_var = var(T);
Cont_sum = cumsum(T_var/sum(T_var));

% 各モデルの評価、予測値の計算、グラフの作成
pcr_results = zeros(M, 2);
pls_results = zeros(M, 2);

figure('Position', [100, 100, 1500, 800]);
tiledlayout('flow', 'TileSpacing', 'compact', 'Padding', 'compact');

for n = 1:M
    % PCRモデル
    beta_pcr = (T(:, 1:n)'*T(:, 1:n))\((T(:, 1:n)'*y_scaled));
    y_pred_pcr = T(:, 1:n) * beta_pcr;
    
    % PCRの性能評価
    mse_pcr = mean((y_scaled - y_pred_pcr).^2);
    r2_pcr = 1 - sum((y_scaled - y_pred_pcr).^2) / sum((y_scaled - mean(y_scaled)).^2);
    pcr_results(n, :) = [mse_pcr, r2_pcr];
    fprintf('主成分数：%d個, MSE = %.4f, R2 = %.4f\n', n, mse_pcr, r2_pcr);
    
    % PCRの予測値と実測値のプロット
    nexttile
    plot(y_scaled, y_pred_pcr, 'o')
    hold on
    plot([min(y_scaled), max(y_scaled)], [min(y_scaled), max(y_scaled)])
    grid on
    xlabel('実測値')
    ylabel('予測値')
    axis square
    title(['PCR: ', num2str(n), '個の主成分'])
    hold off
end

% PCRの累積寄与率のグラフ
nexttile
bar(Cont_sum)
grid on
xlabel('主成分番号')
ylabel('累積寄与率')
ylim([0 1.1])
axis square
title('累積寄与率')

% PLSの累積寄与率の初期化
Cont_sum_PLS_X = zeros(M, 1);
Cont_sum_PLS_Y = zeros(M, 1);

for n = 1:M
    % PLSモデル
    [~, ~, ~, ~, beta_pls, PCTVAR] = plsregress(X_scaled, y_scaled, n);
    y_pred_pls = [ones(size(X_scaled, 1), 1) X_scaled] * beta_pls;

    % PLSの累積寄与率の計算
    Cont_sum_PLS_X(n) = sum(PCTVAR(1, 1:n));
    Cont_sum_PLS_Y(n) = sum(PCTVAR(2, 1:n));

    % PLSの性能評価
    mse_pls = mean((y_scaled - y_pred_pls).^2);
    r2_pls = 1 - sum((y_scaled - y_pred_pls).^2) / sum((y_scaled - mean(y_scaled)).^2);
    pls_results(n, :) = [mse_pls, r2_pls];
    fprintf('潜在変数：%d 個, MSE = %.4f, R2 = %.4f\n', n, mse_pls, r2_pls);
    
    % PLSの予測値と実測値のプロット
    nexttile
    plot(y_scaled, y_pred_pls, 'o')
    hold on
    plot([min(y_scaled), max(y_scaled)], [min(y_scaled), max(y_scaled)])
    grid on
    xlabel('実測値')
    ylabel('予測値')
    axis square
    title(['PLS: ', num2str(n), '個の潜在変数'])
    hold off
end

% PLSの累積寄与率のグラフ
nexttile
bar(Cont_sum_PLS_X)
hold on
bar(Cont_sum_PLS_Y, 'r')
grid on
xlabel('潜在変数の数')
ylabel('累積寄与率')
ylim([0 1.1])
axis square
title('PLS: 累積寄与率')

% PCRとPLSの性能比較グラフ
nexttile
plot(1:M, pcr_results(:,1), 'b-', 1:M, pls_results(:,1), 'r-', 'LineWidth', 2)
grid on
xlabel('主成分/潜在変数の数')
ylabel('MSE')
title('PCR vs PLS: 平均二乗誤差(MSE)')
legend('PCR', 'PLS')

nexttile
plot(1:M, pcr_results(:,2), 'b-', 1:M, pls_results(:,2), 'r-', 'LineWidth', 2)
grid on
xlabel('主成分/潜在変数の数')
ylabel('R^2')
title('PCR vs PLS: 決定係数(R2)')
legend('PCR', 'PLS')