classdef GUI_BdTRIM
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        numberworkspace
        handles
    end
    
    methods
        function obj = GUI_BdTRIM
            % defind figure
            f = openfig('main.fig');
            
            % add menu file
            
            % add tab
            tabgp = uitabgroup(f,'Position',[.05 .05 .3 .8]);
            tab1 = uitab(tabgp,'Title','Type of Signal');
            tab2 = uitab(tabgp,'Title','Plot Options');
            obj.numberworkspace = get(f,'Number');
            obj.handles = guihandles(f); 
        end
        
        function outputArg = add(obj,b)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.numberworkspace + b;
            tab3 = uitab(tabgp,'Title','Plot Options2');
        end
    end
end

