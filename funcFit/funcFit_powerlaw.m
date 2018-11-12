function y = funcFit_powerlaw(parasNum, x)
% funcFit: Arrhenius
% temperature - degC

a = parasNum(1);
n = parasNum(2);

y = a*(x.^n);

end

