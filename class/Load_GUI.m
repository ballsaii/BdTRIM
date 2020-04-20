classdef Load_GUI
    
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        handles
    end
    
    methods
        function obj = Load_GUI
            % defind figure
            f = figure('Position',[20 200 400 600],...
                'Units','pixel',...
                'MenuBar', 'none',...'
                'Name','Load GUI',...
                'Tag','load_gui');
            
            % add workspace uimenu
            menu_new = uimenu(f,'Text','Workspace',...
                'Tag','uimenu_workspace');
            
            % add new uimenu
            menu_new_workspace = uimenu(menu_new,'Text','New',...
                'Tag','uimenu_new_workspace');
            
            % add new uimenu
            menu_load_workspace = uimenu(menu_new,'Text','Load...',...
                'Tag','uimenu_load_workspace','Enable','off');
            
            % add new uimenu
            menu_load_workspace_SRIM = uimenu(menu_load_workspace,'Text','SRIM',...
                'Tag','uimenu_load_workspace_SRIM','Enable','on');            
            
            % add new uimenu
            menu_load_workspace_ASTRA = uimenu(menu_load_workspace,'Text','ATSRA',...
                'Tag','uimenu_load_workspace_ASTRA','Enable','on');
            
            % add new uimenu
            menu_load_workspace_ASTRA = uimenu(menu_load_workspace,'Text','PARMELA',...
                'Tag','uimenu_load_workspace_PARMELA','Enable','on');
            
            % add delete uimenu
            menu_delete_workspace = uimenu(menu_new,'Text','Delete',...
                'Tag','uimenu_delete_workspace','Enable','off');
            
            % add tab group
            tabgp = uitabgroup(f,'Position',[.05 .05 .9 .9],...
                'TabLocation','top',...
                'Tag','tabgroup_work');
            
            % update property
            obj.handles = guihandles(f);
        end
        
        function tab1=addwork(obj)
            
            % create gui
            tabgp = obj.handles.tabgroup_work;
            
            % num to string for name
            no = length(tabgp.Children)+1;
            tab1 = uitab(tabgp);
            
            list = uicontrol(tab1,'style','listbox',...
                'HorizontalAlignment','left',...
                'Units','normalized',...
                'Position',[0.05 0.05 0.7 0.9],...
                'Max',4,...
                'Tag','list_load',...
                'Enable','on');
            
            moveup = uicontrol(tab1,'style','pushbutton',...
                'HorizontalAlignment','left',...
                'String','Up',...
                'Units','normalized',...
                'Position',[0.75 0.90 0.2 0.05],...
                'Max',1,...
                'Tag','btn_moveup',...
                'Enable','on');
            movedown = uicontrol(tab1,'style','pushbutton',...
                'HorizontalAlignment','left',...
                'String','Down',...
                'Units','normalized',...
                'Position',[0.75 0.85 0.2 0.05],...
                'Max',1,...
                'Tag','btn_movedown',...
                'Enable','on');
            remove_item = uicontrol(tab1,'style','pushbutton',...
                'HorizontalAlignment','left',...
                'String','Remove',...
                'Units','normalized',...
                'Position',[0.75 0.80 0.2 0.05],...
                'Max',1,...
                'Tag','btn_removeitem',...
                'Enable','on');
            chk_batch = uicontrol(tab1,'style','checkbox',...
                'HorizontalAlignment','left',...
                'String','Batch',...
                'Units','normalized',...
                'Position',[0.75 0.70 0.2 0.05],...
                'Max',1,...
                'Tag','chk_batch',...
                'Enable','on');
            btn_Gobatch = uicontrol(tab1,'style','pushbutton',...
                'HorizontalAlignment','left',...
                'String','GoBatch',...
                'Units','normalized',...
                'Position',[0.75 0.65 0.2 0.05],...
                'Max',1,...
                'Tag','btn_GoBatch',...
                'Enable','off');
            btn_GoPlot = uicontrol(tab1,'style','pushbutton',...
                'HorizontalAlignment','left',...
                'String','GoPlot',...
                'Units','normalized',...
                'Position',[0.75 0.55 0.2 0.05],...
                'Max',1,...
                'Tag','btn_GoPlot',...
                'Enable','on');
            
        end
        
        function deletework(obj)
            % create gui
            tabgp = obj.handles.tabgroup_work;
            
            % check selected tab
            tabgp.SelectedTab.Parent=[];
            
        end
        

    end
end
