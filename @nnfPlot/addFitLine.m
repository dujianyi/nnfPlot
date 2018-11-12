% Class function
% Function: updateData
% Add a fit line to the specific data
% format
% -- addFitLine(2, 2 (quadratic fitting), # [1,3] (x range))
% -- addFitLine(2, @(x) func, [1] (initial values), # [1,3] (x range), # [4, 5, 6] (paras range), 'on' (apparent fit))
function paras = addFitLine(self, plotNum, fitFun, varargin)
    ploton = 1;
    paras = 0;
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
                xfitData = linspace(xlim(1), xlim(2), 1000);
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
                if (length(varargin) >= 4) && (~isempty(varargin{3}))
                    appfit = 1;
                end
                findNaN = isnan(yData);
                xData(findNaN) = [];
                yData(findNaN) = [];
                lsqoptions = optimoptions('lsqcurvefit', ...
                    'FiniteDifferenceType', 'central', ...
                    'FunctionTolerance', 1e-8);
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
                        xfitData = linspace(xlim(1), xlim(2), 1000);
                        yfitData = fitFun(xParas, xfitData);
                    catch errorCode
                        minLim = input('What is the minimum range? ');
                        maxLim = input('What is the maxinum range? ');
                        xfitData = linspace(minLim, maxLim, 1000);
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
end