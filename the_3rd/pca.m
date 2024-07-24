%% 主成分分析（PCA）による異常検出プログラム

clear
clc
close all

%% データの生成

tiledlayout(3,3)

%% PCAモデル構築用データ
N_const = 100;
M = 3;

x1_const = rand(N_const,1);
x2_const = rand(N_const,1);
x3_const = x2_const + 0.05*rand(N_const,1);

X_const = [x1_const, x2_const, x3_const];

% 標準化
X_m = mean(X_const);
X_std = std(X_const);
X_const_2 = (X_const - repmat(X_m,N_const,1)) ./ repmat(X_std,N_const,1);



%% モデル検証用データ
N_val_normal   = 50;
N_val_abnormal = 50;


x1_val_normal = rand(N_val_normal,1);
x2_val_normal = rand(N_val_normal,1);
x3_val_normal = x2_val_normal + 0.05*rand(N_val_normal,1);

x1_val_abnormal = rand(N_val_normal,1);
x2_val_abnormal = rand(N_val_normal,1);
x3_val_abnormal = x2_val_abnormal + 0.5*rand(N_val_normal,1) - 0.25;


X_val_normal = [x1_val_normal, x2_val_normal, x3_val_normal];
X_val_abnormal = [x1_val_abnormal, x2_val_abnormal, x3_val_abnormal];
X_val = [X_val_normal; X_val_abnormal];

% 標準化
X_val_2 = (X_val - repmat(X_m,N_val_normal+N_val_abnormal,1)) ./ repmat(X_std,N_val_normal+N_val_abnormal,1);





%% 主成分分析

