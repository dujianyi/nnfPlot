function batchCol(self, plotNum, colset)
    cols = self.Colors;
    if (length(colset) == 1)
        colToSet = cols{colset};
    else
        colToSet = colset;
    end
    for i = 1:length(plotNum)
        cols{plotNum(i)} = colToSet;
    end
    self.Colors = cols;
end