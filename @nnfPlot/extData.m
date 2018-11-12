function [x, y] = extData(self, plotNum)
    if (plotNum < 1 || plotNum > self.N)
        error('Plot number exceeds the range');
    else
        x = self.xdata{plotNum}';
        y = self.ydata{plotNum}';
    end
end