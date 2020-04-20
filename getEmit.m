function emit = getEmit(x,xp,varargin)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
narginchk(2,4)
switch nargin
    case 2
        emit = sqrt(det([mean(sig(x).*sig(x)) mean(sig(x).*sig(xp));...
            mean(sig(x).*sig(xp)) mean(sig(xp).*sig(xp))]));
    case 4
        y = varargin{1};
        yp = varargin{2};
        emit = nthroot(det([mean(sig(x).*sig(x)) mean(sig(x).*sig(xp)) mean(sig(x).*sig(y)) mean(sig(x).*sig(yp));...
            mean(sig(xp).*sig(x)) mean(sig(xp).*sig(xp)) mean(sig(xp).*sig(y)) mean(sig(xp).*sig(yp));...
            mean(sig(y).*sig(x)) mean(sig(y).*sig(xp)) mean(sig(y).*sig(y)) mean(sig(y).*sig(yp));...
            mean(sig(yp).*sig(x)) mean(sig(yp).*sig(xp)) mean(sig(yp).*sig(y)) mean(sig(yp).*sig(yp))]),4);
    otherwise
        error('cannot calculate emittance')
        
end

