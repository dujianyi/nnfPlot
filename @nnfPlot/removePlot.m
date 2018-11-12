% Class function
% Function: updateData
% Remove a specific plot from the figure
function removePlot(self, plotNum)
    if (plotNum > 0 && plotNum <= self.N)
        delete(self.hp(plotNum));
        if (size(self.hp, 1) == 1)
            self.hp = [self.hp(1:(plotNum-1)), self.hp((plotNum+1):length(self.hp))];
        else
            self.hp = [self.hp(1:(plotNum-1)); self.hp((plotNum+1):length(self.hp))];
        end
        self.updateData();
    else
        error('Plot number exceeds the range');
    end
end