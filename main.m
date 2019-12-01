function main
%   This main function calls the 'main.fig'

%   Initialize the main figure main_fig is an object-handle while Mhandles is a
a = Load_GUI;

%   Initialized call_back function to objects
a.handles.uimenu_workspace.Callback = @refresh;
a.handles.uimenu_load_workspace.Callback = @load;
a.handles.uimenu_new_workspace.Callback = @addwork;
a.handles.uimenu_delete_workspace.Callback = @deletework;
% a.handles.tabgroup_work.Children.findobj('Tag','btn_moveup').Callback = @moveup;
% a.handles.tabgroup_work.Children.findobj('Tag','btn_movedown').Callback = @movedown;


    function refresh(hObject,evendata,handles)
        % check exist workspace
        if isempty(a.handles.tabgroup_work.Children)
            a.handles.uimenu_load_workspace.Enable = 'off';
        else
            a.handles.uimenu_load_workspace.Enable = 'on';
        end
    end

    function addwork(hObject,evendata,handles)
        % add work tab
        a.addwork;
        % apply function to move uicontrol
        a.handles.tabgroup_work.SelectedTab.findobj('Tag','btn_moveup').Callback = @moveup;
        a.handles.tabgroup_work.SelectedTab.findobj('Tag','btn_movedown').Callback = @movedown;

    end

    function load(hObject,evendata,handles)
        % add properties to selecttab
        try a.handles.tabgroup_work.SelectedTab.addprop('data');
        catch
            return;
        end
        % call local function to read file
        output = readTRIM;
        a.handles.tabgroup_work.SelectedTab.data = output;
        
        % display in listbox
        list = a.handles.tabgroup_work.SelectedTab.findobj('Tag','list_load');
        list.String = output.path;
        
        %
        
    end
    function deletework(hObject,evendata,handles)
        % delete current workspace
        a.deletework
    end

    function moveup(hObject,evendata,handles)
        move('up')
    end

    function movedown(hObject,evendata,handles)
        move('down')
    end

    function move(direction)
        % select to move 'up' or 'down'
        switch direction
            case 'up'
                ud = -1;
            case 'down'
                ud = 1;
            otherwise
                warndlg('Error');
                drawnow;
                return;
        end
        
        list = a.handles.tabgroup_work.SelectedTab.findobj('Tag','list_load');
        
        % target the selected value in the listbox
        selected_Value = list.Value;
        
        % move data
        %         selected_file = workspaceHandles(current_no_workspace).data(selected_Value);
        
        try
            %             adjacent_file = workspaceHandles(current_no_workspace).data(selected_Value+ud);
            %             workspaceHandles(current_no_workspace).data(selected_Value+ud) = selected_file;
            %             workspaceHandles(current_no_workspace).data(selected_Value) = adjacent_file;
            %
            % move file in the listbox up
            dummy = list.String(selected_Value+ud);
            list.String(selected_Value+ud)=list.String(selected_Value);
            list.String(selected_Value)=dummy;
            % follow selected cursor
            list.Value = selected_Value+ud;
        catch
            return;
        end
    end
end

