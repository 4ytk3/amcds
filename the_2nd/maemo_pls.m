function result = pls(xno, yno, num)

    result = zeros(size(xno,1), num, 2);
    
    result(:, 1, 1) = xno * (xno' * yno / sum(xno' * yno));
    result(:, 1, 2) = yno;

    if num == 1
        return
    end
    x_prev = xno;
    
    for i = 2 : num
        x_cur = x_prev -...
         (result(:, i - 1, 1) * (result(:, i - 1, 1)' * x_prev/ (result(:, i - 1, 1)' * result(:, i - 1, 1))));
        result(:, i, 2) = result(:, i - 1, 2) -...
         (result(:, i - 1, 1) * (result(:, i - 1, 1)' * result(:, i - 1, 2)/ (result(:, i - 1, 1)' * result(:, i - 1, 1))));
        result(:, i, 1) = x_cur * (x_cur' * result(:, i, 2) / sum(x_cur' * result(:, i, 2)));
        x_prev = x_cur;
    end
end

function result = pls_gety(obj, x, y, num)
    ana = Analyzer();
    xno = ana.norm(x);
    yno = ana.norm(y);

    plsed = obj.pls(xno, yno, num);

    q = zeros(num, 1);
    for i = 1 : num
        q(i) = plsed(:, i, 1)' * plsed(:, i, 2) / (plsed(:, i, 1)' * plsed(:, i, 1));
    end
    result = plsed(:, :, 1) * q;
end