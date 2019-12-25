classdef ASTRAdis
    properties
        x
        y
        z
        px
        py
        pz
        xp
        yp
        Ek
        charge
        time
        time2
        index
        flag
        unit
    end
    methods
        function obj = ASTRAdis(astradist)
            
            % filter active particles
            flag = astradist(:,10);
            data = astradist(find(flag>=0),:);

            % relative z,pz,time to absolute value
            z_ref = astradist(1,3);
            pz_ref = astradist(1,6);
            time_ref = astradist(1,7);
            
            % summary
            z = [z_ref;z_ref+data(2:end,3)];
            pz = [pz_ref;pz_ref+data(2:end,6)];
            time = [time_ref;time_ref+data(2:end,7)]; % relative time
            x = data(:,1);
            y = data(:,2);
            px = data(:,4);
            py = data(:,5);
            charge = data(:,8);
            index = data(:,9);
 
            % assign to obj
            obj.x = x;
            obj.unit.x = 'm';
            obj.y = y;
            obj.unit.y = 'm';
            obj.z = z;
            obj.unit.z = 'm';
            obj.px = px;
            obj.unit.px = 'eV/c';
            obj.py = py;
            obj.unit.py = 'eV/c';
            obj.pz = pz;
            obj.unit.pz = 'eV/c';
            obj.time = time;
            obj.unit.time = 'ns';
            obj.charge = charge;
            obj.unit.charge = 'nC';
            obj.index = index;
            obj.unit.index = '1';
            obj.flag = flag;
            obj.unit.flag = '1';
            
            % calculate time2
            ptotal = sqrt(px.^2+py.^2+pz.^2);
            Ek = p2E(ptotal);
            g=p2gamma(E2p(Ek));
            betaz=sqrt(1-1./(g.^2));
            obj.time2 = (time(1)-((z-z(1))./(betaz*2.99792458E-1)));
            obj.unit.time2 = 'ns';
            obj.Ek = Ek;
            obj.unit.Ek = 'MeV';
            xp = atan(px./ptotal); % unit in rad
            yp = atan(py./ptotal);
            obj.xp = xp;
            obj.unit.xp = 'rad';
            obj.yp = yp;
            obj.unit.yp = 'rad';
            
            end
        end
end
    
    
