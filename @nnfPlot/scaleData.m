function scaleData(self, plotNum, xScale, yScale)
    if length(xScale) == 1
        xScale = ones(1, length(plotNum))*xScale;
    end
    if length(yScale) == 1
        yScale = ones(1, length(plotNum))*yScale;
    end
    for i = 1:length(plotNum)
        xd = get(self.hp(plotNum(i)), 'XData');
        set(self.hp(plotNum(i)), 'XData', xd*xScale(i));
        yd = get(self.hp(plotNum(i)), 'YData');
        set(self.hp(plotNum(i)), 'YData', yd*yScale(i));
    end
    self.updateData();
end