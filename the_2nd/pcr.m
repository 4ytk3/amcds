% PCRモデルの作成と評価
function pcr(X_stdized,n_components)
    fprintf('\nPCRモデルの結果:\n');
    for k = 1:n_components
        [coeff, score, ~, ~, explained] = pca(X_stdized);
        X_pcr = score(:, 1:k);
        
        % 回帰モデルの作成
        beta_pcr = regress(y_stdized, X_pcr);
        y_pcr_pred = X_pcr * beta_pcr;
        
        % 元のスケールに戻す
        y_pcr_pred = y_pcr_pred * y_std + y_mean;
        
        % モデル評価
        rmse = sqrt(mean((y - y_pcr_pred).^2));
        fprintf('主成分数 %d: RMSE = %.4f\n', k, rmse);
    end
end