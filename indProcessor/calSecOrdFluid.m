%%  Fit second order fluid model to data from CaBER

%% Input 
% t - time data     [1 x N] [ms]
% d - diameter data [1 x N] [mm]

t = Timems';
d = Diameter';

t0 = 35;                     % Designated time to start fitting [ms]
sigma = 29.08e-3;            % Surface tension                  [N/m]
initParas = [1, 1e-4];       % Initial guesses of b1 [Pa s] and b2-b11 [Pa s^2]: [b1_0, b211_0]
searchParas = [0.01, 100];   % Program will search the range of 0.01*[b1_0, b211_0] to [b1_0, b211_0];

%% Processing (No need to modify)
loct0 = find(t >= t0);
t0 = t(loct0(1));
d0 = d(loct0(1));

tFit = t(loct0);
dFit = d(loct0);
minParasRange = searchParas(1) * initParas;
maxParasRange = searchParas(2) * initParas;
lsqoptions = optimoptions('lsqcurvefit', ...
                          'FiniteDifferenceType', 'central', ...
                          'FunctionTolerance', 1e-8);

constNum = [sigma, d0];

parasFit = lsqcurvefit(@(paras, x) log(funcFit_CaBER_secondorder_numerical(paras, x, constNum)), ...
                       initParas, ...
                       tFit, log(dFit), ...
                       minParasRange, maxParasRange, ...
                       lsqoptions);
fprintf('Fit parameters are:\nb1=%f [Pa s]\nb2-b11=%f [Pa s^2]\nCorresponding to viscosity: %f [Pa s]\nrelaxation time %f [ms]\n', parasFit(1), parasFit(2), parasFit(1), parasFit(2)/parasFit(1)*1000);
fprintf('*** Pay attention: cylindrical shape assumption in calculating stresses ***\n')
dFitFinal = funcFit_CaBER_secondorder_numerical(parasFit, tFit, constNum);
                   
semilogy(t, d, 'k', tFit, dFitFinal, 'r');
legend('Experimental data', 'Second order fluid model')
xlabel('t [ms]')
ylabel('d [mm]')