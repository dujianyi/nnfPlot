function [t_all, d, SR, extVis] = hookeanDBanalytical_CaBER(tFin, D0, lambda, etaS, gamma)
% Calcualte Hookean DB with the form of
% -[3*etaS*(D-D0)+3*lambda*gamma*ln(D/D0)]=gamma*t
syms f(D, t);
Ca = etaS*D0/(lambda*gamma)

f(D, t) = 3*Ca*(D-1)+3*log(D)+t;
t_all = linspace(0, tFin/lambda, 1000)';
d = zeros(size(t_all));
SR = zeros(size(t_all));
extVis = zeros(size(t_all));

for i = 1:length(t_all)
    if i == 1
        initD = 1;
    else
        initD = d(i-1);
    end
    temp = vpasolve(f(D, t_all(i))==0, D, initD);
    d(i) = temp(1);
end

t_all = t_all*lambda;
d = d*D0;

% [~, SR] = partialFirstDev2(t_all, d, 2, 50, 'semilogy', [0, tFin]);

end

