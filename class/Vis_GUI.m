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
            f = figure('Position',[20 100 800 600],...
                'Units','pixel',...
                'MenuBar', 'none',...'
                'Name','Visulization GUI',...
                'Tag','vis_gui');
            
%             % add uimenu
%             menu_new = uimenu(f,'Text','New...',...
%                                 'Tag','uimenu_new');
%             menu_new_plot = uimenu(menu_new,'Text','Plot',...
%                         'Tag','uimenu_new_plot');
            
            % add tabgroup
            tabgp = uitabgroup(f,'Position',[.05 .25 .9 .7],...
                'TabLocation','top',...
                'Tag','tabgroup_plot');
            
            % add command plot
            command = uicontrol('style','Edit',...
                       'String','XX',...,
                       'HorizontalAlignment','left',...
                       'Parent',f,...
                       'Units','normalized',...
                       'Position',[0.05 0.05 0.85 0.15],...
                       'Max',4,...
                       'Backgroundcolor','w',...
                       'Tag','txt_command',...
                       'Enable','on');
            
            % add an tab for example
            tab1 = uitab(tabgp,'Title','Plot');
            
            % add an axes on tab
            axes1 = axes(tab1);
            
            % add apply_commend plot
            apply = uicontrol('style','pushButton',...
                       'String','Apply',...,
                       'HorizontalAlignment','center',...
                       'Parent',f,...
                       'Units','normalized',...
                       'Position',[0.9 0.05 0.10 0.05],...
                       'Max',4,...
                       'Tag','txt_apply',...
                       'Enable','on');
            
            % update property
            obj.handles = guihandles(f); 
        end
        
        function addtab(obj,varargin)
            % call tab
            switch length(varargin)
                case 0
                    tab1 = uitab(obj.handles.tabgroup_plot,'Title','New plot');
                case 1
                    title = varargin{1};
                    tab1 = uitab(obj.handles.tabgroup_plot,'Title',title);
            end

            
            % add an axes on tab
            axes1 = axes(tab1);
            
            % update property
            obj.handles = guihandles(obj.handles.vis_gui);
        end
        
        function deletetab(obj,varargin)
            
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

