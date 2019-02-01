function varargout = calGPC_GPC(mdata, ridata, mlow, mhigh)
% calGPC: program to calculate the Mn and Mw according to the GPC output, 
% calibration is needed on the log M data, but normalization is not necessary for RI data.

mLoc = find((mdata >= mlow) & (mdata <= mhigh));
m = mdata(mLoc);
ri = ridata(mLoc);

varargout{1} = sum(ri)/(sum(ri./m));
varargout{2} = sum(ri.*m)/(sum(ri));

end

