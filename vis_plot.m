function [outputArg1,outputArg2] = vis_plot(a)
% a is selectedTab object

% creat new Vis_GUI
b = Vis_GUI;

% set figure name by Tab title
b.handles.vis_gui.Name = a.Title;

% create a working structor by a.data
dataplot = struct(a.data);

% initialize uimenu
b.handles.uimenu_new_workspace.Callback = @addplot;
b.handles.uimenu_delete_workspace.Callback = @deletework;

no = 1;
% auto generate tab
if isempty(b.handles.tabgroup_plot.Children)
    % add auto tab
    addplot
end

    function addplot(hObject,evendata,handles)
        
        % add work tab
        new_tab = b.addplot;
        
        new_tab.Title = sprintf('Workspace %d',no);
        
        path = string(a.findobj('Tag','list_load').String(a.findobj('Tag','list_load').Value));
        
        % apply function to move uicontrol
        b.handles.tabgroup_plot.SelectedTab = new_tab;
        
        b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_path').String = path;
        

        
        % initiate callback for buttons
        %         b.handles.tabgroup_plot.SelectedTab.findobj('Tag','axes_plot').Callback = @axes;
        b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_apply').Callback = @apply_plot;
        no = no+1;
    end

    function deletework(hObject,evendata,handles)
    b.deletework
    end
end

