function eta = maxEta_VROC(maxP, L, w, sr)
% funcFit: Max eta in VROC given the maximum pressure
% maxP: maximum pressure
% sr: given shear rate
    if strcmp(maxP, 'max')
        maxPr = 2e6;
    else
        maxPr = maxP;
    end
    if strcmp(L, 'default')
        Lr = 10.825-2.025;
    else
        Lr = L;
    end
    eta = maxPr*(w*1e-6)/2/(Lr*1e-3)./sr;    
    
end

