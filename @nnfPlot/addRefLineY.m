% Class function
% Function: updateData
% Add data from the table
function [x, y] = addRefLineY(self, xValue, varargin)
    ylimRange = self.YLim;
    yrange = linspace(ylimRange(1), ylimRange(2), 100);
    if nargin > 2
        yrange = varargin{1};
    end
    xrange = ones(1, length(yrange))*xValue;
    x = xrange';
    y = yrange';
    refXDataCol = xrange;
    refYDataCol = yrange;
    self.addPlot(refXDataCol, refYDataCol, self.typeFig, 1, '--');
end