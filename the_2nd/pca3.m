%% 主成分分析（PCA）のプログラム

clear
clc
close all

%% データの生成
M = 3; % 入力変数の数
N = 100; % サンプル数

x1 = rand(N,1);
x2 = rand(N,1);
x3 = x2 + 0.2*rand(N,1);
X1 = [x1, x2, x3];

% 標準化
X_m = mean(X1);
X_std = std(X1);
X2 = (X1 - repmat(X_m,N,1)) ./ repmat(X_std,N,1);


%% 主成分分析



V2 = 1/(N - 1) * (X2' * X2); % 共分散行列

[W,Lambda] = eig(V2);
% Wは固有ベクトルを並べた行列，Lambdaは固有値を並べた行列
% 固有値は小さい順にならんでいることに注意する


W = W(:,[3, 2, 1]); % 固有値を大きい順に並び替える


T = X2 * W;

T_m = mean(T); % 主成分得点の平均
T_var = var(T); % 主成分得点の分散

Cont_sum = cumsum(T_var/M); % 累積寄与率

X31 = T(:,1)       * W(:,1)';       % 第1主成分から復元したX
X32 = T(:,1:2)     * W(:,[1 2])';   % 第1,2主成分から復元したX
X33 = T(:,[1 2 3]) * W(:,[1 2 3])'; % 第1,2,3主成分から復元したX


%% グラフを作成する

tiledlayout(3,3)

% --
nexttile
plot3(X1(:,1), X1(:,2), X1(:,3),'o')
grid on
xlabel('x_1（標準化前）')
ylabel('x_2（標準化前）')
ylabel('x_3（標準化前）')
xlim([-0.1 1.1])
ylim([-0.1 1.1])
zlim([-0.1 1.1])
axis square
title('生データ')


% --
nexttile
plot3(X2(:,1),X2(:,2),X2(:,3),'o')
grid on
xlabel('x_1（標準化後）')
ylabel('x_2（標準化後）')
zlabel('x_3（標準化後）')
xlim([-2.5 2.5])
ylim([-2.5 2.5])
zlim([-2.5 2.5])
axis square
title('標準化後のデータ')


% --
nexttile
plot3(T(:,1), T(:,2), T(:,3), 'o')
grid on
xlabel('t_1')
ylabel('t_2')
zlabel('t_3')
xlim([-3 3])
ylim([-3 3])
zlim([-3 3])
axis square
title('主成分得点')


% --
nexttile
bar(Cont_sum)
grid on
xlabel('主成分番号')
ylabel('累積寄与率')
ylim([0 1.1])
axis square

% --
nexttile
plot3(X31(:,1), X31(:,2),X31(:,3),'o')
grid on
xlabel('x_1（標準化後）')
ylabel('x_2（標準化後）')
xlim([-2.5 2.5])
ylim([-2.5 2.5])
zlim([-2.5 2.5])
axis square
title('第1主成分から復元したX')

% --
nexttile
plot3(X32(:,1), X32(:,2),X32(:,3),'o')
grid on
xlabel('x_1（標準化後）')
ylabel('x_2（標準化後）')
xlim([-2.5 2.5])
ylim([-2.5 2.5])
zlim([-2.5 2.5])
axis square
title('第1,2主成分から復元したX')

% --
nexttile
plot3(X33(:,1), X33(:,2),X33(:,3),'o')
grid on
xlabel('x_1（標準化後）')
ylabel('x_2（標準化後）')
xlim([-2.5 2.5])
ylim([-2.5 2.5])
zlim([-2.5 2.5])
axis square
title('第1,2,3主成分から復元したX')
