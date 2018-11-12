function allHideLines(self)
    tLineS = self.LineStyle;
    for i = 1:self.N
        if strcmp(get(self.hp(i), 'Type'), 'line')
            tLineS{i} = 'none';
        end
    end
    self.LineStyle = tLineS;
end