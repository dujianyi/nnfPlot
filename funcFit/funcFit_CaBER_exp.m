function dia = funcFit_CaBER_exp(parasNum, t)
% funcFit: CaBER exponential
% dia - mm
% t = ms
dia = parasNum(1)*exp(-t/(3*parasNum(2)));
end

