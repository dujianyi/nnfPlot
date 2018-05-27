function eta = funcFit_thixo_steadyshear(parasNum, t, constNum)
% funcFit: thixotropic steady shear

eta_wa = constNum(1);
phi = constNum(2);
phi_max = constNum(3);
tfin = constNum(4);
sr = constNum(5);

zeta_0 = parasNum(1);
tau = parasNum(2);
beta = parasNum(3);
n = parasNum(4);

dydt = @(t, y, tau, beta, sr, n) 1/tau*(1-y) - beta*y*sr^n;

tspan = [0, tfin];
opts = odeset('RelTol', 1e-5, 'AbsTol', 1e-7);
sol = ode45(@(t, y) dydt(t, y, tau, beta, sr, n), tspan, zeta_0, opts);

zeta_t = deval(sol, t);
[min(zeta_t), max(zeta_t)];
F_t = 1./(1-zeta_t);

eta = eta_wa*(1-phi*F_t)./(1-phi*F_t/phi_max).^2;

end

