function dia = funcFit_CaBER_ivis(parasNum, t)
% funcFit: CaBER second order ode45, only used starting from 0 (change XLim accordingly)
% dia - mm
% t = ms
% parameters: ffront, t_0


% ------- no need to modify -------
ffront = 0.0608*(parasNum(1));
t_0 = parasNum(2);

dia = ffront*(t-t-0);

end



