classdef Bat_GUI
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        handles
    end
    
    methods
        function obj = Bat_GUI
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            f = figure('Position',[200,50,600,600],...
                'Unit','pixels','MenuBar','none');
            
            % add tabgroup
            tabgp = uitabgroup(f,'Position',[.05 .2 .9 .75],...
                'TabLocation','top',...
                'Tag','tablegroup');
            
            % add a tab for example
            tab1 = uitab(tabgp,'Title','Plot');
            
            % add a table for example
            table1 = uitable(tab1,...
                'Units','normalized',...
                'Position',[0.05 .05 0.9 0.9]);
            
            % add command
            command = uicontrol('style','edit',...
                'String','Type Command here',...,
                'HorizontalAlignment','left',...
                'Parent',f,...
                'Units','normalized',...
                'Position',[0.05 0.05 0.85 0.15],...
                'Max',4,...
                'Backgroundcolor','w',...
                'Tag','txt_apply',...
                'Enable','on');
            
            % add send_command plot
            batch = uicontrol('style','pushButton',...
                'String','Batch',...,
                'HorizontalAlignment','center',...
                'Parent',f,...
                'Units','normalized',...
                'Position',[0.9 0.05 0.10 0.05],...
                'Max',4,...
                'Backgroundcolor','w',...
                'Tag','button_batch',...
                'Enable','on');

            
            % update property
            obj.handles = guihandles(f);
        end
        
        function addtable(obj,varargin)
            switch length(varargin)
                case 0
                    tab1 = uitab(obj.handles.tablegroup,'Title','New Table');
                    
                case 1
                    tab1 = uitab(obj.handles.tablegroup,'Title',title);
            end
            
            % add an axes on tab
            table1 = uitable(tab1);
            
            % update property
%             obj.handles = guihandles(table1);
        end
        
        function output=command(obj)
            % evaluate and read command
            command = obj.handles.txt_apply.String;
            output=eval(command);
        end
        
       
    end
end

