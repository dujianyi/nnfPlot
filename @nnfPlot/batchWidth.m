function batchWidth(self, plotNum, widthset)
    widths = self.LineWidth;
    if (~isnumeric(widthset))
        widToSet = widths(str2num(widthset));
    else
        widToSet = widthset;
    end
    for i = 1:length(plotNum)
        widths(plotNum(i)) = widToSet;
    end
    self.LineWidth = widths;
end