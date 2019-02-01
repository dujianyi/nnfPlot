function varargout = gapCorrection_DHR(stressData, srData, gap, nStress)
% funcProc: gap correction to find the viscosity getting rid of wall slip
% inputs:
% {stressData}, {visData}, gap [um]
% outputs: corrected viscosity

nGap = length(gap);
corSR = zeros(nStress, 1);
x = 1./gap;
hp = nnfPlot([1], [1]);
for i = 1:nStress
    y = zeros(1, nGap);
    for j = 1:nGap
        y(j) = srData{j}(i);
    end
    paras = polyfit(x, y, 1);
    corSR(i) = paras(2);
    hp.addPlot(x, y, 'plot');
end
hp.removePlot(1);
hp.XLim = [0 4000];
hp.YLim = [0 400];
hp.allHideLines;
hp.markersRandom;
for i = 1:nStress
    hp.addFitLine(i, 1);
end
hp.batchCol((nStress+1):(2*nStress), [0 0 0]);
hp.batchWidth((nStress+1):(2*nStress), 1);
varargout{1} = corSR;
varargout{2} = hp;
end    

