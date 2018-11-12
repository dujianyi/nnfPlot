% Class function
% Function: updateData
% Add a constant to either x or y to a specific plot
function subData(self, plotNum, x, y)
    if length(x) == 1
        x = ones(1, length(plotNum))*x;
    end
    if length(y) == 1
        y = ones(1, length(plotNum))*y;
    end
    for i = 1:length(plotNum)
        set(self.hp(plotNum(i)), 'XData', self.xdata{plotNum(i)}+x(i));
        set(self.hp(plotNum(i)), 'YData', self.ydata{plotNum(i)}+y(i));
    end
    self.updateData();
end