% This reads in the data.txt file output from edgehog (only part of -0.5<z/Lf<0.5)
% Input parameters
data = dlmread('data.txt', '\t', 1, 0);

Ndata = size(data, 1);
blockInd = 1:(Ndata-1);
findBlock = find(data(blockInd, 1)> data(blockInd+1, 1));
dataProf = {};
st = 1;
for i = 1:length(findBlock)
    dataProf{i} = data((st+1):findBlock(i), :);
    st = findBlock(i) + 1;
end

dt = 1000/6700;
startT = 115; % csb
% startT = 50;  % M1
t = [0:(length(findBlock)-1)]*dt;

rad1 = zeros(1, length(findBlock));   % radial
rad2 = zeros(1, length(findBlock));   % axial
Rmid = 165;
spatialRes = 17e-3;
for i = 1:length(findBlock)
    thisProf = dataProf{i};
    % check circle
    % temp = (0:0.1:400)';
    % thisProf = [temp, -temp.^2+200*temp];
    [minR, minRpos] = max(thisProf(:, 2));
    thisProf(minRpos, 1)
    % plot(thisProf(:, 1), thisProf(:, 2));
    yy = sgfilterDataProc(thisProf(:, 1), thisProf(:, 2), 0:2, 3, 41);
    
    rad1(i) = Rmid - minR;
    % plot(thisProf(:, 1), thisProf(:, 2), '.', thisProf(:, 1), yy(:, 1), '-');
    % hold on;
    rad2(i)  = abs((1).^(3/2)./(yy(minRpos, 3)));
    
    cx = thisProf(minRpos, 1);
    cy = thisProf(minRpos, 2) - rad2(i);
    % viscircles([cx, cy], abs(Rmin))
    
end

hp = nnfPlot(t, rad1./(rad2));
hp.allHideLines;
hp.markersRandom;
hp.typeFig = 'semilogy'
hp.XLim = [0 120];
hp.XLabel = 'Time [ms]';
hp.YLabel = '\kappa_z/\kappa_r'
%{
hp.addPlot(t, rad1./(rad2), 'semilogy')
%}