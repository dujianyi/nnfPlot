function markerSpacing(self, plotnum, spc)
    len = length(get(self.hp(plotnum), 'XData'));
    self.hp(plotnum).MarkerIndices = 1:spc:len;
end