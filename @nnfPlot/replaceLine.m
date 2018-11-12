% Class function
% Function: updateData
% Add a fit line to the specific data
% format
% -- addFitLine(2, 2 (quadratic fitting), # [1,3] (x range))
% -- addFitLine(2, @(x) func, [1] (initial values), # [1,3] (x range), # [4, 5, 6] (paras range), 'on' (apparent fit))
function replaceLine(self, oldLine, newLine)
    self.Colors{newLine} = self.Colors{oldLine};
    self.LineWidth(newLine) = self.LineWidth(oldLine);
    self.LineStyle{newLine} = self.LineStyle{oldLine};
    self.Markers{newLine} = self.Markers{oldLine};
    N = length(self.hp);
    reP = 1:N;
    lg = self.Legend;
    try    
        lg(N) = [];
    catch
        warning('Some legends are missing, and might need manual adjustments.')
    end
    reP(oldLine) = newLine;
    reP(newLine) = oldLine;
    self.reorderPlots(reP);
    self.removePlot(N);
    try    
        self.Legend = lg;
    catch
        warning('Manual adjustments are needed for legends.')
    end
end