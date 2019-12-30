function vis_plot(a)
% a is selectedTab object

try
    % create a working structor by a.data
    objbeam = a.data;
catch
    return;
end

% creat new Vis_GUI
b = Vis_GUI;

% set figure name by Tab title
b.handles.vis_gui.Name = a.Title;



% initialize uimenu
b.handles.uimenu_new_workspace.Callback = @addplot;
b.handles.uimenu_delete_workspace.Callback = @deletework;
b.handles.uimenu_unit_setting.Callback = @unitconvertor;

no = 1;
% auto generate tabd
if isempty(b.handles.tabgroup_plot.Children)
    % add auto tab
    addplot
end

    function addplot(hObject,evendata,handles)
        
        % add work tab
        new_tab = b.addplot;
        
        new_tab.Title = sprintf('WorkPlot %d',no);
        
        path = string(a.findobj('Tag','list_load').String(a.findobj('Tag','list_load').Value));
        
        % apply function to move uicontrol
        b.handles.tabgroup_plot.SelectedTab = new_tab;
        
        b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_path').String = path;
        
        b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_apply').Callback = @commandplot;
        
        b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_save').Callback = @save_command;
        b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_load').Callback = @load_command;
        
        % increase one for next
        no = no+1;
    end

    function deletework(hObject,evendata,handles)
        b.deletework
    end

    function commandplot(hObject,evendata,handles)
        
        
        target_file = a.findobj('Tag','list_load').Value;
        current_objbeam = objbeam(target_file);
        % condition
        condition = b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_condition').String;
        
        x = current_objbeam.x;
        y= current_objbeam.y;
        z= current_objbeam.z;
        xp = current_objbeam.xp;
        yp = current_objbeam.yp;
        Ek = current_objbeam.Ek;
        
        if ~isempty(condition)
            % apply condition
            x1 = current_objbeam.x(eval(condition));
            y1 = current_objbeam.y(eval(condition));
            z1 = current_objbeam.z(eval(condition));
            xp1 = current_objbeam.xp(eval(condition));
            yp1 = current_objbeam.yp(eval(condition));
            Ek1 = current_objbeam.Ek(eval(condition));
            
            % assign data
            assignin('caller','x',x1);
            assignin('caller','y',y1);
            assignin('caller','z',z1);
            assignin('caller','xp',xp1);
            assignin('caller','yp',yp1);
            assignin('caller','Ek',Ek1);
            
        else
            % no condition
            x1 = current_objbeam.x(:);
            y1 = current_objbeam.y(:);
            z1 = current_objbeam.z(:);
            xp1 = current_objbeam.xp(:);
            yp1 = current_objbeam.yp(:);
            Ek1 = current_objbeam.Ek(:);
            
            % assign data
            assignin('caller','x',x1);
            assignin('caller','y',y1);
            assignin('caller','z',z1);
            assignin('caller','xp',xp1);
            assignin('caller','yp',yp1);
            assignin('caller','Ek',Ek1);
            
        end
        % set command
        command = b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_command').String;
        
        % active current axes
        axes(b.handles.tabgroup_plot.SelectedTab.findobj('Type','Axes'));
        
        
        try obj_command = evalin('caller',command);
        catch h= warndlg('Input wrong command');
        end
        
        whos
        %         try eval(command)
        %         catch h= warndlg('Input wrong command');
        %         end
        
    end

    function save_command(hObject,evendata,handles)
        % uiputfile
        [file,path] = uiputfile('.txt','Save Command','saved_command');
        command = b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_command').String;
        cond = b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_condition').String;
        save_command = sprintf('conditon:%s\ncommand:%s',cond,command);
        fid = fopen(fullfile(path,file),'w');
        fprintf(fid,save_command);
        fclose(fid);
    end

    function load_command(hObject,evendata,handles)
        % uigetfile
        [file,path] = uigetfile('.txt','Load Command','saved_command');
        fid = fopen(fullfile(path,file),'r');
        command = textscan(fid,'conditon:%s\ncommand:%s','TextType','string');
        b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_condition').String = command{1};
        b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_command').String = command{2};
        fclose(fid);
    end

    function unitconvertor(hObject,evendata,handles)
        % load current units to GUI
        target_file = a.findobj('Tag','list_load').Value;
        
        % open GUI for unit setting returning figure
        unit_fig = b.unit_conversion(objbeam(target_file));

        % setunit(objbeam,f)
    end
end

