% 重回帰分析を行うMATLABスクリプト

% データの読み込み
data = readtable('2024_0424_課題用データ.csv');

% 統計量計算クラス呼び出し
s = CalcStatis;

x1 = data{:, "x1"}

mean_x1 = s.center_data(x1)

% 入力変数 (X) と出力変数 (Y) を定義
X = data{:, {'x1', 'x2', 'x3', 'x4', 'x5'}};
Y = data{:, 'y'};

