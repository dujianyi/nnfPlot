function Gp = funcFit_SAOS_Jeffrey_Gpp(parasNum, w)
% funcFit: Maxwell model Gp, 
% constNum:
% ------- user input -------


% ------- no need to modify -------
G0 = parasNum(1);
lambda = parasNum(2);
eta0 = parasNum(3);
Gp = G0*(lambda*w)./(1+(lambda*w).^2) + eta0*w;

end



