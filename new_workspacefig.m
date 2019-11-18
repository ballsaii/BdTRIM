function result_fig = new_workspacefig(current_no_workspace)
%   Initialize a new result figure theme
result_fig = open('load.fig');
%     data = guidata(result_fig);

% Create a dummy GUI handle
workspaceHandles(current_no_workspace) = guihandles(result_fig);
guidata(result_fig,workspaceHandles(current_no_workspace));

workspaceHandles(current_no_workspace).btn_openfile.Callback = {@openfile};

% Load data to result window
result_fig.Name = sprintf('Workspace no %d',current_no_workspace);

    function openfile(hObject,evendata,handles)
        alldata = readTRIM;
        for i=1:length(alldata)
            list{i} = alldata(i).path;
            %             data(i) = alldata(i).data;
        end
        
        % Write file to listbox
        old = get(workspaceHandles(current_no_workspace).lst_load,'String');
        workspaceHandles(current_no_workspace).lst_load.String = [old',list];
        
        % Update alldata to dummyHandles
        guidata(workspaceHandles(current_no_workspace),alldata)
    end
end