function batchMarkerSize(self, plotNum, mksize)
    if (~isnumeric(mksize))
        sizeToSet = get(self.hp(str2num(mksize)), 'MarkerSize');
    else
        sizeToSet = mksize;
    end
    
    for i = 1:length(plotNum)
        set(self.hp(plotNum(i)), ...
            'MarkerSize',      sizeToSet);
    end
end