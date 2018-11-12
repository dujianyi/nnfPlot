function batchMarker(self, plotNum, markerset)
    markers = self.Markers;
    if (isnumeric(markerset))
        markerToSet = markers(markerset);
    else
        markerToSet = markerset;
    end
    for i = 1:length(plotNum)
        markers{plotNum(i)} = markerToSet;
    end
    self.Markers = markers;
end