function dia = funcFit_CaBER_pf(parasNum, t)
% funcFit: CaBER second order ode45, only used starting from 0 (change XLim accordingly)
% dia - mm
% t = ms
% parameters: ffront, t_0


% ------- no need to modify -------
ffront = 1.28*(parasNum(1))^(1/3);

dia = 1000*ffront*(t/1000).^(2/3);

end



