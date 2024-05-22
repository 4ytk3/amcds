data = readtable('2024_0424_課題用データ.csv'); % データの読み込み
X1 = table2array(data(:,2)); % 入力変数X1
X2 = table2array(data(:,3)); % 入力変数X2

calc_mean_x1 = CalcStatis.calc_mean(X1)
mean_x1 = mean(X1)
isequal(calc_mean_x1, mean_x1)

center