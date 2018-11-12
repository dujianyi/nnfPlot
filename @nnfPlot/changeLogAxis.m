% Class function
% Function: updateData
% Update data in the plots to correspond to data sequence and plot
% properties
function changeLogAxis(self, axisN, func)
    switch axisN
        case 1
            for ip = 1:self.N
                tempX = get(self.hp(ip),'XData');
                newX = func(tempX);
                set(self.hp(ip), 'XData', newX);
            end
        case 2
            for ip = 1:self.N
                tempY = get(self.hp(ip),'YData');
                newX = func(tempX);
                set(self.hp(ip), 'YData', newY);
            end
    end
    self.updateData();
end