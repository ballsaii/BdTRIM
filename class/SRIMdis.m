classdef SRIMdis
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x
        y
        z
        xp
        yp
        Ek
        unit
    end
    
    methods
        function obj = SRIMdis(data_array)
            %   a is data struct
            % z is longitudinal path
            
            % unit of Angstrom
                obj.x = data_array{7};
                obj.y = data_array{6};
                obj.z =  data_array{5};
            
            obj.unit.x = 'A';
            obj.unit.y = 'A';
            obj.unit.z = 'A';
            
            % sqrt(cosx^2 + cosy^2 + cosz^2) = 1
            % cosx = px/ptotal
            % replace z with x
            % define yp = py/pz;
            
            % unit of 1
            
            obj.xp = acos(data_array{10});
            obj.yp = acos(data_array{9});
            
            obj.unit.xp = 'rad';
            obj.unit.yp = 'rad';
            
            % energy
            % unit of keV
            obj.Ek = data_array{4};
            obj.unit.Ek = 'keV';
            
        end
        function obj = unitconvert(obj,unitn,old_unit,new_unit)
            % check old and new the same
            
            if unit2unitq(old_unit) == unit2unitq(new_unit)
                unitq = unit2unitq(old_unit);
            else
                return;
            end
            
            % set new_unit to obj i.e. obj.unit.x = 'mm' -> 'um'
            obj.unit = setfield(obj.unit,unitn,new_unit);
            
            % set new value to obj i.e. obj.x = 1 -> 1000
            old_value = getfield(obj,unitn);
            factor = convertunit(unitq,old_unit,new_unit);
            obj = setfield(obj,unitn,old_value*factor);
            
        end

    end
end

