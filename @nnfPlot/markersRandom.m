function markersRandom(self)
    tMarkers = self.Markers;
    libMarkers = {'*s', '*o', '*^', '*v'};
    for i = 1:self.N
        if strcmp(get(self.hp(i), 'Type'), 'line')
            tMarkers{i} = libMarkers{mod(i-1, length(libMarkers))+1};
        end
    end
    self.Markers = tMarkers;
end