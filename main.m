function main
%   This main function calls the 'main.fig'

%   Initialize the main figure main_fig is an object-handle while Mhandles is a
a = Load_GUI;

%   Initialized call_back function to objects
a.handles.uimenu_workspace.Callback = @refresh;
a.handles.uimenu_load_workspace_SRIM.Callback = @loadSRIM;
a.handles.uimenu_load_workspace_ASTRA.Callback = @loadASTRA;
a.handles.uimenu_load_workspace_PARMELA.Callback = @loadPARMELA;
a.handles.uimenu_new_workspace.Callback = @addwork;
a.handles.uimenu_delete_workspace.Callback = @deletework;


% number of tab
no=1;
%   Initialize Callback to VIS_GUI

    function refresh(hObject,evendata,handles)
        % check exist workspace
        if isempty(a.handles.tabgroup_work.Children)
            a.handles.uimenu_load_workspace.Enable = 'off';
            a.handles.uimenu_delete_workspace.Enable = 'off';
            a.handles.uimenu_analysis.Enable = 'off';
        else
            a.handles.uimenu_load_workspace.Enable = 'on';
            a.handles.uimenu_delete_workspace.Enable = 'on';
            a.handles.uimenu_analysis.Enable = 'on';
        end
    end

    function addwork(hObject,evendata,handles)
        % add work tab
        new_tab = a.addwork;
        
        % num to string for name
        new_tab.Title = sprintf('Workspace %d',no);
        % apply function to move uicontrol
        a.handles.tabgroup_work.SelectedTab = new_tab;
        
        % initiate callback for buttons
        a.handles.tabgroup_work.SelectedTab.findobj('Tag','btn_moveup').Callback = @moveup;
        a.handles.tabgroup_work.SelectedTab.findobj('Tag','btn_movedown').Callback = @movedown;
        a.handles.tabgroup_work.SelectedTab.findobj('Tag','chk_batch').Callback = @chkbatch;
        a.handles.tabgroup_work.SelectedTab.findobj('Tag','btn_removeitem').Callback = @removeitem;
        a.handles.tabgroup_work.SelectedTab.findobj('Tag','btn_GoPlot').Callback = @GoPlot;
        a.handles.tabgroup_work.SelectedTab.findobj('Tag','btn_GoBatch').Callback = @GoBatch;
        no = no+1;
    end

    function chkbatch(hObject,evendata,handles)
        list = a.handles.tabgroup_work.SelectedTab.findobj('Tag','list_load');
        btnGoBatch = a.handles.tabgroup_work.SelectedTab.findobj('Tag','btn_GoBatch');
        btnGoPlot = a.handles.tabgroup_work.SelectedTab.findobj('Tag','btn_GoPlot');
        if hObject.Value
            % batch
            set(list,'Enable','off');
            set(btnGoBatch ,'Enable','on')
            set(btnGoPlot ,'Enable','off')

        else
            set(list,'Enable','on');
            set(btnGoBatch ,'Enable','off')
            set(btnGoPlot ,'Enable','on')
        end
        
    end

    function loadSRIM(hObject,evendata,handles)
        
        % call local function to read file
        data_array = importSRIM(getPath);
        
        % convert data_array.data to SRIMobj
        SRIMobj = arrayfun(@(dis) SRIMdis(dis.data),data_array);
        
        % add properties to selecttab
        try
            a.handles.tabgroup_work.SelectedTab.addprop('data');
        catch
        end
        
        try
        data = [a.handles.tabgroup_work.SelectedTab.data SRIMobj];
        a.handles.tabgroup_work.SelectedTab.data = data;
        catch
            warndlg('Please load the same distibution in the workspace');
            return;
        end
        
        % define string in load_list (SRIM use filepath)
        showload = arrayfun(@(x) x.path,data_array,'UniformOutput',false);
        loaddis(showload,SRIMobj);
        
        % add SRIM_Workspace
        %         a.handles.tabgroup_work.SelectedTab.Title = strcat('SRIM_',a.handles.tabgroup_work.SelectedTab.Title);
    end

    function loadASTRA(hObject,evendata,handles)
        
        % call local function to read file
        data_array = importAstra(getPath);
        
        % convert data_array.data to SRIMobj
        ASTRAobj = arrayfun(@(dis) ASTRAdis(dis.data),data_array);
        
        % add properties to selecttab
        try
            a.handles.tabgroup_work.SelectedTab.addprop('data');
        catch
        end
        
        try
        data = [a.handles.tabgroup_work.SelectedTab.data ASTRAobj];
        a.handles.tabgroup_work.SelectedTab.data = data;
        catch
            warndlg('Please load the same distibution in the workspace');
            return;
        end
        
        % define string in load_list (ATSRA use filepath)
        showload = arrayfun(@(x) x.path,data_array,'UniformOutput',false);
        
        loaddis(showload,ASTRAobj);
        
        % add SRIM_Workspace
        %         a.handles.tabgroup_work.SelectedTab.Title = strcat('ASTRA_',a.handles.tabgroup_work.SelectedTab.Title);
    end

    function loadPARMELA(hObject,evendata,handles)
        
        % call local function to read file
        cdata_array = importPARMELA(getPath);
        
        % convert data_array.data to SRIMobj
        PARMELAobj = cellfun(@(dis) PARMELAdis(dis),cdata_array.data);
        
        % add properties to selecttab
        try
            a.handles.tabgroup_work.SelectedTab.addprop('data');
        catch
            warndlg('Please load the same distibution in the workspace');
            return;
        end
        
        % convert to obj array
