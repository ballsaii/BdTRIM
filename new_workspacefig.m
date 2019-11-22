function result_fig = new_workspacefig(current_no_workspace)
%   Initialize a new result figure theme
result_fig = open('load.fig');
%     data = guidata(result_fig);

% Create a dummy GUI handle
workspaceHandles(current_no_workspace) = guihandles(result_fig);
guidata(result_fig,workspaceHandles(current_no_workspace));

% Load data to result window
result_fig.Name = sprintf('Workspace no %d',current_no_workspace);

% openfile click
workspaceHandles(current_no_workspace).btn_openfile.Callback = {@openfile};

% moveup and down
workspaceHandles(current_no_workspace).btn_moveup.Callback = {@moveup};
% workspaceHandles(current_no_workspace).btn_movedown.Callback = {@movedown};



    function openfile(hObject,eventdata)
        alldata = readTRIM;
        drawnow;
        
        %check existing data, number of data
        if isempty(get(workspaceHandles(current_no_workspace).lst_load,'String'))
            last = 0;
        else
            last=size(get(workspaceHandles(current_no_workspace).lst_load,'String'),1);
            
        end
       
        ii=1;
        for i=last+1:last+length(alldata)
            %             data(i) = alldata(i).data;
            workspaceHandles(current_no_workspace).data(i)=alldata(ii);
            % Write file to listbox
            
            old = workspaceHandles(current_no_workspace).lst_load.String;
            list = workspaceHandles(current_no_workspace).data(ii).path;
            
            old{end+1}=list;
            workspaceHandles(current_no_workspace).lst_load.String = old;
            ii=ii+1;
        end
        
    end

    function moveup(hObject,eventdata)
        old = get(workspaceHandles(current_no_workspace).lst_load,'String');
        
        % target the selected value in the listbox
        selected_Value = workspaceHandles(current_no_workspace).lst_load.Value;
        
        % move data
        selected_file = workspaceHandles(current_no_workspace).data(selected_Value);
        
        try
            above_file = workspaceHandles(current_no_workspace).data(selected_Value-1);
            workspaceHandles(current_no_workspace).data(selected_Value-1) = selected_file;
            workspaceHandles(current_no_workspace).data(selected_Value) = above_file;
            % move file in the listbox up
            dummy = workspaceHandles(current_no_workspace).lst_load.String(selected_Value-1);
            workspaceHandles(current_no_workspace).lst_load.String(selected_Value-1)=workspaceHandles(current_no_workspace).lst_load.String(selected_Value);
            workspaceHandles(current_no_workspace).lst_load.String(selected_Value)=dummy;
            % follow selected cursor
            workspaceHandles(current_no_workspace).lst_load.Value = selected_Value-1;
        catch
            warndlg('Cannot move');
            drawnow;
            return;
        end
        whos
        
        % update alldata to dummyHandles
        
    end


end