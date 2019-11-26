function main
%   This main function calls the 'main.fig'

%   Initialize the main figure main_fig is an object-handle while Mhandles is a
a = Load_GUI;

%   Initialized call_back function to objects
a.handles.uimenu_new_workspace.Callback = @addwork;
a.handles.uimenu_delete_workspace.Callback = @deletework;


    function addwork(hObject,evendata,handles)
        % add work tab
        a.addwork;
    end

    function deletework(hObject,evendata,handles)
        % delete current workspace
        a.deletework
    end
    function moveup
        a.handles.tabgroup_work.Children.findobj('Tag','btn_moveup')
    end
end