%         PARMELAobj = [cPARMELAobj{1:length(cPARMELAobj)}];
        data_array = cdata_array;
        try
        data = [a.handles.tabgroup_work.SelectedTab.data PARMELAobj];
        a.handles.tabgroup_work.SelectedTab.data = data;
        catch
        end
        
        % define string in load_list (PARMELA use ref_phase)
        showload = cellfun(@(x) x.ref_phase,data_array.data,'UniformOutput',false);
        
        loaddis(showload,PARMELAobj);
        
        % add SRIM_Workspace
        %         a.handles.tabgroup_work.SelectedTab.Title = strcat('ASTRA_',a.handles.tabgroup_work.SelectedTab.Title);
    end

    function loaddis(showload,obj)
        
        % listbox define
        list = a.handles.tabgroup_work.SelectedTab.findobj('Tag','list_load');
        
        %check existing data, number of data
        if isempty(get(list,'String'))
            last = 0;
        else
            last=size(get(list,'String'),1);
        end
        
        % add multiple files
        ii=1;
        for i=last+1:last+length(obj)
            % record alldata to data structure
            try
                a.handles.tabgroup_work.SelectedTab.data(i)=obj(ii);
            catch
                warndlg('Please load the same distibution in the workspace');
                return;
            end
            % write file to listbox
            old = list.String;

            new = showload{ii};

            old{end+1}=new;
            
            % update to listbox
            list.String = old;
            
            % increment
            ii=ii+1;
        end
        % active last item
        list.Value = numel(list.String);
    end

    function deletework(hObject,evendata,handles)
        % delete current workspace
        a.deletework
    end

    function removeitem(hObject,evendata,handles)
        list = a.handles.tabgroup_work.SelectedTab.findobj('Tag','list_load');
        index = list.Value;
        content = list.String;
        content(index) = [];
        list.String = content;
        try list.Value =index-1;
        catch list.Value = 1;
        end
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

    function GoPlot(hObject,evendata,handles)
        % send to
        vis_plot(a.handles.tabgroup_work.SelectedTab)
    end

    function GoBatch(hObject,evendata,handles)
        % send to
        batch_stat(a.handles.tabgroup_work.SelectedTab)
    end
end

