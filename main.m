function main
%   This main function calls the 'main.fig'

%   Initialize the main figure main_fig is an object-handle while Mhandles is a
a = Load_GUI;

%   Initialized call_back function to objects
a.handles.uimenu_workspace.Callback = @refresh;
a.handles.uimenu_load_workspace.Callback = @load;
a.handles.uimenu_new_workspace.Callback = @addwork;
a.handles.uimenu_delete_workspace.Callback = @deletework;
a.handles.uimenu_analysis.Callback = @send_Vis_GUI;

%   Initialize Callback to VIS_GUI

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
        new_tab = a.addwork;
        
        % apply function to move uicontrol
        a.handles.tabgroup_work.SelectedTab = new_tab;
        
        % initiate callback for buttons
        a.handles.tabgroup_work.SelectedTab.findobj('Tag','btn_moveup').Callback = @moveup;
        a.handles.tabgroup_work.SelectedTab.findobj('Tag','btn_movedown').Callback = @movedown;
        a.handles.tabgroup_work.SelectedTab.findobj('Tag','btn_batch').Callback = @batch;
        a.handles.tabgroup_work.SelectedTab.findobj('Tag','btn_removeitem').Callback = @removeitem;
    end

    function batch(hObject,evendata,handles)
        list = a.handles.tabgroup_work.SelectedTab.findobj('Tag','list_load');
        
        if hObject.Value
            % batch
            set(list,'Enable','off');
        else
            set(list,'Enable','on');
        end
        
    end

    function load(hObject,evendata,handles)
        % call local function to read file
        alldata = readTRIM;
        drawnow;
        
        % add properties to selecttab
        try a.handles.tabgroup_work.SelectedTab.addprop('data');
            a.handles.tabgroup_work.SelectedTab.data = struct(alldata);
        catch
            
        end
         
        % listbox define
        list = a.handles.tabgroup_work.SelectedTab.findobj('Tag','list_load');
        

        
        %check existing data, number of data
        if isempty(get(list,'String'))
            last = 0;
        else
            last=size(get(list,'String'),1);
        end
        
        ii=1;
        for i=last+1:last+length(alldata)
            % record alldata to data structure
            a.handles.tabgroup_work.SelectedTab.data(i)=alldata(ii);
            
            % write file to listbox
            old = list.String;
            new = a.handles.tabgroup_work.SelectedTab.data(i).path;
            old{end+1}=new;
            
            % update to listbox
            list.String = old;
            
            % increment
            ii=ii+1;
        end        
    end

    function deletework(hObject,evendata,handles)
        % delete current workspace
        a.deletework
    end

    function removeitem(hObject,evendata,handles)
        list = a.handles.tabgroup_work.SelectedTab.findobj('Tag','list_load');
        current_item = list.Value;
%         list.String(current_item) = [];
    end

    function moveup(hObject,evendata,handles)
        try move('up')
        catch
            return;
        end
    end

    function movedown(hObject,evendata,handles)
        try move('down')
        catch
            return;
        end
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
        a.handles.tabgroup_work.SelectedTab;
        % target the selected value in the listbox
        selected_Value = list.Value;
        
        % move data
        selected_file = a.handles.tabgroup_work.SelectedTab.data(selected_Value);
        
        try
            adjacent_file =  a.handles.tabgroup_work.SelectedTab.data(selected_Value+ud);
            a.handles.tabgroup_work.SelectedTab.data(selected_Value+ud) = selected_file;
            a.handles.tabgroup_work.SelectedTab.data(selected_Value) = adjacent_file;
            
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

    function send_Vis_GUI(hObject,evendata,handles)
        list = a.handles.tabgroup_work.SelectedTab.findobj('Tag','list_load');
        % check single or batch 
        if a.handles.tabgroup_work.SelectedTab.findobj('Tag','btn_batch').Value
            New_VIS_GUI(a.handles.tabgroup_work.SelectedTab)
        else
            New_VIS_GUI(a.handles.tabgroup_work.SelectedTab,list.Value)
        end
    end

end

