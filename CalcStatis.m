classdef CalcStatis
    methods (Static)
        % 平均を計算する関数
        function mean = calc_mean(data)
            N = length(data); % データ数を取得
            sum = 0; % 合計を初期化
            for i = 1:N
                sum = sum + data(i); % 1からN個のデータを合計
            end
            mean = sum / N; % 合計をデータ数で除算
        end
        
        % 列ごとに平均を計算する関数
        function column_means = calc_col_means(data)
            [num_rows, num_cols] = size(data); % 行列のサイズを取得
            column_means = zeros(1, num_cols); % 結果を格納するための行列を初期化
            for col = 1:num_cols % 各列に対して平均を計算
                col_sum = 0; % 合計を初期化
                for row = 1:num_rows
                    col_sum = col_sum + data(row, col); % 1からnum_rowsのデータを合計
                end
                column_means(col) = col_sum / num_rows;
            end
        end

        % 中心化する関数
        function centered_data = center_data(data)
            centered_data = data - CalcStatis.calc_mean(data); % 各データから平均値を減算
        end
        
        % 平方和を計算する関数
        function s_xx = sum_squares(data)
            s_xx = sum(data .^ 2); % データの二乗を計算
        end
        
        % 偏差積和を計算する関数
        function s_xy = sum_products(data1, data2)
            dev1 = data1 - CalcStatis.calc_mean(data1); % データ1の偏差を計算
            dev2 = data2 - CalcStatis.calc_mean(data2); % データ2の偏差を計算
            s_xy = sum(dev1 .* dev2); % 各偏差の乗算
        end
        
        % 標準偏差を計算する関数
        function sd = calc_sd(data)
            N = length(data); % データ数を取得
            s_xx = CalcStatis.sum_squares(data); % 平方和を計算
            sd = sqrt(s_xx) / (N - 1); % 平方和の平方根をデータ数-1で除算
        end
        
        % スケーリングする関数
        function scaled_data = scale_data(data)
            scaled_data = data / CalcStatis.calc_sd(data);
        end
        
        % 標準化する関数
        function stded_data = std_data(data)
            stded_data = CalcStatis.center_data(data) / CalcStatis.calc_sd(data);
        end
    end
end