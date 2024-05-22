% データの読み込み
data = readtable('2024_0424_課題用データ.csv');
X = table2array(data(:,2:6));
Y = table2array(data(:,1));

% 統計量計算クラスの呼び出し
s = CalcStatis;

b = X.'*X\X.'*Y;
f = s.calc_col_means(Y) - b.'*s.calc_col_means(X).';
b
f