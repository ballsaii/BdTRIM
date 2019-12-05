classdef Bdis
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x
        y
        z
        xp
        yp
        Ek
    end
    
    methods
        function obj = Bdis(aa)
            %   a is data struct
            % z is longitudinal path
            % unit of Angstrom
            obj.x = aa.data.z;
            obj.y = aa.data.y;
            obj.z = aa.data.x;
            
            % sqrt(cosx^2 + cosy^2 + cosz^2) = 1
            % cosx = px/ptotal
            % replace z with x
            % define yp = py/pz;
            % unit of 1
            obj.xp = aa.data.cosz./aa.data.cosx;
            obj.yp = aa.data.cosy./aa.data.cosx;
            
            % energy
            % unit of keV
            obj.Ek = aa.data.Ek;
          
        end
        
%         function outputArg = convunit(obj,var,a,b)
%             %METHOD1 Summary of this method goes here
%             %   Detailed explanation goes here
%             outputArg = obj.Property1 + inputArg;
%         end
    end
end

