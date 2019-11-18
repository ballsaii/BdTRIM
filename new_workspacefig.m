function result_fig = new_workspacefig(current_no_workspace)
%   Initialize a new result figure theme
    result_fig = open('load.fig');
%     data = guidata(result_fig);

    % Create a dummy GUI handle
    dummyHandles(current_no_workspace) = guihandles(result_fig);
    guidata(result_fig,dummyHandles(current_no_workspace));
    
    % Load data to result window
    result_fig.Name = num2str(current_no_workspace);
    end