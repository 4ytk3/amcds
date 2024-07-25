% 関数
f = @(x) (x(1) - 2)^4 + (x(1) - 2)^2 * x(2)^2 + (x(2) + 1)^2;

% ヤコビ行列
df = @(x) [4*(x(1) - 2)^3 + 2*(x(1) - 2)*x(2)^2;
           2*(x(1) - 2)^2 * x(2) + 2*(x(2) + 1)];
       
% ヘッセ行列
ddf = @(x) [12*(x(1) - 2)^2 + 2*x(2)^2, 4*(x(1) - 2)*x(2);
            4*(x(1) - 2)*x(2), 2*(x(1) - 2)^2 + 2];

% 初期値
x = [1; 1];
% 最適解
x_opt = [2; -1];
% 最大反復回数
max_iterations = 4; 

fprintf('Iteration x(1)\t x(2)\t f(x)\tError\n');

for i = 1:max_iterations
    jacobian = df(x);
    hessian = ddf(x);
    x_new = x -hessian \ jacobian;
    
    % 最適解との誤差
    e = norm(x_new - x_opt);

    fprintf('%d\t  %.4f %.4f %.4f %.4f\n', i, x_new(1), x_new(2), f(x_new), e);
    x = x_new;
end