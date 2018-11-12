% Class function
% Function: updateData
% Update data in the plots to correspond to data sequence and plot
% properties
function updateData(self)
    self.N = length(self.hp);
    self.xdata = {};
    self.ydata = {};
    self.zdata = {};

    % resort errorbar data to put them at the end
    if (self.N > 1 && strcmp(get(self.hp(end), 'Type'), 'line'))
        tmp = self.hp(end);
        ii = self.N - 1;
        while (ii > 0 && strcmp(get(self.hp(ii), 'Type'), 'errorbar'))
            self.hp(ii + 1) = self.hp(ii);
            ii = ii - 1;
        end
        self.hp(ii+1) = tmp;
    end

    % save data;
    try
        % get the self data
        for ip = 1:self.N
            self.xdata{ip} = get(self.hp(ip),'XData');
            self.ydata{ip} = get(self.hp(ip),'YData');
            self.zdata{ip} = get(self.hp(ip),'ZData');
        end
    catch e
        warning('Unable to get data from all axes: %s', e.message);
    end
end