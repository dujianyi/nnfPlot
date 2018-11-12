function reorderPlots(self, reorder)
    temphp = self.hp;
    for i = 1:self.N
        % delete(self.hp{i});
        self.hp(i) = temphp(reorder(i));
    end
    set(self.haxes, 'Children', flipud(self.hp));
    self.updateData();
end