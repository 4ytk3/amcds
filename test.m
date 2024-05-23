data = readtable('2024_0424_課題用データ.csv'); % データの読み込み
X1 = table2array(data(:,2)); % 入力変数X1
X2 = table2array(data(:,3)); % 入力変数X2

std_u = CalcStatis.std_data(X1)
std_b = std(X1)
isequal(std_u, std_b)