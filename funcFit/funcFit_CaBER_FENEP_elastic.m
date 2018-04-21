function dia = funcFit_CaBER_FENEP_elastic(parasNum, t, relTime, D0)
% funcFit: FENE-P model

Ec = parasNum(1);
b = parasNum(2);

tau = t/relTime;

% dia = 0;
syms x;

fun = @(x, t) (1/(1+Ec*(b+3)) - 1/(1+x*Ec*(b+3))) + 3*log((1+x*Ec*(b+3))/(1+Ec*(b+3))) + 4*Ec*(b+3)/(b+2)*(x-1) + (b+3)^2/(b*(b+2))*t;

dia = zeros(1, length(t));
triInit = logspace(-4, 0, 20);
for i = 1:length(dia)
    sol_x = fzero(@(x) fun(x, tau(i)), triInit(1));
    for j = 2:length(triInit)
        temp = fzero(@(x) fun(x, tau(i)), triInit(j));
        if isreal(temp) && temp > 0
            sol_x = temp;
        end
    end
    dia(i) = sol_x*D0;
end

% sol_x = fzero(@(x) fun(x, tau), exp(-4));
%{
findNaN = isnan(dia);
dia(findNaN) = 0;
%}
end

