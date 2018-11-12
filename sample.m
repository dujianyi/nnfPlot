close all; clear; clc

%% Add data from array structure
dx = [1, 2, 3, 6, 8];
dy1 = [5.6, 1.9, 2.0, 8.3, 0.1];
dy2 = [1.3, 12, -5, 8.1, 10];

%% Add data from table data type
tableData = table([3:2:11]', [10*rand(1, 5)]'); % This type of data is extremely useful if imported from Excel

%% Plot 
hPlot = nnfPlot(dx, dy1);                      % #1: Initialize with (x:dx; y:dy1)
hPlot.addPlot(dx, dy2, 'semilogy', 1, '-');    % #2: Add (x:dx; y:dy2) with 'semilogy' type; 1 means linewidth, and '-' means linestyle
hPlot.addTable(tableData, 1, [2]);             % #3: Add tableData with 1st column as x, 2nd column (can be multiple columns) as y

hPlot.addError(2, [1, 0, 1, 1, 0]);            % Errorbars added to plot #2

hPlot.addRefLine(@(x) 5);                      % If constant, can also be written as hPlot.addRefLine(5)
hPlot.addRefLineY(3);

paras1 = hPlot.addFitLine(1, 3);                      % Add 3-rd order fit to Plot #1, returned with fit parameters
paras2 = hPlot.addFitLine(1, @sampleFun, [1, 1, 1]);  % Add @sampleFun fit to Plot #1 with initial values [1, 1, 1]. Refer to sampleFun to write own functions, returned with fit parameters

%% Properties setting: all the properties can either be changed or be read
hPlot.typeFig = 'plot';                             % Change plot type to: 'plot', 'semilogy', 'semilogx'
hPlot.XLabel = 'New X Label [m^{\pi}]';
hPlot.YLabel = 'New Y Label [The Grand Canyon]';    % Not a joke, 'The Grand Canyon' is indeed a volume measure!
hPlot.Legend = {'Plot initial', ...
                'Plot added', ...
                'Plot added from table', ...
                'Ref Line X', ...
                'Ref Line Y', ...
                'Fit Plot 1: polynomial', ...
                'Fit Plot 2: arbitrary function'};  % Errorbar will not be included
% hPlot.Legend = {'Prefix ', [1:7], ' Pa'};         % Another way of plotting
hPlot.Title = 'Easy plot!';

hPlot.saveToFig('sample.fig');
hPlot.export('sample.eps');

%% Batch setting

% Try this by uncommenting them
% hPlot.allHideLines               % Hide all lines,
% hPlot.markersRandom              % All lines put random markers
% hPlot.removePlot(6)              % Remove plot #6
% hPlot.reorderPlots(1:)           % Use with extreme caution, and the
                                   % input must be a permutation of
                                   % 1:#plots
                                   
hPlot.batchWidth([2, 4], 1);       % Set plot# [2, 4] to linewidth 1,
                                   % if want the linewidths of [2, 4] to be the same as line 1, use hPlot.batchWidth([2, 4], '1')
hPlot.batchStyle([2, 4], '--');    % Set plot# [2, 4] to linestyle '--',
                                   % if want the linestyle of [2, 4] to be the same as line 1, use hPlot.batchStyle([2, 4], 1)
hPlot.batchMarker([2, 4], 'o');    % Set plot# [2, 4] to markerstyle 'o',
                                   % if want the markerstyle of [2, 4] to be the same as line 1, use hPlot.batchMarker([2, 4], 1)
hPlot.batchCol([2, 4], [0 0 0]);   % Set plot# [2, 4] to colors RGB black,
                                   % if want the color of [2, 4] to be the same as line 1, use hPlot.batchCol([2, 4], 1)

%% Color map
hPlot.colMap(1:3, 'parula');       % Use 'parula' to set the color map; this feature will keep updating
