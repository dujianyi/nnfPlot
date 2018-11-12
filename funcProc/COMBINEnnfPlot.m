function hp = COMBINEnnfPlot(figNames, plotNum)
datax = {};
datay = {};
lineStyle = {};
lineWidth = {};
markers = {};
colors = {};
legendText = {};
N = length(figNames);
for i = 1:N
    thishp = nnfPlot(figNames{i});
    thisPlotNum = plotNum{i};
    for j = 1:length(thisPlotNum)
        [datax{i, j}, datay{i, j}] = thishp.extData(thisPlotNum(j));
        lineStyle{i, j} = thishp.LineStyle{j};
        lineWidth{i, j} = thishp.LineWidth(j);
        markers{i, j}   = thishp.Markers{j};
        colors{i, j}    = thishp.Colors{j};
        try
            legendText{i, j} = thishp.Legend{j};
        catch
            legendText{i, j} = '';
        end
    end
    if (i == 1)
        typeFig = thishp.typeFig;
        xLim = thishp.XLim;
        yLim = thishp.YLim;
        xLabel = thishp.XLabel;
        yLabel = thishp.YLabel;
    end
    close all;
end

totPlot = 0;
for i = 1:N
    for j = 1:length(plotNum{i})
        totPlot = totPlot + 1;
        thisX = datax{i, j};
        thisY = datay{i, j};
        if (totPlot == 1)
            hp = nnfPlot(thisX, thisY);
            hp.typeFig = typeFig;
            hp.XLim = xLim;
            hp.YLim = yLim;
            hp.XLabel = xLabel;
            hp.YLabel = yLabel;
        else
            hp.addPlot(thisX, thisY, typeFig);
        end
        hp.LineStyle{totPlot} = lineStyle{i, j};
        hp.LineWidth(totPlot) = lineWidth{i, j};
        hp.Markers{totPlot}   = markers{i, j};
        hp.Colors{totPlot}    = colors{i, j};
        hp.Legend{totPlot}    = legendText{i, j};
    end
end
