% Class function
% Function: updateData
% Add a fit line to the specific data
% format
% -- addFitLine(2, 2 (quadratic fitting), # [1,3] (x range))
% -- addFitLine(2, @(x) func, [1] (initial values), # [1,3] (x range), # [4, 5, 6] (paras range), 'on' (apparent fit))
function axAdded = addSecondaryAxis(self, XYAxis, AxisScale, AxisLog, AxisLabel)
    axisCol = self.AxisColor;
    windowSize = self.BoxDim;
    if strcmp(XYAxis, 'x')
        axAdded = axes('XAxisLocation', 'top', 'color', 'none', 'YTick', [], ...
                        'YColor', 'none', 'FontSize', 20, 'LineWidth', 1.5, ...
                        'Position', [0.142, 0.107, 0.743, 0.8111]);
                    1
        self.haxes.Box = 'off';
        2
        axAdded.XLim = self.XLim * AxisScale;
        3
        axAdded.XScale = AxisLog;
        4
        axAdded.XLabel.String = AxisLabel;
        5
        axAdded.XAxis.TickLength = self.haxes.XAxis.TickLength;
        axAdded.XAxis.MinorTick = 'on';
    else
        axisLim = self.YLim;
        yyaxis right;
        ylim(axisLim*AxisScale);
        set(self.haxes, 'YScale', AxisLog);
        ylabel(AxisLabel);
        self.AxisColor = axisCol;
        axAdded = 0;
        yyaxis left;
    end
    
    self.BoxDim = windowSize;
end