function Gp = funcFit_SAOS_SLS_Gp(parasNum, w)
% funcFit: Standard Linear Solid model Gp, 
% constNum:
% ------- user input -------


% ------- no need to modify -------
G0 = parasNum(1);
lambda = parasNum(2);
G1 = parasNum(3);
Gp = (G1+(G0+G1)*(lambda*w).^2)./(1+(lambda*w).^2);

end



