function dia = funcFit_CaBER_secondorder(parasNum, t)
% funcFit: CaBER exponential
% dia - mm
% t = mshp
dia = parasNum(1)*(parasNum(2) - t).^2;
end

