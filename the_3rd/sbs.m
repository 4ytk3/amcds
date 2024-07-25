% 逐次2分割法の実装
function sbs(f,a,b,epsilon)
    fprintf('Sequential Bisection Search:\n');
    fprintf('Iteration\t a\t\t b\t\t x\t\t f(x)\t\t f(x+ε)\t\t\n');

    % Δx
    dx = 1e-10;

    iteration = 0;

    while abs(b - a) > epsilon
        iteration = iteration + 1;
        x = (a + b) / 2;
        fprintf('%d\t\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t\n', iteration, a, b, x, f(x), f(x+dx));
        if f(x) > f(x+dx)
            a = x; % 探索幅を[x, b]に更新
        else
            b = x + dx; % 探索幅を[a, x + ε]に更新
        end
    end
    x_min = (a + b) / 2;
    f_min = f(x_min);
    fprintf('Minimum found at x = %.6f with f(x) = %.6f\n', x_min, f_min);
end