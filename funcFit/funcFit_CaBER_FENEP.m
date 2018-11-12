function varargout = funcFit_CaBER_FENEP(parasNum, t, t0, D0)
% funcFit: FENE-P model

opts = odeset('AbsTol', 1e-6, 'RelTol', 1e-6);
lambda = parasNum(2);
tspan = [0, 1.01*(max(t) - t0)/1000/lambda];
% dy1 - Azz
% dy2 - Arr
% dy3 - D
% y0 = [1.54, 1, 1]';
y0 = [1.5, 1, 1]';
sol = ode15s(@(t, y) funcFit_CaBER_FENEP_odefun(t, y, parasNum, D0), tspan, y0, opts);

%{
Azz = sol.y(1, :);
Arr = sol.y(2, :);
b = parasNum(3);
Z = 1./(1-(Azz+Arr)/b);
zfind = find(Z>0);
%}
% [min(t) max(t)]/relTime
soln = deval(sol, (t-t0)/1000/lambda);
% [dia, a1, a2, sr, exvis]
varargout{1} = soln(3, :)*D0;
if (nargout > 1)
    try
        Azz = soln(1, :);
        Arr = soln(2, :);
        D = soln(3, :)*D0;
        b = parasNum(1);
        lambda = parasNum(2);
        G0 = parasNum(3);
        sigma = parasNum(4);
        shearS = parasNum(5);
        Z = 1./(1 - (Azz + Arr)/b);
        epsdot = (2*sigma./(D/1000) - G0.*Z.*(Azz - Arr))/(3*shearS);
        exvis = 2*sigma./(D/1000)./(epsdot);
        varargout{2} = Azz;
        varargout{3} = Arr;
        varargout{4} = epsdot;
        varargout{5} = exvis;
    catch
        warning('Not enough number of varargout')
    end
end
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

