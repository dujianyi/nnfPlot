% Class function
% Function: updateData
% Change properties of all errros, including capsize and lwith
function allErrorProps(self, csize, lwidth)
    for i = 1:self.N
        if strcmp(get(self.hp(i), 'Type'), 'errorbar')
            set(self.hp(i), 'CapSize', csize);
            set(self.hp(i), 'LineWidth', lwidth);
        end
    end
end