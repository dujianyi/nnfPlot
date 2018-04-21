function dia = funcFit_CaBER_FENEP(parasNum, t, relTime, D0)
% funcFit: FENE-P model
% b - oar

opts = odeset('RelTol', 1e-4, 'AbsTol', 1e-4, 'BDF', 'on');
tspan = [min(t)/relTime*0.5 max(t)/relTime*2];
% dy1 - Azz
% dy2 - Arr
% dy3 - D
y0 = [1, 1, 1]';
% y0 = [10, 0, 1]';
sol = ode15s(@(t, y) funcFit_CaBER_FENEP_odefun(t, y, parasNum), tspan, y0, opts);

%{
Azz = sol.y(1, :);
Arr = sol.y(2, :);
b = parasNum(3);
Z = 1./(1-(Azz+Arr)/b);
zfind = find(Z>0);
%}
% [min(t) max(t)]/relTime

dia = deval(sol, t/relTime)*D0;
dia = dia(3, :);

% dia = sol.y(3, zfind)*D0;
%{
figure(1)
semilogy(sol.x(zfind), sol.y(3, zfind));
hold off;
figure(2)
semilogy(sol.x(zfind), Z(zfind));
hold off;
figure(3)
semilogy(sol.x(zfind), sol.y(1, zfind));
hold off;
%}
end

