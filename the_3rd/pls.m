clear
clc

%% 実験データ

data = readtable('10_2024_0612_課題用データ.csv');

N = size(data,1);    
    
X_1 = table2array(data(:,2:11));
Y_1 = table2array(data(:,1));

%% データの標準化

X_m = mean(X_1);
X_std = std(X_1);

X_2 = (X_1 - repmat(X_m,N,1)) ./ repmat(X_std,N,1);

Y_m = mean(Y_1);
Y_std = std(Y_1);

Y_2 = (Y_1 - repmat(Y_m,N,1)) ./ repmat(Y_std,N,1);

%% MLRモデルを作る % Xがランク落ちしているので適切に計算できない
% beta_MLR = inv(X_2'*X_2)*(X_2'*Y_2);
    
%% PCRモデルを作る
V_2 = 1/(N - 1) * (X_2' * X_2); % 共分散行列

[W,Lambda] = eig(V_2);
% Wは固有ベクトルを並べた行列，Lambdaは固有値を並べた行列
% 固有値は小さい順にならんでいることに注意する

W2 = W(:,10:-1:10-rank(X_2)); % 固有値を大きい順に並び替える

T = X_2 * W2; % 主成分得点

beta_PCR = cell(rank(X_2),1);
Y_hat_PCR = zeros(N,rank(X_2));

% rank(T)
% rank(X_2)


tiledlayout(3,3)

% ---


for n = 1:rank(X_2)
beta_PCR{n,1} = inv(T(:,1:n)'*T(:,1:n))*(T(:,1:n)'*Y_2);
Y_hat_PCR(:,n) =  T(:,1:n) * beta_PCR{n,1};

nexttile
plot(Y_2(:,1), Y_hat_PCR(:,n),'o')
hold on
plot([-1.5 1.5],[-1.5 1.5],'k-')
grid on
axis square
xlabel('Y_2の実測値')
ylabel('Y_2の予測値')

xlim([-1.5 1.5])
ylim([-1.5 1.5])
axis square
title(strcat('主成分の数：', mat2str(n)))
end

%% PLSモデルを作る


