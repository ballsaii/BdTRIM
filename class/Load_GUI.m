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
            
            % add workspace uimenu
            menu_new = uimenu(f,'Text','Workspace',...
                'Tag','uimenu_workspace');
            
            menu_analysis = uimenu(f,'Text','Analysis',...
                'Tag','uimenu_analysis');            
            
            % add new uimenu
            menu_new_workspace = uimenu(menu_new,'Text','New',...
                'Tag','uimenu_new_workspace');
            
            % add new uimenu
            menu_load_workspace = uimenu(menu_new,'Text','Load...',...
                'Tag','uimenu_load_workspace','Enable','off');
            
            % add delete uimenu
            menu_delete_workspace = uimenu(menu_new,'Text','Delete',...
                'Tag','uimenu_delete_workspace');
            
            % add tab group
            tabgp = uitabgroup(f,'Position',[.05 .05 .9 .9],...
                'TabLocation','top',...
                'Tag','tabgroup_work');
            
            % update property
            obj.handles = guihandles(f);
        end
        
        function addwork(obj)
            
            % create gui
            tabgp = obj.handles.tabgroup_work;
            
            % num to string for name
            no = length(tabgp.Children)+1;
            tab1 = uitab(tabgp,'Title',sprintf('Workspace %d',no));

            list = uicontrol(tab1,'style','listbox',...
                'HorizontalAlignment','left',...
                       'Units','normalized',...
                       'Position',[0.05 0.05 0.7 0.9],...
                       'Max',4,...
                       'Tag','list_load',...
                       'Enable','on');
                   
            moveup = uicontrol(tab1,'style','pushbutton',...
                       'HorizontalAlignment','left',...
                       'String','up',...
                       'Units','normalized',...
                       'Position',[0.8 0.60 0.2 0.10],...
                       'Max',1,...
                       'Tag','btn_moveup',...
                       'Enable','on');
            movedown = uicontrol(tab1,'style','pushbutton',...
                       'HorizontalAlignment','left',...
                       'String','down',...
                       'Units','normalized',...
                       'Position',[0.8 0.50 0.2 0.10],...
                       'Max',1,...
                       'Tag','btn_movedown',...
                       'Enable','on');                   
        end
        
        function deletework(obj)
            
            % create gui
            tabgp = obj.handles.tabgroup_work;
            
            % check selected tab
            tabgp.SelectedTab.Parent=[];
        
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
