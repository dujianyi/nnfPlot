function varargout = partialFirstDev1(x, y, odp, typeFig, varargin)
% partialFirstDev1: polynomial fitting of whole range
% funcProc: apparent fitting
% inputs:
% x, y, odp - order of polynomials, typeFig - figure type
% outputs:
% fitting parameters, 0-th order y, 1-st order y
toFitX = x;
toFitY = y;

if (isnumeric(odp) && odp > 0)

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

    if (~isempty(varargin))
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
    
    plot(toFitX, toFitY, 'o', x, varargout{2}, '-')
    if (~isempty(varargin))
        xlim(varargin{1});
    end
    
    varargout{2} = varargout{2};
    varargout{3} = varargout{3};

end    

