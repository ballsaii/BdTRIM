function result_fig = new_workspacefig(current_no_workspace)
%   Initialize a new result figure theme
result_fig = open('load.fig');
%     data = guidata(result_fig);

% Create a dummy GUI handle
dummyHandles(current_no_workspace) = guihandles(result_fig);
guidata(result_fig,dummyHandles(current_no_workspace));

dummyHandles(current_no_workspace).btn_openfile.Callback = {@openfile};

% Load data to result window
result_fig.Name = sprintf('Workspace no %d',current_no_workspace);

    function openfile(hObject,evendata,handles)
        alldata = readTRIM;
        for i=1:length(alldata)
            list{i} = alldata(i).path;
        end
        old = get(dummyHandles(current_no_workspace).lst_load,'String');
        dummyHandles(current_no_workspace).lst_load.String = [old',list];
    end
end