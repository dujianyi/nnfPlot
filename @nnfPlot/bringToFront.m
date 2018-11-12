function bringToFront(self, plotNum)
    if (plotNum > 0 && plotNum <= self.N)
        uistack(self.hp(plotNum), 'top');
    else
        error('Plot number exceeds the range');
    end
end