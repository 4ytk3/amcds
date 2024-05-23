data = readtable('2024_0424_課題用データ.csv'); % データの読み込み
X = table2array(data(:,2:6)); % 入力変数X
Y = table2array(data(:,1)); % 出力変数Y
b_M = X.'*X\X.'*Y; % β_Mの計算
b_0 = CalcStatis.calc_col_means(Y) - b_M.'*CalcStatis.calc_col_means(X).'; % β_0の確認
b_M
b_0