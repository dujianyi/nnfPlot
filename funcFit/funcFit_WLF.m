function eta = funcFit_WLF(parasNum, T, constNum)
% funcFit: WLF
% temperature - degC

eta_0 = constNum(1);
T_0 = constNum(2);

eta = eta_0 * exp(-parasNum(1)*(T - T_0)./(parasNum(2) + T - T_0));

end
