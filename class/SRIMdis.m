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
            try
                obj.x = str2double(data_array.data{7});
                obj.y = str2double(data_array.data{6});
                obj.z = str2double(data_array.data{5});
            catch
                obj.x = data_array.data{7};
                obj.y = data_array.data{6};
                obj.z =  data_array.data{5};
            end
            
            obj.unit.x = 'A';
            obj.unit.y = 'A';
            obj.unit.z = 'A';
            
            % sqrt(cosx^2 + cosy^2 + cosz^2) = 1
            % cosx = px/ptotal
            % replace z with x
            % define yp = py/pz;
            
            % unit of 1
            
            obj.xp = str2double(data_array.data{10})./str2double(data_array.data{8});
            obj.yp = str2double(data_array.data{9})./str2double(data_array.data{8});
            
            obj.unit.xp = '1';
            obj.unit.yp = '1';
            
            % energy
            % unit of keV
            obj.Ek = str2double(data_array.data{4});
            obj.unit.Ek = 'keV';
            
        end
        
        %         function outputArg = convunit(obj,var,a,b)
        %             %METHOD1 Summary of this method goes here
        %             %   Detailed explanation goes here
        %             outputArg = obj.Property1 + inputArg;
        %         end
    end
end

