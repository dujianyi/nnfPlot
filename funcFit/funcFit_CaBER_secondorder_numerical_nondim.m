function h = funcFit_CaBER_secondorder_numerical_nondim(parasNum, t, constNum)
% funcFit: CaBER second order ode45, only used starting from 0 (change XLim accordingly)
% parameters: Oh, De
% constNum:
% -- correction factor X0 (Newtonian: 0.7127)
% -- initial value h_0
% ------- user input -------


% ------- no need to modify -------
Oh = parasNum(1);
De = parasNum(2);
X0 = constNum(1);
h_0 = constNum(2);
zta = constNum(3);

dydt = @(t, y, Oh, De, X0) (6*Oh*y - sqrt(36*Oh^2*y^2+48*Oh*De*(2*(X0/(1+zta*De/Oh))-1)*y))/(24*Oh*De);

tspan = [0, (max(t))];

opts = odeset('RelTol', 1e-5, 'AbsTol', 1e-7);
sol = ode45(@(t, y) dydt(t, y, Oh, De, X0), tspan, h_0, opts);

h = deval(sol, t-min(t));
%{
dR = [];
for i = 1:length(R)
    dR(i) = dydt(t(i), R(i), gamma, b1, b112);
end
dR = dR;
sr = -2*dR./R;
ext_eta1 = gamma./(-2*dR);
ext_eta2 = 3*b1 + 3*(b112)*sr;
rel_t = b112/b1;
%}
end



