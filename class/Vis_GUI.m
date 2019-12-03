classdef Vis_GUI
    
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        handles
        %         addplottab
    end
    
    methods
        function obj = Vis_GUI
            % defind figure
            f = figure('Position',[20 100 800 800],...
                'Units','pixel',...
                'MenuBar', 'none',...'
                'Name','Visulization GUI',...
                'Tag','vis_gui');
            
            % add workspace uimenu
            menu_new = uimenu(f,'Text','Plot',...
                'Tag','uimenu_plot');
            
            % add new uimenu
            menu_new_workspace = uimenu(menu_new,'Text','New',...
                'Tag','uimenu_new_workspace');
            
            % add delete uimenu
            menu_delete_workspace = uimenu(menu_new,'Text','Delete',...
                'Tag','uimenu_delete_workspace');
            
            % add tabgroup
            tabgp = uitabgroup(f,'Position',[.05 .05 .90 .90],...
                'TabLocation','top',...
                'Tag','tabgroup_plot');
            
            % update property
            obj.handles = guihandles(f);
        end
        
        function tab1=addplot(obj)
            
            % create a tab
            tab1 = uitab(obj.handles.tabgroup_plot,'Title','New');
            
            % add an axes on tab
            axes1 = axes(tab1,'Position',[0.1 0.25 0.75 0.70],...
                'Tag','axes_plot');
            
            % add command plot to a tab
            command = uicontrol('style','Edit',...
                'String','',...,
                'HorizontalAlignment','left',...
                'Parent',tab1,...
                'Units','normalized',...
                'Position',[0.1 0.07 0.75 0.10],...
                'Max',4,...
                'Backgroundcolor','w',...
                'Tag','txt_command',...
                'Enable','on');
            
            % add apply_commend plot
            apply = uicontrol('style','pushButton',...
                'String','Apply',...,
                'HorizontalAlignment','center',...
                'Parent',tab1,...
                'Units','normalized',...
                'Position',[0.88 0.1 0.10 0.05],...
                'Max',4,...
                'Tag','txt_apply',...
                'Enable','on');
            
            path = uicontrol('style','text',...
                'String','path:',...,
                'HorizontalAlignment','left',...
                'Parent',tab1,...
                'Units','normalized',...
                'Position',[0.1 0.01 0.75 0.05],...
                'Max',4,...
                'Tag','txt_path',...
                'Enable','on');
            
        end
        
        function deletework(obj)
            % create gui
            tabgp = obj.handles.tabgroup_plot;
            
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

