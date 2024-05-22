classdef calc_statistics
    methods (Static)
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
            mean = calc_statistics.calculate_mean(data);
            
            % データを中心化
            centered_data = data - mean;
        end
        
        % 平方和を計算する関数
        function s_xx = sum_squares(data)
            % 平方和を計算
            s_xx = sum(data .^ 2);
        end
        
        % 偏差積和を計算する関数
        function s_xy = sum_products(data1, data2)
            % 偏差を計算
            mean1 = calculate_mean(data1);
            mean2 = calculate_mean(data2);
            
            % 偏差積和を計算
            dev1 = data1 - mean1;
            dev2 = data2 - mean2;
            s_xy = sum(dev1 .* dev2);
        end
        
        % 標準偏差を計算する関数
        function sd = calc_sd(data)
            % 標準偏差を計算
            N = length(data);
            s_xx = sum_squares(data);
            sd = sqrt(s_xx) / (N - 1);
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
    end
end