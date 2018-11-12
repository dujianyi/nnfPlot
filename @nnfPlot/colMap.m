function colMap(self, plotNum, cmap)
    cols = self.Colors;
    % colormap(cmap);
    % cols_map = colormap;
    % stride = size(cols_map, 1)/(length(plotNum)-1)-1;
    cols_map = cmap(length(plotNum));
    for i = 1:length(plotNum)
        cols{plotNum(i)} = cols_map(i, :);
    end
    self.Colors = cols;
end