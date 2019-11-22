function [outputArg1,outputArg2] = main()
%   This main function calls the 'main.fig'

%   Initialize the main figure main_fig is an object-handle while Mhandles is a
%   handle (data)
main_fig = open('main.fig');
Mhandles = guihandles(main_fig);
guidata(main_fig,Mhandles)

%   Initialized call_back function to objects
Mhandles.btn_workspace.Callback = {@new_workspace};
Mhandles.btn_visualize.Callback = {@visulization};

% Intialized #object for result fig
no_workspace =0;

    function new_workspace(hObject,evendata,handles)
        % increase index for next workspace
        no_workspace = no_workspace+1;
        
        % call function for open resultfig
        fig(no_workspace)=new_workspacefig(no_workspace);
        hfig = guihandles(fig(no_workspace));
        handles.workspacefig = hfig;
        guidata(hObject,handles);
        %         add_l = addlistener(fig,'Color','PostSet',@activewindow)
        Mhandles.figno(no_workspace) = fig(no_workspace);
    end

    function visulization(hObject,evendata,handles)
        % get active current workspace
        
        current_workspace = textscan(get(gcf,'Name'),'Workspace no %f');
        whos
%         guidata(Mhandles.figno(1))
%         disp('ok');
    end
end

