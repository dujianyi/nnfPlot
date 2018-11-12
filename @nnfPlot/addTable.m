% Class function
% Function: updateData
% Add data from the table
function addTable(self, tData, xcol, ycol)
    if (isnumeric(xcol) && length(xcol) == 1)
        dataCol = tData.Variables;
        if (~isnumeric(dataCol))
            dataCol = double(dataCol);
        end
        typeFig = self.typeFig;
        for i = 1:length(ycol)
            % 4/20/2018: Add NaN processing
            xData = dataCol(:, xcol);
            if (~isnumeric(xData))
                xData(find(ismissing(xData))) = '';
                xData = str2double(xData);
            end

            yData = dataCol(:, ycol(i));
            if (~isnumeric(yData))
                yData(find(ismissing(yData))) = '';
                yData = str2double(yData);
            end
            self.addPlot(xData, yData, typeFig);
        end
    else
        error('There can only be one column data of x!')
    end
end