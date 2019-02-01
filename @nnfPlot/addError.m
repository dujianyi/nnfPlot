% Class function
% Function: updateData
% Add data from the table
function addError(self, plotNum, errorY, varargin)
    if plotNum > 0 && plotNum <= self.N
        xData = self.xdata{plotNum};
        yData = self.ydata{plotNum};
        if (~isempty(varargin))
            range = varargin{1};
            frange = find(xData >= range(1) & xData <= range(2));
            xData = xData(frange);
            yData = yData(frange);
        end
        if isa(errorY, 'function_handle')
            errorYData = errorY(xData);
        else
            errorYData = errorY;
        end
        if (size(errorYData, 1) > size(errorYData, 2))
            if (size(errorYData, 2) == 1)
                self.hp(end+1) = errorbar(xData, yData, errorYData, 'horizontal');
            else
                self.hp(end+1) = errorbar(xData, yData, errorYData(:, 1), errorYData(:, 2), 'horizontal');
            end
        else
            if (size(errorYData, 1) == 1)
                self.hp(end+1) = errorbar(xData, yData, errorYData);
            else
                self.hp(end+1) = errorbar(xData, yData, errorYData(1, :), errorYData(2, :));
            end
        end
        self.hp
        self.updateData();
        tWidth = self.LineWidth;
        tWidth(end) = tWidth(plotNum);
        self.LineWidth = tWidth;
        tStyle = self.LineStyle;
        tStyle{end} = 'none';
        self.LineStyle = tStyle;
        tColors = self.Colors;
        tColors{end} = tColors{plotNum};
        self.Colors = tColors;
    else
        error('Plot number exceeds the range');
    end
end