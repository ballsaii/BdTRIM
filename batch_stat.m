function [outputArg1,outputArg2] = batch_stat(a)

% a is selectedTab object

% creat new Vis_GUI
b = Bat_GUI;

% set figure name by Tab title
b.handles.vis_gui.Name = a.Title;

% create a working structor by a.data
dataplot = struct(a.data);

% initialize uimenu
b.handles.uimenu_new_workspace.Callback = @addplot;
b.handles.uimenu_delete_workspace.Callback = @deletework;

no = 1;

% auto generate tabd
if isempty(b.handles.tabgroup_plot.Children)
    % add auto tab
    addplot
end

    function addplot(hObject,evendata,handles)
        
        % add work tab
        new_tab = b.addplot;
        
        new_tab.Title = sprintf('WorkTab %d',no);
        
        path = string(a.findobj('Tag','list_load').String(a.findobj('Tag','list_load').Value));
        
        % apply function to move uicontrol
        b.handles.tabgroup_plot.SelectedTab = new_tab;
        
        b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_path').String = path;
        
        b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_apply').Callback = @commandbatch;
        
        b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_save').Callback = @save_command;
        b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_load').Callback = @load_command;
        
        % increase one for next
        no = no+1;
    end

    function deletework(hObject,evendata,handles)
        b.deletework
    end

    function commandbatch (hObject,evendata,handles)
        objbeam = arrayfun(@(x) Bdis(x),dataplot);      
        command = b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_command').String;
        sendcommand = sprintf('arrayfun(@(all) %s, objbeam,''uni'',0)',command);
        try results = eval(sendcommand);
        catch h= warndlg('Input wrong command');
        end
        whos
        show_result=cell2mat(results');
        table1 = b.handles.tabgroup_plot.SelectedTab.findobj('Tag','table_plot');
        table1.Data = show_result;
    end

    function save_command(hObject,evendata,handles)
        % uiputfile
        [file,path] = uiputfile('.txt','Save Command','saved_command');
        command = b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_command').String;
        fid = fopen(fullfile(path,file),'w');
        fprintf(fid,command);
        fclose(fid);
    end

    function load_command(hObject,evendata,handles)
        % uigetfile
        [file,path] = uigetfile('.txt','Load Command','saved_command');
        fid = fopen(fullfile(path,file),'r');
        command = textscan(fid,'%s','TextType','string');
        b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_command').String = command{1};
        fclose(fid);
    end
end