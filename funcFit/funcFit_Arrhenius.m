function eta = funcFit_Arrhenius(parasNum, T, constNum)
% funcFit: Arrhenius
% temperature - degC

eta_0 = constNum(1);
T_0 = constNum(2);

eta = eta_0 * exp(parasNum(1)/8.314*(1./(273.15+T) - 1/(273.15+T_0)));

end

