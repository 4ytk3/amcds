% PLSモデルの作成と評価
fprintf('\nPLSモデルの結果:\n');
for k = 1:n_components
    [X_loadings, Y_loadings, X_scores, Y_scores, beta_pls, PctVar] = plsregress(X_stdized, y_stdized, k);
    
    % 回帰モデルの作成
    y_pls_pred = [ones(size(X_stdized, 1), 1) X_stdized] * beta_pls;
    
    % 元のスケールに戻す
    y_pls_pred = y_pls_pred * y_std + y_mean;
    
    % モデル評価
    rmse = sqrt(mean((y - y_pls_pred).^2));
    fprintf('潜在変数数 %d: RMSE = %.4f\n', k, rmse);
end