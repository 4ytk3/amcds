% CSVファイルの読み込み
data = readtable('10_2024_0612_課題用データ.csv');

% データの確認
disp('データの内容:');
disp(data);

% 説明変数 X と目的変数 y の分離
X = data{:, 2:end};
y = data{:, 1};

% 標準化
X_mean = mean(X);
X_std = std(X);
X_stdized = (X - X_mean) ./ X_std;

y_mean = mean(y);
y_std = std(y);
y_stdized = (y - y_mean) ./ y_std;

% 主成分数・潜在変数の設定
n_components = min(size(X, 2), size(X, 1) - 1);