classdef ASTRAdis
    properties
        data
        unit
    end
    methods
        function obj = ASTRAdis(astradist)
            
            obj.data.x = astradist.data(:,1);
            obj.unit.x = 'm';
            obj.data.y = astradist.data(:,2);
            obj.unit.y = 'm';
            obj.data.z = astradist.data(:,3);
            obj.unit.z = 'm';
            obj.data.px = astradist.data(:,4);
            obj.unit.px = 'eV/c';
            obj.data.py = astradist.data(:,5);
            obj.unit.py = 'eV/c';
            obj.data.pz = astradist.data(:,6);
            obj.unit.pz = 'eV/c';
            obj.data.time = astradist.data(:,7);
            obj.unit.time = 'ns';
            obj.data.charge = astradist.data(:,8);
            obj.unit.charge = 'nC';
            obj.data.index = astradist.data(:,9);
            obj.unit.index = '1';
            obj.data.flag = astradist.data(:,10);
            obj.unit.flag = '1';
            % calculate time2
            ptotal = sqrt(obj.data.px.^2+obj.data.py.^2+obj.data.pz.^2);
            Ek = p2E(ptotal);
            g=p2gamma(E2p(Ek));
            betaz=sqrt(1-1./(g.^2));
            obj.data.time2 = (obj.data.time(1)-((obj.data.z-obj.data.z(1))./(betaz*2.99792458E-1)));
            obj.unit.time2 = 'ns';
            obj.data.Ek = Ek;
            obj.unit.Ek = 'MeV';
            xp = atan(obj.data.px./ptotal); % unit in rad
            yp = atan(obj.data.py./ptotal);
            obj.data.xp = xp;
            obj.unit.xp = 'rad';
            obj.data.yp = yp;
            obj.unit.yp = 'rad';
            
            % short var for condition
            pz = obj.data.pz;
            time2 = obj.data.time2*1000; % unit in ps
            time = obj.data.time*1000;
            
            end
        end
end
    
    
