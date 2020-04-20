function [outputArg1,outputArg2] = batch_stat(a)

% a is selectedTab object

% creat new obj
% b = SetVar;
test.alias = {'A','B'};
test.text = {'mean(x)','mean(y)'};
b = SetVar(test);
ff = GUI_ShowVar(b);

% set figure name by Tab title
ff.Name = 'User-defined Variable';

% create a working structor by a.data
objbeam = a.data;

no = 1;

% assign function callback to object in class
% add item
ff.findobj('Tag','uimenu_add_var').Callback = @addVar;
% edit item
% remove item

% add preview existing variables
    function addVar(hObject,evendata,handles)
        c = b.addVar(ff);
        handles = guihandles(c);
        c.findobj('Tag','txt_var_apply').Callback = {@ApplyVar,c};
    end

    function ApplyVar(hObject,evendata,handles)
        new.alias = handles.findobj('Tag','txt_var_alias').String;
        new.text = handles.findobj('Tag','txt_var_text').String;

        % append data
        b = SetVar(b,new);

        % close Apply figure
        close(handles);
        
        % update GUIShowVar
        ff = GUI_ShowVar(b,ff);
    end


    function deletework(hObject,evendata,handles)
        b.deletework
    end

    function commandbatch(hObject,evendata,handles)
        
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