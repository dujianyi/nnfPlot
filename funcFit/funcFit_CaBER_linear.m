function dia = funcFit_CaBER_linear(parasNum, t)
% funcFit: CaBER exponential
% dia - mm
% t = ms
dia = 0.0707*2*parasNum(1)*(parasNum(2)-t);
end

