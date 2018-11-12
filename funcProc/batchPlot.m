function hp = batchPlot(dataName, dataNum, x, y)
% funcProc: to batch plot a series of datasheet from xls
% inputs:
%   dataName - prefix of the datasheets
%   dataNum  - number of the tabs (0 - '', 1 - 'S1', ...)
%   x        - number of x axis
%   y        - number of y axis
% outputs:
% hp - nnfPlot handle

nameToPlot = cell(1, length(dataNum));
for i = 1:length(dataNum)
    if (dataNum(i) == 0)
        sufFix = '';
    else
        sufFix = ['S', num2str(dataNum(i))];
    end
    nameToPlot{i} = [dataName, sufFix];
end

for i = 1:length(dataNum)
    if (i == 1)
        hp = nnfPlot(evalin('base', nameToPlot{i}), x, y);
    else
        hp.addTable(evalin('base', nameToPlot{i}), x, y);
    end
end