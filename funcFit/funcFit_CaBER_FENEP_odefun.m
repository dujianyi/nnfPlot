function dy = funcFit_CaBER_FENEP_odefun(t, y, parasNum)
% funcFit: FENE-P model
% b - FENE factor
% lambda - relaxation time
% G0 - linear elastic modulus
% sigma - surface tension
% shearS - solvent viscosity

%{
b = parasNum(1);
lambda = parasNum(2);
G0 = parasNum(3);
sigma = parasNum(4);
shearS = parasNum(5);
D0 = parasNum()
%}

% 2C1/3*1/D_ast=3C2*espdot_ast+Z(Azz-Arr)
C1 = parasNum(1); % =sigma*lambda/shearS/D0
C2 = parasNum(2); % =lambda*G0/shearS
% Wagner et al: C2/C1~0.001 - 1; C2 < 1
b = parasNum(3);  % b as in FENE factor

% dy1 - Azz*=Azz
% dy2 - Arr*=Arr
% dy3 - D*=D/D0
dy = zeros(3, 1);
Azz = y(1);
Arr = y(2);
D = y(3);

Z = 1/(1-(Azz+Arr)/b);

epsdot_ast = 2/3*C1*1/D - C2/3*Z*(Azz-Arr);
dy(3) = -epsdot_ast*D/2;
dy(1) = 2*epsdot_ast*Azz - (Z*Azz-1);
dy(2) = -epsdot_ast*Arr  - (Z*Arr-1);

end

