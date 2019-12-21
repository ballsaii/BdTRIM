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
        
        % condition
        condition = b.handles.tabgroup_plot.SelectedTab.findobj('Tag','txt_condition').String;
        
        % read data
        objbeam = Bdis(dataplot(target_file));
        
        x = objbeam.x;
        y= objbeam.y;
        z= objbeam.z;
        xp = objbeam.xp;
        yp = objbeam.yp;
        Ek = objbeam.Ek;
        
        if ~isempty(condition)
            % apply condition
            x1 = objbeam.x(eval(condition));
            y1 = objbeam.y(eval(condition));
            z1 = objbeam.z(eval(condition));
            xp1 = objbeam.xp(eval(condition));
            yp1 = objbeam.yp(eval(condition));
            Ek1 = objbeam.Ek(eval(condition));
            
            % assign data
            assignin('caller','x',x1);
            assignin('caller','y',y1);
            assignin('caller','z',z1);
            assignin('caller','xp',xp1);
            assignin('caller','yp',yp1);
            assignin('caller','Ek',Ek1);
              
        else
            % no condition           
            x1 = objbeam.x(:);
            y1 = objbeam.y(:);
            z1 = objbeam.z(:);
            xp1 = objbeam.xp(:);
            yp1 = objbeam.yp(:);
            Ek1 = objbeam.Ek(:);
            
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
end

