function [avrval, stdval] = avergStd(self, plotNum, xrange)
    if (plotNum > 0 && plotNum <= self.N)
        xData = self.xdata{plotNum};
        yData = self.ydata{plotNum};
        frange = find(xData >= xrange(1) & xData <= xrange(2));
        xData = xData(frange);
        yData = yData(frange);
        findNaN = isnan(yData);
        xData(findNaN) = [];
        yData(findNaN) = [];
        avrval = mean(yData);
        stdval = std(yData);
    else
        error('Plot number exceeds the range');
    end
end