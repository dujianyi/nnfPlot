function batchStyle(self, plotNum, styleset)
    stls = self.LineStyle;
    if (isnumeric(styleset))
        styleToSet = stls(styleset);
    else
        styleToSet = styleset;
    end
    for i = 1:length(plotNum)
        stls{plotNum(i)} = styleToSet;
    end
    self.LineStyle = stls;
end