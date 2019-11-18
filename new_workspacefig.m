    function [return_fig,return_handles] = new_workspacefig(current_no_workspace)
%   Initialize a new result figure theme
    result_fig = open('result.fig');
    
    % Create a dummy GUI handle
    dummyHandles(current_no_workspace) = guihandles(result_fig);
    guidata(result_fig,dummyHandles(current_no_workspace));
    
    % Update
    guidata(result_fig,dummyHandles(current_no_workspace));

    % Load data to result window
    dummyHandles(current_no_workspace).result_fig.Name = num2str(current_no_workspace);
    
    % return object and handles
    return_fig = result_fig;
    return_handles= dummyHandles(current_no_workspace);
    
    end