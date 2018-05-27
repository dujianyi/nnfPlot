function varargout = appFit(x, y, odp, typeFig, varargin)
% funcProc: apparent fitting
% inpuits:
% x, y, odp - order of polynomials, typeFig - figure type
% outputs:
% fitting parameters, 0-th order y, 1-st order y
toFitX = x;
toFitY = y;

if (isnumeric(odp))
    
switch typeFig
    case 'plot'
    case 'semilogx'
        toFitX = log10(toFitX);
    case 'semilogy'
        toFitY = log10(toFitY);
    case 'loglog'
        toFitX = log10(toFitX);
        toFitY = log10(toFitY);
end

locNAN = find(isnan(toFitY));
toFitX(locNAN) = [];
toFitY(locNAN) = [];

if (~isempty(varargin{1}))
    rangX = varargin{1};
    minX = rangX(1);
    maxX = rangX(2);
    locX = find(toFitX >= minX & toFitX <= maxX);
    toFitX = toFitX(locX);
    toFitY = toFitY(locX);
end


varargout{1} = polyfit(toFitX, toFitY, odp);

% Calculate fit data
switch typeFig
    case 'plot'
        varargout{2} = polyval(varargout{1}, x);
        varargout{3} = polyval(polyder(varargout{1}), x);
    case 'semilogx'
        varargout{2} = polyval(varargout{1}, log10(x));
        varargout{3} = polyval(polyder(varargout{1}), log10(x)).*1./(log(10)*x);
    case 'semilogy'
        varargout{2} = 10.^polyval(varargout{1}, x);
        varargout{3} = polyval(polyder(varargout{1}), x)*log(10).*varargout{2};
    case 'loglog'
        varargout{2} = 10.^polyval(varargout{1}, log10(x));
        varargout{3} = polyval(varargout{1}, log10(x)).*varargout{2}./x;
end

end    

