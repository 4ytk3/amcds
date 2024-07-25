% 黄金分割探索法
function gss(f,a,b,epsilon)
    k = (1 + sqrt(5)) / 2;  % 黄金数

    fprintf('Golden Section Search:\n');
    fprintf('Iteration\t a\t\t b\t\t x1\t\t x2\t\t f(x1)\t\t f(x2)\n');
    
    % 初期点の設定
    x1 = b - (b - a) / k;
    x2 = a + (b - a) / k;
    f_x1 = f(x1);
    f_x2 = f(x2);

    iteration = 0;

    while (b - a) > epsilon
        iteration = iteration + 1;
        fprintf('%d\t\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\n', ...
                iteration, a, b, x1, x2, f_x1, f_x2);
        if f_x1 > f_x2
            a = x1;
            x1 = x2;
            f_x1 = f_x2;
            x2 = a + (b - a) / k;
            f_x2 = f(x2);
        else
            b = x2;
            x2 = x1;
            f_x2 = f_x1;
            x1 = b - (b - a) / k;
            f_x1 = f(x1);
        end
    end
    x_min = (a + b) / 2;
    f_min = f(x_min);
    fprintf('Minimum found at x = %.6f with f(x) = %.6f\n', x_min, f_min);
end