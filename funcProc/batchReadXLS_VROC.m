function varargout = batchReadXLS_VROC(fileName, num, headLine, plotTF, x, y)
% Read xls file from raw data VROC
% only read sheets with the same header structure (length can be different)
% -- fileName
% -- num: number of shear rates
% -- headLine: number of rows to be excluded
% -- plotTF: 0/1 if a plot is needed
% -- x: number of column as x
% -- y: number of column as y
data = cell(1, num);
for i = 1:num
    curSt = xlsread(fileName, i);
    curSt(1:headLine, :) = [];
    data{i} = curSt;
end
varargout{1} = data;
if (plotTF == 1)
    curD = data{1};
    hp = nnfPlot(curD(:, x), curD(:, y));
    for i = 2:num
        curD = data{i};
        hp.addPlot(curD(:, x), curD(:, y));
    end
    hp.colMap(1:num, @parula)
    varargout{2} = hp;
end