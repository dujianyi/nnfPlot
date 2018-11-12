function output = calGPCregularize(m, w, alp, N)
    x = log10(m);
    y = w;
    normtot = cumtrapz(x, y);
    normtot(end)
    y = y/normtot(end);
    minErr = 1e8;
    for in = 1:N
        lb = [zeros(1, in-1),    zeros(1, in),   min(x)*ones(1, in)];
        ub = [10*ones(1, in-1),  100*ones(1, in), max(x)*ones(1, in)];
        paras0 = [ones(1, in-1), ones(1, in),    unifrnd(min(x), max(x), 1, in)];
        paras = lsqcurvefit(@(paras, xx) func(in, paras, xx), paras0, x, y, lb, ub);
        nowErr = sum((y-func(in, paras, x)).^2) + alp*in;
        if (minErr > nowErr)
            minErr = nowErr;
            optParas = paras;
        end
    end
    output = optParas;
end

function y = func(N, paras, x)
    y = 0;
    A = paras(1:(N-1));
    sig = paras(N:(2*N-1));
    xm = paras((2*N):(3*N-1));
    A(N) = (1/sqrt(2*pi)-A*(sig(1:(N-1)))')/sig(N);
    for i = 1:length(A)
        y = y+A(i)*exp((x-xm(i)).^2/(2*sig(i)));
    end
end

