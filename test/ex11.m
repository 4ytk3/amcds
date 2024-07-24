clear
clc


% サンプルデータの生成
x = linspace(0, 10, 100); % 0から10までの100点
y_1 = 3*x + 2 + randn(size(x)); % 線形データにノイズを加える
y_2 = 0.5*x.^3 + 2*x + 1 + randn(size(x)); % 非線形データにノイズを加える

% 線形回帰
p_linear_1 = polyfit(x, y_1, 1); % y1の一次多項式によるフィッティング
p_linear_2 = polyfit(x, y_2, 1); % y2の一次多項式によるフィッティング

y_fit_linear_1 = polyval(p_linear_1, x);
y_fit_linear_2 = polyval(p_linear_2, x);

% 非線形回帰（2次多項式）
p_nonlin_1 = polyfit(x, y_1, 2); % y1の二次多項式によるフィッティング
y_fit_nonlin_1 = polyval(p_nonlin_1, x);

p_nonlin_2 = polyfit(x, y_2, 2); % y2の二次多項式によるフィッティング
y_fit_nonlin_2 = polyval(p_nonlin_2, x);


% 結果のプロット
figure;

% y1のプロット
subplot(2,1,1);
plot(x, y_1, 'ko'); % 元のデータ
hold on;
plot(x, y_fit_linear_1, 'b-', 'LineWidth', 2); % 線形回帰
plot(x, y_fit_nonlin_1, 'r-', 'LineWidth', 2); % 線形回帰
title('入出力関係が線形な場合');
legend('元データ', '直線フィッティング', '2次関数フィッティング');
xlabel('x');
ylabel('y');
grid on;

% 非線形回帰のプロット
subplot(2,1,2);
plot(x, y_2, 'ko'); % 元のデータ
hold on;
plot(x, y_fit_linear_2, 'b-', 'LineWidth', 2); % 線形回帰
plot(x, y_fit_nonlin_2, 'r-', 'LineWidth', 2); % 非線形回帰
title('入出力関係が非線形な場合');
legend('元データ', '直線フィッティング', '2次関数フィッティング');
xlabel('x');
ylabel('y');
grid on;