V2 = 1/(N_const - 1) * (X_const_2' * X_const_2); % 共分散行列

[W,Lambda] = eig(V2);
% Wは固有ベクトルを並べた行列，Lambdaは固有値を並べた行列
% 固有値は小さい順にならんでいることに注意する


W = W(:,[3, 2, 1]); % 固有値を大きい順に並び替える


T = X_const_2 * W;

T_m = mean(T); % 主成分得点の平均
T_var = var(T); % 主成分得点の分散

Cont_sum = cumsum(T_var/M); % 累積寄与率

X_const_31 = T(:,1)       * W(:,1)';       % 第1主成分から復元したX
X_const_32 = T(:,1:2)     * W(:,[1 2])';   % 第1,2主成分から復元したX
X_const_33 = T(:,[1 2 3]) * W(:,[1 2 3])'; % 第1,2,3主成分から復元したX

Q_const_1 = sum((X_const_2 - X_const_31).^2,2);
Q_const_2 = sum((X_const_2 - X_const_32).^2,2);
Q_const_3 = sum((X_const_2 - X_const_33).^2,2);







T_val = X_val_2 * W;

% T_m = mean(T_val); % 主成分得点の平均
% T_var = var(T_bal); % 主成分得点の分散

% Cont_sum = cumsum(T_var/M); % 累積寄与率

X_val_31 = T_val(:,1)       * W(:,1)';       % 第1主成分から復元したX
X_val_32 = T_val(:,1:2)     * W(:,[1 2])';   % 第1,2主成分から復元したX
X_val_33 = T_val(:,[1 2 3]) * W(:,[1 2 3])'; % 第1,2,3主成分から復元したX

Q_val_1 = sum((X_val_2 - X_val_31).^2,2);
Q_val_2 = sum((X_val_2 - X_val_32).^2,2);
Q_val_3 = sum((X_val_2 - X_val_33).^2,2);



% --
nexttile
plot3(X_const(:,1),X_const(:,2),X_const(:,3),'o')
grid on
xlabel('x1')
ylabel('x2')
zlabel('x3')
title('生のモデル構築用データ')

nexttile
plot3(X_const_2(:,1),X_const_2(:,2),X_const_2(:,3),'o')
grid on
xlabel('x1')
ylabel('x2')
zlabel('x3')
title('標準化後のモデル構築用データ')

nexttile
plot3(X_val_2(1:N_val_normal,1),X_val_2(1:N_val_normal,2),X_val_2(1:N_val_normal,3),'o')
hold on
plot3(X_val_2(1+N_val_normal:end,1),X_val_2(1+N_val_normal:end,2),X_val_2(1+N_val_normal:end,3),'x')
grid on
xlabel('x1')
ylabel('x2')
zlabel('x3')
title('標準化後のモデル検証用データ')


% --
nexttile
plot3(X_val_31(1:N_val_normal,1), X_val_31(1:N_val_normal,2),X_val_31(1:N_val_normal,3),'o')
hold on
plot3(X_val_31(1+N_val_normal:end,1), X_val_31(1+N_val_normal:end,2),X_val_31(1+N_val_normal:end,3),'x')
grid on
xlabel('x_1（標準化後）')
ylabel('x_2（標準化後）')
xlim([-2.5 2.5])
ylim([-2.5 2.5])
zlim([-2.5 2.5])
title('第1主成分から復元したモデル検証用データ')

% --
nexttile
plot3(X_val_32(1:N_val_normal,1), X_val_32(1:N_val_normal,2),X_val_32(1:N_val_normal,3),'o')
hold on
plot3(X_val_32(1+N_val_normal:end,1), X_val_32(1+N_val_normal:end,2),X_val_32(1+N_val_normal:end,3),'x')
grid on
xlabel('x_1（標準化後）')
ylabel('x_2（標準化後）')
xlim([-2.5 2.5])
ylim([-2.5 2.5])
zlim([-2.5 2.5])
title('第1,2主成分から復元したモデル検証用データ')

% --
nexttile
plot3(X_val_33(1:N_val_normal,1), X_val_33(1:N_val_normal,2),X_val_33(1:N_val_normal,3),'o')
hold on
plot3(X_val_33(1+N_val_normal:end,1), X_val_33(1+N_val_normal:end,2),X_val_33(1+N_val_normal:end,3),'x')
grid on
xlabel('x_1（標準化後）')
ylabel('x_2（標準化後）')
xlim([-2.5 2.5])
ylim([-2.5 2.5])
zlim([-2.5 2.5])
title('第1,2,3主成分から復元したモデル検証用データ')

% --
nexttile
semilogy(1:N_const,Q_const_1,'ko-')
hold on
semilogy(1:N_const,Q_const_2,'bo-')
semilogy(1:N_const,Q_const_3,'go-')
grid on
xlabel('モデル構築用データのサンプル番号')
xlabel('Q統計量')
legend('主成分数：1', '主成分数：2', '主成分数：3')
% xlim([-2.5 2.5])
% ylim([-2.5 2.5])
% zlim([-2.5 2.5])
title('モデル構築用データに対するQ統計量')



% --
nexttile
semilogy(1:N_val_normal,Q_val_1(1:N_val_normal,1),'ko-')
hold on
semilogy(1+N_val_normal:N_val_normal+N_val_abnormal,Q_val_1(N_val_normal+1:end,1),'kx-')
semilogy(1:N_val_normal,Q_val_2(1:N_val_normal,1),'bo-')
semilogy(1+N_val_normal:N_val_normal+N_val_abnormal,Q_val_2(N_val_normal+1:end,1),'bx-')
semilogy(1:N_val_normal,Q_val_3(1:N_val_normal,1),'go-')
semilogy(1+N_val_normal:N_val_normal+N_val_abnormal,Q_val_3(N_val_normal+1:end,1),'gx-')
grid on
xlabel('モデル構築用データのサンプル番号')
xlabel('Q統計量')
legend('主成分数：1（正常）', '主成分数：1（異常）', '主成分数：2（正常）', '主成分数：2（異常）', '主成分数：3（正常）', '主成分数：3（異常）')
% xlim([-2.5 2.5])
% ylim([-2.5 2.5])
% zlim([-2.5 2.5])
title('モデル検証用データに対するQ統計量')


















