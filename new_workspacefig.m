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
    jList = java.util.ArrayList;  % any java.util.List will be ok
%     jList.add(0,'First');
%     jList.add(1,'Second');
%     jList.add(2,'Third');
%     jList.add(3,'and last');
    jCBList = com.mathworks.mwswing.checkboxlist.CheckBoxList(jList);
    jScrollPane = com.mathworks.mwswing.MJScrollPane(jCBList);
    [jhCBList,hContainer] = javacomponent(jScrollPane,[10,10,80,65],gcf);
    set(jCBList, 'ValueChangedCallback', @myMatlabCallbackFcn);

    
    end