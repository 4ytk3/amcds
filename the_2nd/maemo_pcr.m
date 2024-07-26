function result = pcr(x, num)
    ana = Analyzer();
    xno = ana.norm(x)

    v = xno' * xno ./ (size(xno,1) - 1);
    [eigvec, eigval] = eig(v);
    [~, idx] = sort(diag(eigval), 'descend');
    sortedvec = eigvec(:, idx)
    
    t = xno * sortedvec(:, 1:num);
    result = t;
end