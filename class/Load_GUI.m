classdef Load_GUI
    
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        handles
    end
    
    methods
        function obj = Load_GUI
            % defind figure
            f = figure('Position',[20 200 300 500],...
                'Units','pixel',...
                'MenuBar', 'none',...'
                'Name','Load GUI',...
                'Tag','load_gui');
            
            % add uimenu
            menu_new = uimenu(f,'Text','New...',...
                                'Tag','uimenu_new');
            menu_new_plot = uimenu(menu_new,'Text','Plot',...
                        'Tag','uimenu_new_plot');
            % add uicontrol
            
            
            % update property
            obj.handles = guihandles(f); 
        end
        
        function addwork(obj)
            
            % create gui
            

        end
        
        
        %                     % call menu file
        %             h.add_plot.Callback = {@visulization};
        %
        %             % add submenu
        %             mitem = uimenu(m,'Text','&Text File');
        %             mitem.Accelerator = 'A';
        %             mitem.MenuSelectedFcn = @MenuSelected;
    end
end
