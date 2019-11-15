    function no_workspace = new_workspacefig(current_no_workspace)
%   Initialize a new result figure theme
    result_fig = open('result.fig');
    
    % Create a dummy GUI handle
    dummyHandles(current_no_workspace) = guihandles(result_fig);
    guidata(result_fig,dummyHandles(current_no_workspace));
    
    % Update
    guidata(result_fig,dummyHandles(current_no_workspace));

    % Load data to result window
    dummyHandles(current_no_workspace).result_fig.Name = num2str(current_no_workspace);
    
    % 
    
    end