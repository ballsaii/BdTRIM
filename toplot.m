function toplot(c)

% creat new Vis_GUI
d = Vis_GUI;

% set figure name by Tab title
d.handles.vis_gui.Name = c.Title;

% initialize uimenu
d.handles.uimenu_new_workspace.Callback = @addplot;
d.handles.uimenu_delete_workspace.Callback = @deletework;

no = 1;

% auto generate tabd
if isempty(d.handles.tabgroup_plot.Children)
    % add auto tab
    addplot
end

    function addplot(hObject,evendata,handles)
        % add work tab
        new_tab = d.addplot;
        
        new_tab.Title = sprintf('ToPlot %d',no);
        
        path = c.Title;
        % apply function to move uicontrol
        d.handles.tabgroup_plot.SelectedTab = new_tab;
        
        d.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_path').String = path;
        
        d.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_apply').Callback = @plot_batch;
        
        d.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_save').Callback = @save_command;
        d.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_load').Callback = @load_command;
        
        % increase one for next
        no = no+1;
    end
    function deletework(hObject,evendata,handles)
        d.deletework
    end

    function plot_batch(hObject,evendata,handles)
        % convert cell to array
        all = c.data;

        [num_row,num_col]=size(all);
        assignin('caller','all',all);
        
        % assign variables to workspace
        for i=1:num_col
            for j=1:num_row
                evalin('caller',(sprintf('y%d = all(:,%d)',i,i)));
                evalin('caller',(sprintf('x%d = all(%d,:)',j,j)));
                
            end
        end
        
        command = d.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_command').String;
        
        % set current axes
        axes(d.handles.tabgroup_plot.SelectedTab.findobj('Type','Axes'));
        
        try evalin('caller',command)
        catch h= warndlg('Input wrong command');
        end
        
    end

    function save_command(hObject,evendata,handles)
        % uiputfile
        [file,path] = uiputfile('.txt','Save Command','saved_command');
        command = d.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_command').String;
        fid = fopen(fullfile(path,file),'w');
        fprintf(fid,command);
        fclose(fid);
    end

    function load_command(hObject,evendata,handles)
        % uigetfile
        [file,path] = uigetfile('.txt','Load Command','saved_command');
        fid = fopen(fullfile(path,file),'r');
        command = textscan(fid,'%s','TextType','string');
        d.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_command').String = command{1};
        fclose(fid);
    end

end

