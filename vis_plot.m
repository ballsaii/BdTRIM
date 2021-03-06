function vis_plot(a,varargin)
% does it add to github??
% push remote branch
try
    % create a working structor by a.data
    objbeam = a.data;
catch
    return;
end

% evaluation batch command

if ~length(varargin)==0
    batch = 1;
else
    batch = 0;
end

% a is selectedTab object

% creat new Vis_GUI
b = Vis_GUI;

% set figure name by Tab title
b.handles.vis_gui.Name = a.Title;



% initialize uimenu
b.handles.uimenu_new_workspace.Callback = @addplot;
b.handles.uimenu_delete_workspace.Callback = @deletework;
b.handles.uimenu_unit_setting.Callback = @unitconvertor;

no = 1;
% auto generate tabd
if isempty(b.handles.tabgroup_plot.Children)
    % add auto tab
    addplot
end

    function addplot(hObject,evendata,handles)
        
        % add work tab
        new_tab = b.addplot;
        new_tab.Title = sprintf('WorkPlot %d',no);
        path = string(a.findobj('Tag','list_load').String(a.findobj('Tag','list_load').Value));
        
        % apply function to move uicontrol
        b.handles.tabgroup_plot.SelectedTab = new_tab;
        b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_path').String = path;
        b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_apply').Callback = @commandplot;
        b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_save').Callback = @save_command;
        b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_load').Callback = @load_command;
        
        % increase one for next
        no = no+1;
    end

    function deletework(hObject,evendata,handles)
        b.deletework
    end

    function commandplot(hObject,evendata,handles)
        if batch
            % batch
            bc = varargin{1};
            
            % loop for number of SetVar
            for i=1:length(bc.alias)
                
                % loop for number of objbeam
                for j=1:length(objbeam)
                    
                    current_objbeam = objbeam(j);
                    p1 = properties(current_objbeam);
                    f1 = fieldnames(current_objbeam);
                    
                    % assign to workspace
                    assignin('caller',f1{i},getfield(current_objbeam,p1{i}));
                    
                    % create output array
                    dummy(j) = evalin('caller',bc.text{i});
                    
                    % assign object to workspace
                    assignin('caller','beam',objbeam(j));
                end
                % assign output array to alias
                assignin('caller',bc.alias{i},dummy);
                

            end
        else
            % single plot
            target_file = a.findobj('Tag','list_load').Value;
            current_objbeam = objbeam(target_file);
            % condition
            condition = b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_condition').String;
            
            % display to global workspace for condition
            % inspect the properties of obj
            p1 = properties(current_objbeam);
            f1 = fieldnames(current_objbeam);
            
            % assign common variables to workspace
            for i=1:length(f1)
                assignin('caller',f1{i},getfield(current_objbeam,p1{i}))
            end
            
            % assign object to workspace
            assignin('caller','this',current_objbeam);
        end
        
        % set command
        command = b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_command').String;
        
        % active current axes
        axes(b.handles.tabgroup_plot.SelectedTab.findobj('Type','Axes'));
        
        try
            obj_command = evalin('caller',command);
            disp(obj_command)
        catch
            h= warndlg('Wrong command!');
        end
    end

    function save_command(hObject,evendata,handles)
        % uiputfile
        [file,path] = uiputfile('.txt','Save Command','saved_command');
        command = b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_command').String;
        cond = b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_condition').String;
        save_command = sprintf('conditon:%s\ncommand:%s',cond,command);
        fid = fopen(fullfile(path,file),'w');
        fprintf(fid,save_command);
        fclose(fid);
    end

    function load_command(hObject,evendata,handles)
        % uigetfile
        [file,path] = uigetfile('.txt','Load Command','saved_command');
        fid = fopen(fullfile(path,file),'r');
        command = textscan(fid,'conditon:%s\ncommand:%s','TextType','string');
        b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_condition').String = command{1};
        b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_command').String = command{2};
        fclose(fid);
    end

    function unitconvertor(hObject,evendata,handles)
        %
        target_file = a.findobj('Tag','list_load').Value;
        
        % load objbeam
        this = objbeam(target_file);
        
        % open GUI for unit setting returning figure
        unit_fig = b.unit_conversion(this);
        
        unit_fig.findobj('Tag','applyunit').Callback = @applyunitH;
        unit_fig.findobj('Tag','cancelunit').Callback = @cancelunitH;
        
        function applyunitH(hObject,evendata,handles)
            that = applyunit(unit_fig,this);
            objbeam(target_file) = that;
            close(unit_fig);
            return;
        end
        function cancelunitH(hObject,evendata,handles)
            close(unit_fig);
            return;
        end
    end
end



