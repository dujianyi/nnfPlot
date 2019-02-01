function eta = refConeEta_DHR(sr, R, T)
% funcFit: CaBER exponential
% dia - mm
% t = ms
    if (strcmp(T, 'max'))
        Tr = 200e-3;
    elseif (strcmp(T, 'min'))
        Tr = 5e-9;
    else
        Tr = T;
    end
    eta = 3*Tr./(2*pi*R^3*sr);
end

