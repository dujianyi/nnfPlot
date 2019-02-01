function Gp = funcFit_SAOS_Maxwell_Gp(parasNum, w)
% funcFit: Maxwell model Gp, 
% constNum:
% ------- user input -------


% ------- no need to modify -------
G0 = parasNum(1);
lambda = parasNum(2);
Gp = (G0*(lambda*w).^2)./(1+(lambda*w).^2);

end



