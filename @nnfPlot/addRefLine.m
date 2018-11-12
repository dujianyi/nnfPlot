% Class function
% Function: updateData
% Add a reference line (constant y) to the data
function [x, y] = addRefLine(self, refFun, varargin)
    xlimRange = self.XLim;
    xrange = linspace(xlimRange(1), xlimRange(2), 100);
    if nargin > 2
        xrange = varargin{1};
    end
    if isnumeric(refFun)
        yrange = ones(1, length(xrange))*refFun;
    else
        %{
                    yrange = zeros(1, length(xrange));
                    for i = 1:length(xrange)
                        yrange(i) = refFun(xrange(i));
                    end
        %}
        yrange = refFun(xrange);
    end
    x = xrange';
    y = yrange';
    refXDataCol = xrange;
    refYDataCol = yrange;
    self.addPlot(refXDataCol, refYDataCol, self.typeFig, 1, '--');
end