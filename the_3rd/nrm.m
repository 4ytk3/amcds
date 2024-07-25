% ニュートン法の実装
function nrm(f,df,d2f,x0,epsilon)
    fprintf('Newton Method:\n');
    fprintf('Iteration\t x\t\t f(x)\n');
    
    % 初期値
    x=x0;
    
    iteration = 0;

    while true
        iteration = iteration + 1;
        fprintf('%d\t\t %.6f\t %.6f\n', iteration, x, f(x));
        x_new = x - df(x) / d2f(x);
        if abs(x_new - x) < epsilon
            break;
        end
        x = x_new;
    end
    x_min = x;
    f_min = f(x_min);
    fprintf('Minimum found at x = %.6f with f(x) = %.6f\n', x_min, f_min);
end