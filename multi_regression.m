data = readtable('2024_0424_課題用データ.csv'); % データの読み込み
X = table2array(data(:,2:6)); % 入力変数
Y = table2array(data(:,1)); % 出力変数
b_M = X.'*X\X.'*Y; % β_Mの計算
s = CalcStatis; % 統計量計算クラスの呼び出し
b_0 = s.calc_col_means(Y) - b_M.'*s.calc_col_means(X).'; % β_0の確認