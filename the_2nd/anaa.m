classdef anaa 
    methods(Static)
        function [result, v] = pcr(xno, num)
 
            v = xno' * xno ./ (size(xno,1) - 1);
            [eigvec, eigval] = eig(v);
            [~, idx] = sort(diag(eigval), 'descend');
            sortedvec = eigvec(:, idx);
            t = xno * sortedvec(:, 1:num);
            result = t;
            v = sortedvec(:, 1:num);
        end

        function [result, q, b] = pls(xno, yno, num)

            result = zeros(size(xno,1), num);
            
            q = zeros(num, 1); 

            wa = xno' * yno / sum(xno' * yno);
            w = zeros(size(wa, 1), num);
            w(:, 1) = wa;
            size(xno' * yno / sum(xno' * yno))
            result(:, 1) = xno * wa;
            p1 = xno' * result(:, 1) / (result(:, 1)' * result(:, 1));
            p = zeros(size(p1, 1), num);
            p(:, 1) = p1;
            q(:, 1) = result(:, 1)' * yno / (result(:, 1)' * result(:, 1));

            
            if num == 1
                b = wa / (p' * wa) * q;
                return
            end
            
            x_prev = xno;
            y_prev = yno;
            for i = 2 : num
                x_cur = x_prev -...
                 (result(:, i - 1) * (result(:, i - 1)' * x_prev/ (result(:, i - 1)' * result(:, i - 1))));
                y_cur = y_prev -...
                 (result(:, i - 1) * (result(:, i - 1)' * y_prev/ (result(:, i - 1)' * result(:, i - 1))));
                result(:, i) = x_cur * (x_cur' * y_cur / sum(x_cur' * y_cur));
                p(:, i) = x_cur' * result(:, i) / (result(:, i)' * result(:, i));
                q(i) = result(:, i)' * y_cur / (result(:, i)' * result(:, i));
                w(:, i) = x_cur' * y_cur / sum(x_cur' * y_cur);
                x_prev = x_cur;
            end

            b = w / (p' * w) * q;

        end
        function result = score(y, ypred)
            scoreb = (y - ypred).^2;
            scorea = (y.^2);
            result = 1 - sum(scoreb) / sum(scorea);
        end
    end
    methods
        function result = pls_gety(obj, x, y, num, testx)
            arguments
                obj
                x
                y
                num
                testx = NaN
            end

            ana = Analyzer();
            xno = ana.norm(x);
            yno = ana.norm(y);

            [plsed, q, b] = obj.pls(xno, yno, num);

            if isnan(testx)
                result = plsed * q;
            else
                testxno = ana.norm(testx);
                result = testxno * b;
            end
        end

        function result = pcr_gety(obj, x, y, num, testx)
            arguments
                obj
                x
                y
                num
                testx = NaN
            end

            ana = Analyzer();
            xno = ana.norm(x);
            y = ana.norm(y);
            [pcred, v] = obj.pcr(xno, num);

            b = (pcred' * pcred) \ pcred' * y;
            b_x = v * b;
            if isnan(testx)
                result = pcred * b;
            else
                testxno = ana.norm(testx);
                result = testxno * b_x;
            end
        end
    end
end