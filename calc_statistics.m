% 平均を計算する関数
function mean = calculate_mean(data)
    % 要素数を取得
    N = length(data);
    
    % 要素の合計を計算
    sum = 0;
    for i = 1:N
        sum = sum + data(i);
    end

    % 平均を計算
    mean = sum / N;
end

% 中心化する関数
function centered_data = center_data(data)
    % 平均を計算
    mean = calculate_mean(data);
    
    % データを中心化
    centered_data = data - mean;
end

% 平方和を計算する関数
function ssq = sum_squares(data)
    % 平方和を計算
    ssq = sum(data .^ 2);
end

% 偏差積和を計算する関数
function sp = sum_products(data1, data2)
    % 偏差を計算
    mean1 = calculate_mean(data1);
    mean2 = calculate_mean(data2);
    
    % 偏差積和を計算
    dev1 = data1 - mean1;
    dev2 = data2 - mean2;
    sp = sum(dev1 .* dev2);
end

% 標準偏差を計算する関数
function sd = calc_sd(data)
    % 標準偏差を計算
    N = length(data);
    ssq = sum_squares(data);
    sd = sqrt(ssq) / (N - 1);
end

% スケーリングする関数
function scaled_data = scale_data(data)
    % 標準偏差を計算
    sd = calc_sd(data);

    % スケーリングを実行
    scaled_data = data / sd;
end

% 標準化する関数
function standardized_data = standardize_data(data)
    % 標準偏差を計算
    sd = calc_sd(data);

    % 中心化
    centered_data = center_data(data);
    
    % 標準化を実行
    standardized_data = centered_data / sd;
end

data1 = [1, 2, 3, 4, 5];
data2 = [2, 3, 4, 5, 6];
ssq1 = sum_squares(data1);
ssq2 = sum_squares(data2);
sp = sum_products(data1, data2);
scaled_data1 = scale_data(data1);
scaled_data2 = scale_data(data2);
standardized_data1 = standardize_data(data1);
standardized_data2 = standardize_data(data2);
fprintf('データ1の平方和: %f\n', ssq1);
fprintf('データ2の平方和: %f\n', ssq2);
fprintf('データ1とデータ2の偏差積和: %f\n', sp);
fprintf('データ1のスケーリング結果: %f\n', scaled_data1);
fprintf('データ2のスケーリング結果: %f\n', scaled_data2);
fprintf('データ1の標準化結果: %f\n', standardized_data1);
fprintf('データ2の標準化結果: %f\n', standardized_data2);
