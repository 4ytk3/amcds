% PCRモデルの作成と評価
function [mse, r2, y_pred] = pcr(X, y, W, n)
    T = X * W(:, 1:n); % 主成分得点
    beta_pcr = W(:, 1:n) * (W(:, 1:n)' * W(:, 1:n) \ (W(:, 1:n)' * X' * y)); % 回帰係数
    y_pred = X * beta_pcr;
    mse = mean((y - y_pred).^2); % 
    r2 = 1 - sum((y - y_pred).^2) / sum((y - mean(y)).^2);

    nexttile
    % yの予測値をプロット
    nexttile
    plot(y, y_pred, 'o')
    hold on
    plot([-1.5 1.5],[-1.5 1.5],'k-')
    hold off
    grid on
    xlabel('観測値 y')
    ylabel('予測値 y_{pred}')
    axis square
    title(['PCR with ', num2str(n), ' components'])
    %X_new = T(:,1:n) * W(:,1:n)';
    %plot(X_new(:,1), X_new(:,2),'o')
    %grid on
    %xlabel('x_1（標準化後）')
    %ylabel('x_2（標準化後）')
    %title([num2str(n), '主成分から復元したX'])
end


