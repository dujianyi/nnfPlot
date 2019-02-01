% Class function
% Function: updateData
% Add a fit line to the specific data
% format
% -- addFitLine(2, 2 (quadratic fitting), # [1,3] (x range))
% -- addFitLine(2, @(paras, x) func, [1] (initial values), # [1,3] (x range), # [4, 5, 6] (paras range), 'on' (apparent fit))
% -- addFitLine
function paras = addFitLine(self, plotNum, fitFun, varargin)
    ploton = 1;
    paras = 0;
    lsqoptions = optimoptions('lsqcurvefit', ...
                              'FiniteDifferenceType', 'central', ...
                              'FunctionTolerance', 1e-6);
    if length(plotNum) == 1
        if plotNum > 0 && plotNum <= self.N
            if isnumeric(fitFun)
                xData = self.xdata{plotNum};
                yData = self.ydata{plotNum};
                if (~isempty(varargin))
                    range = varargin{1};
                    frange = find(xData >= range(1) & xData <= range(2));
                    xData = xData(frange);
                    yData = yData(frange);
                end
                findNaN = isnan(yData);
                xData(findNaN) = [];
                yData(findNaN) = [];
                fFun = polyfit(xData, yData, fitFun);
                paras = fFun;
                % Output fFun
                fprintf('y=');
                for i = 1:length(fFun)-1
                    fprintf('(%f x^%d)+', fFun(i), length(fFun)-i);
                end
                fprintf('(%f)\n', fFun(end));
                % END OF Output fFun
                if (ploton)
                    xlim = self.XLim;
                    xfitData = linspace(xlim(1), xlim(2), 10000);
                    yfitData = polyval(fFun, xfitData);
                    self.addPlot(xfitData, yfitData, self.typeFig);
                end
            elseif isa(fitFun, 'function_handle')
                if (~isempty(varargin))
                    xData = self.xdata{plotNum};
                    yData = self.ydata{plotNum};
                    if (length(varargin) >= 2) && (~isempty(varargin{2}))
                        range = varargin{2};
                        frange = find(xData >= range(1) & xData <= range(2));
                        xData = xData(frange);
                        yData = yData(frange);
                    end
                    if (length(varargin) >= 3) && (~isempty(varargin{3}))
                        minParasRange = varargin{3};
                        maxParasRange = varargin{4};
                    end
                    appfit = 0;
                    if (length(varargin) >= 5)
                        appfit = 1;
                        fprintf('Apprent fitting...\n');
                    end
                    findNaN = isnan(yData);
                    xData(findNaN) = [];
                    yData(findNaN) = [];
                    if (appfit == 0)
                        if (exist('minParasRange',  'var'))
                            xParas = lsqcurvefit(fitFun, varargin{1}, xData, yData, minParasRange, maxParasRange, lsqoptions);
                        else
                            xParas = lsqcurvefit(fitFun, varargin{1}, xData, yData); %[1e4], [5e5], lsqoptions);
                        end
                    else
                        switch self.typeFig
                            case 'semilogy'
                                yData = log10(yData);
                                fitFun_fit = @(paras, x) log10(fitFun(paras, x));
                            case 'loglog'
                                yData = log10(yData);
                                fitFun_fit = @(paras, x) log10(fitFun(paras, x));
                            otherwise
                                fitFun_fit = fitFun;                            
                        end
                        if (exist('minParasRange',  'var'))
                            xParas = lsqcurvefit(fitFun_fit, varargin{1}, xData, yData, minParasRange, maxParasRange, lsqoptions);
                        else
                            xParas = lsqcurvefit(fitFun_fit, varargin{1}, xData, yData); %[1e4], [5e5], lsqoptions);
                        end
                    end
                    paras = xParas;
                    % Output parameters
                    fprintf('Parameters are:\n')
                    for i = 1:(length(xParas)-1)
                        fprintf('%f\t', xParas(i))
                    end
                    fprintf('%f\n', xParas(end))
                    if (ploton)
                        xlim = self.XLim;
                        try
                            xfitData = linspace(xlim(1), xlim(2), 10000);
                            yfitData = fitFun(xParas, xfitData);
                        catch errorCode
                            minLim = input('What is the minimum range? ');
                            maxLim = input('What is the maxinum range? ');
                            xfitData = linspace(minLim, maxLim, 10000);
                            yfitData = fitFun(xParas, xfitData);
                        end
                        self.addPlot(xfitData, yfitData, self.typeFig);
                    end
                else
                    error('No inital values are given for the parameters')
                end
            else
                error('No explicit form of fit function')
            end
        else
            error('Plot number exceeds the range');
        end
    else
        % Multifit, take all data together and find the best fit for all
        if isa(fitFun, 'function_handle')
            %% To be written
        else 
            if length(fitFun) == length(plotNum)
                % Constraint: the length of x must be the same
                Nplot = length(plotNum);
                xDataSet = [];
                yDataSet = [];
                for i = 1:Nplot
                    xData = self.xdata{plotNum(i)};
                    yData = self.ydata{plotNum(i)};
                    if (length(varargin) >= 2) && (~isempty(varargin{2}))
                        range = varargin{2};
                        frange = find(xData >= range(1) & xData <= range(2));
                        xData = xData(frange);
                        yData = yData(frange);
                    end
                    if (length(varargin) >= 3) && (~isempty(varargin{3}))
                        minParasRange = varargin{3};
                        maxParasRange = varargin{4};
                    end
                    appfit = 0;
                    if (length(varargin) >= 5)
                        appfit = 1;
                    end
                    findNaN = isnan(yData);
                    xData(findNaN) = [];
                    yData(findNaN) = [];
                    
                    if (iscolumn(xData) == 0)
                        xData = xData';
                    end
                    if (iscolumn(yData) == 0)
                        yData = yData';
                    end
                    fitFun_fit_current = fitFun{i};
                    if (appfit == 0)
                        fitFun_fit_now = fitFun_fit_current;
                    else
                        fprintf('Apprent fitting...\n');
                        switch self.typeFig
                            case 'semilogy'
                                yData = log10(yData);
                                fitFun_fit_now = @(paras, x) log10(fitFun_fit_current(paras, x));
                            case 'loglog'
                                yData = log10(yData);
                                fitFun_fit_now = @(paras, x) log10(fitFun_fit_current(paras, x));
                            otherwise
                                fitFun_fit_now = fitFun_fit_current;
                        end
                    end
                    
                    xDataSet(:, i) = xData;
                    yDataSet(:, i) = yData;
                    yDataSet
                    % fitFun_fit_now
                    if (i == 1)
                        fitFun_fit = @(paras, x) fitFun_fit_now(paras, x(:, 1));
                    else
                        fitFun_fit = @(paras, x) [fitFun_fit(paras, x), fitFun_fit_now(paras, x(:, 1))];
                    end
                
                end
                if (exist('minParasRange',  'var'))
                     xParas = lsqcurvefit(fitFun_fit, varargin{1}, xDataSet, yDataSet, minParasRange, maxParasRange, lsqoptions);
                else
                     xParas = lsqcurvefit(fitFun_fit, varargin{1}, xDataSet, yDataSet); %[1e4], [5e5], lsqoptions);
                end
                
                paras = xParas;
                % Output parameters
                fprintf('Parameters are:\n')
                for i = 1:(length(xParas)-1)
                    fprintf('%f\t', xParas(i));
                end
                fprintf('%f\n', xParas(end));
                if (ploton)
                    xlim = self.XLim;
                    for i = 1:Nplot
                        try
                            xfitData = linspace(xlim(1), xlim(2), 10000);
                            fitCurrent = fitFun{i};
                            yfitData = fitCurrent(xParas, xfitData);
                        catch errorCode
                        	minLim = input('What is the minimum range? ');
                            maxLim = input('What is the maxinum range? ');
                            xfitData = linspace(minLim, maxLim, 10000);
                            fitCurrent = fitFun{i};
                            yfitData = fitCurrent(xParas, xfitData);
                        end
                        self.addPlot(xfitData, yfitData, self.typeFig);
                    end
                end
            else
                error('Number of plots different from that of the functions.\n')
            end
        end
    end
end