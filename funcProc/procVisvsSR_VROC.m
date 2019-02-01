function varargout = procVisvsSR_VROC(data, malCho, w, h, pL)
% Process VROC data, with batchReadXLS_VROC data as input,
% with Weissenberg-Rabinowitch correction 
% -- malCho: manual chosen starting time
% -- w: width of the channel (mm)
% -- h: height of the channel (mm)
% -- pl: length of each pressure sensor (mm)
% ------ Read from data cell ------
    Np = length(pL);
    sr = zeros(1, length(data));
    p = zeros(length(data), Np);
    dp = zeros(length(data), Np);
    for i = 1:length(data)
        curD = data{i};
        curTime = curD(:, 1);             % Elapsed time
        loc = find(curTime > malCho(i));  % Manual chosen range to take average
        sr(i) = mean(curD(loc, 3));       % Apparent shear rate
        for j = 1:Np
            p(i, j) = mean(curD(loc, 6+j));
            dp(i, j) = std(curD(loc, 6+j));
        end
    end
    
    sstr = zeros(1, length(data));
    
% % ------ Error calculation ------
    errorAccum = zeros(1, length(data));
    for i = 1:length(data)
        f = polyfit(pL, p(i, :), 1);

        sstr(i) = -f(1)/2*(w*h)/(w+h);
        figure(i)
        title(['Fit p, sr=', num2str(sr(i))]);
        plot(pL, p(i, :), 'o', pL, (polyval(f, pL)), '-');
        xlabel('L [mm]');
        ylabel('p [Pa]');
        
        % Error calculation
        xm = mean(pL);
        denoval = sum((pL-xm).*(pL-xm));
        for j = 1:Np
            errorAccum(i) = errorAccum(i) + ((pL(j)-xm)*(1-1/Np)/denoval*dp(i, j))^2;
        end
        errorAccum(i) = abs(sstr(i)/f(1)*sqrt(errorAccum(i)));
        
    end
    
% ------ Weissenberg Rabinowitch correction ------

    figure(100)
    title('ln gammadot v ln tau_R')
    f = polyfit(log(sstr), log(sr), 1);
    plot(log(sstr), log(sr), 'o', log(sstr), polyval(f, log(sstr)), '-');
    xlabel('ln tau');
    ylabel('ln gamma_dot');
    hold off;
    
    sr_cor = sr/3.*(2+f(1));
    
    varargout{1} = sr_cor;           % True 
    varargout{2} = sstr;
    varargout{3} = sstr./sr_cor;
    varargout{4} = errorAccum;

end

