% Class function
% Function: updateData
% Add a fit line to the specific data
% format
% -- addFitLine(2, 2 (quadratic fitting), # [1,3] (x range))
% -- addFitLine(2, @(x) func, [1] (initial values), # [1,3] (x range), # [4, 5, 6] (paras range), 'on' (apparent fit))
function fillAroundLine(self, plotNum, x, uperror, lwerror)

    if (plotNum > 0 && plotNum <= self.N)
        toplotX = [x; flipud(x)]';
        toplotY = [lwerror; flipud(uperror)]';
        toplotCol = self.Colors{plotNum};
    end
    
    self.addPlot(toplotX, toplotY, 'patch', toplotCol);
end