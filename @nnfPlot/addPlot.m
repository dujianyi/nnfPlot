% Class function
% Function: updateData
% Update data in the plots to correspond to data sequence and plot
% properties
function addPlot(self, X, Y, typeFig, varargin)
    if ~isempty(self.haxes)
        hold(self.haxes, 'on');
    end
    if (~exist('typeFig'))
        typeFig = self.typeFig;
    end
    if strcmp(typeFig, 'patch')
        self.N = self.N + 1;
        self.hp(end+1) = patch(X, Y, varargin{1});
    else
        self.N = self.N + 1;
        self.hp(end+1) = feval(typeFig, X, Y);
        tWidth = self.LineWidth;
        tStyle = self.LineStyle;
        if (isempty(varargin))
            tWidth(end) = 2.5;
            tStyle{end} = '-';
        else
            tWidth(end) = varargin{1};
            tStyle{end} = varargin{2};
        end
        self.LineWidth = tWidth;
        self.LineStyle = tStyle;
    end
    self.updateData();
end