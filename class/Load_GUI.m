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
            menu_new = uimenu(f,'Text','New',...
                                'Tag','uimenu_new');
            menu_new_plot = uimenu(menu_new,'Text','Workspace',...
                        'Tag','uimenu_new_workspace');
            % add uicontrol
            
            
            % update property
            obj.handles = guihandles(f); 
        end
        
        function addwork(obj)
            
            % create gui
            f = obj.handles.load_gui;
            
            tabgp = uitabgroup(f,'Position',[.05 .25 .9 .7],...
                'TabLocation','top',...
                'Tag','tabgroup_plot');
            
            tab1 = uitab(tabgp,'Title','Workspace');
            
            list = uicontrol(tab1,'style','listbox',...
                       'HorizontalAlignment','left',...
                       'Parent',f,...
                       'Units','normalized',...
                       'Position',[0.05 0.05 0.7 0.8],...
                       'Max',4,...
                       'Tag','txt_apply',...
                       'Enable','on');
                   
            moveup = uicontrol(tab1,'style','pushbutton',...
                       'HorizontalAlignment','left',...
                       'Parent',f,...
                       'Units','normalized',...
                       'Position',[0.05 0.05 0.7 0.8],...
                       'Max',4,...
                       'Tag','txt_apply',...
                       'Enable','on');
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
