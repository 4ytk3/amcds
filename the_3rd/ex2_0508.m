% 関数
f = @(x) x.^4 - x + 1;
df = @(x) 4*x^3 - 1;
d2f = @(x) 12*x^2;

% 条件
epsilon = 1e-4;

% 探索幅
a = -3;
b = 3;

% ニュートン法の初期値
x0 = 3;

sbs(f,a,b,epsilon)
gss(f,a,b,epsilon)
nrm(f,df,d2f,x0,epsilon)