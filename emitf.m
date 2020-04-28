function output = emitf(obj,type,varargin)
% How to use
% emit(obj) default geometry, formula1 (==emit('x','g',1))
% emit(obj,'n') normalized, formula1
% emit(obj,'n',2) normalized, formula2
%------------------------------------------------------------------%
% define default parameters
%
narginchk(2,3)

if isempty(varargin{1})
        output = getemit(obj,type,'geo');
else
        % example emit('x','n')
        output = getemit(obj,type,varargin{1});
% else
%         error('too many arguments');
%         return
end

    function output = getemit(obj,type,normalized)
        
        narginchk(2,3);
        % check essential members exist
        p = properties(obj);
        if all(ismember({'x','xp','y','yp'},p))
        else
            return
        end
        
        % assign local vars
        x=obj.x;
        y=obj.y;
        xp = obj.xp;
        yp = obj.yp;
        Ek = obj.Ek;
        switch type
            case 'x'
                emit = getEmit(x,xp);
            case 'y'
                emit = getEmit(y,yp);
            case 'xy'
                emit = getEmit(x,xp,y,yp);
        end
        % unit
        %                 output.unit.x = strjoin({obj.unit.x,obj.unit.xp});
        %                 output.unit.y = strjoin({obj.unit.y,obj.unit.yp});
        %                 output.unit.xy = strjoin({obj.unit.x,obj.unit.xp,obj.unit.y,obj.unit.yp});
        switch normalized
            case 'geo'
                factor = 1;
                output = emit * factor;
            case 'norm'
                factor = p2beta(E2p(mean(Ek))).*p2gamma(E2p(mean(Ek)));
                output = emit * factor;
            otherwise
                return
        end
    end
end