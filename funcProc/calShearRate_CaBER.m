function varargout = calShearRate_CaBER(t, d, sigma, ord, plum)
% calShearRate: program to calculate the shear rate from experimental raw
% data suing Savitzky-Golay filter
% input: t(Nx1), d(Nx1), sigma (surface tension for ext. vis.), (sg-filter parameters) ord, nplum

% This program also includes the feature to smoothen NaN data


% Get rid of nan data in x
toFitx = t(2:end); % First data is nan
toFitx = toFitx(1)+(0:(length(toFitx)-1))*mean(diff(toFitx));
toFity = d(2:end);
locNaNX = find(isnan(toFitx));

if (~isempty(locNaNX)) 
    toFitx = toFitx(1:(locNaNX(1)-1));
    toFity = toFity(1:(locNaNX(1)-1));
end
if (length(toFitx) < length(d)/2)
    warning('May truncate data too early, check nan in t data');
end

% Smoothen nan data in y
% algorithm: interpret with the left and right point
locNaN = find(isnan(toFity));
if (~isempty(locNaN))
    iLastNaN = length(locNaN);
    while (iLastNaN > 1 && (locNaN(iLastNaN-1) == locNaN(iLastNaN) - 1))
        iLastNaN = iLastNaN - 1;
    end
    iLastNaN
    if (iLastNaN == 1)
        error('Check d data: too many nans...')
    end
    toFitx = toFitx(1:(locNaN(iLastNaN)-1));
    toFity = toFity(1:(locNaN(iLastNaN)-1));
    toFity_cp = toFity;

    for i = 1:(iLastNaN-1)
        nowNaN = locNaN(i);
        nowX = toFitx(nowNaN);
        leftClear = i;
        while (leftClear > 1 && locNaN(leftClear-1) == locNaN(leftClear) - 1)
           leftClear = leftClear - 1; 
        end

        rightClear = i;
        while (rightClear < iLastNaN-1 && locNaN(rightClear+1) == locNaN(rightClear) + 1)
           rightClear = rightClear + 1; 
        end

        if (locNaN(leftClear) == 1 || locNaN(rightClear) == length(toFity))
            error('End NaN, unable to interpret...');
        end
        endPtx = toFitx([locNaN(leftClear)-1, locNaN(rightClear)+1]);
        endPty = toFity([locNaN(leftClear)-1, locNaN(rightClear)+1]);

        toFity_cp(nowNaN) = (endPty(2) - endPty(1)) / (endPtx(2) - endPtx(1)) * (nowX - endPtx(1)) + endPty(1);
    end
    toFity = toFity_cp;
end


% Use sg-filter
dsg = sgfilterDataProc(toFitx, toFity, [0, 1], ord, plum);
range_sg = ((plum+1)/2):(length(toFitx)-(plum+1)/2);
t_out = toFitx(range_sg);
sr = -2*dsg(range_sg, 2) ./ dsg(range_sg, 1)*1000;
extvis = sigma./(dsg(range_sg, 1)/2000)./sr;

figure(1)
semilogy(t, d, 'k.', toFitx, toFity, 'r.', toFitx, dsg(:, 1), 'b.');
legend('Raw data', 'Truncated and smoothened', 'After sg-filtered');
hold off;

figure(2)
plot(t_out, sr)
title('Shear rate')
hold off;

figure(3)
plot(sr, extvis);
title('Ext vis')
hold off;

varargout{1} = t_out;
varargout{2} = sr;
varargout{3} = extvis;

end    

