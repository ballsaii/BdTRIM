function [outputArg1,outputArg2] = batch_stat(a)

% a is selectedTab object

% creat new Vis_GUI
b = Bat_GUI;

% set figure name by Tab title
b.handles.vis_gui.Name = 'Batch Statistic';

% create a working structor by a.data
objbeam = a.data;

% initialize uimenu
b.handles.uimenu_new_workspace.Callback = @addplot;
b.handles.uimenu_delete_workspace.Callback = @deletework;
b.handles.uimenu_goplot.Callback = @goplot;

no = 1;

% auto generate tabd
if isempty(b.handles.tabgroup_batch.Children)
    % add auto tab
    addplot
end

    function addplot(hObject,evendata,handles)
        
        % add work tab
        new_tab = b.addplot;
        
        new_tab.Title = sprintf('BatchTab %d',no);
        
        path = a.Title;
        
        % apply function to move uicontrol
        b.handles.tabgroup_batch.SelectedTab = new_tab;
        
        b.handles.tabgroup_batch.SelectedTab.findobj('Tag','txt_path').String = path;
        
        b.handles.tabgroup_batch.SelectedTab.findobj('Tag','txt_apply').Callback = @commandbatch;
        
        b.handles.tabgroup_batch.SelectedTab.findobj('Tag','txt_save').Callback = @save_command;
        b.handles.tabgroup_batch.SelectedTab.findobj('Tag','txt_load').Callback = @load_command;
        
        % increase one for next
        no = no+1;
    end

    function deletework(hObject,evendata,handles)
        b.deletework
    end

    function commandbatch (hObject,evendata,handles)
           
        command = b.handles.tabgroup_batch.SelectedTab.findobj('Tag','txt_command').String;
        sendcommand = sprintf('arrayfun(@(all) %s, objbeam,''uni'',0)',command);
        
        try results = eval(sendcommand);
        catch h= warndlg('Input wrong command');
        end
        
        show_result=cell2mat(results');
        
        % input
        table1 = b.handles.tabgroup_batch.SelectedTab.findobj('Tag','table_plot');
        table1.Data = show_result;
        
        try b.handles.tabgroup_batch.SelectedTab.addprop('data');
            b.handles.tabgroup_batch.SelectedTab.data = show_result;
        catch
            
        end
    end

    function save_command(hObject,evendata,handles)
        % uiputfile
        [file,path] = uiputfile('.txt','Save Command','saved_command');
        command = b.handles.tabgroup_batch.SelectedTab.findobj('Tag','txt_command').String;
        fid = fopen(fullfile(path,file),'w');
        fprintf(fid,command);
        fclose(fid);
    end

    function load_command(hObject,evendata,handles)
        % uigetfile
        [file,path] = uigetfile('.txt','Load Command','saved_command');
        fid = fopen(fullfile(path,file),'r');
        command = textscan(fid,'%s','TextType','string');
        b.handles.tabgroup_batch.SelectedTab.findobj('Tag','txt_command').String = command{1};
        fclose(fid);
    end

    function goplot(hObject,evendata,handles)
        toplot(b.handles.tabgroup_batch.SelectedTab);
    end

end