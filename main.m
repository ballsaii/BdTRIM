function [outputArg1,outputArg2] = main()
%   This main function calls the 'main.fig'

%   Initialize the main figure main_fig is an object-handle while Mhandles is a
%   handle (data)
main_fig = open('main.fig');
Mhandles = guihandles(main_fig);
guidata(main_fig,Mhandles)

%   Initialized call_back function to objects
Mhandles.btn_workspace.Callback = {@new_workspace};

% Intialized #object for result fig
current_no_workspace =0;

    function new_workspace(hObject,evendata,handles)
        % increase index for next workspace
        current_no_workspace = current_no_workspace+1;
        
        % call function for open resultfig
        fig=new_workspacefig(current_no_workspace);
        hfig = guihandles(fig);
        handles.workspacefig = hfig;
        guidata(hObject,handles);
    end

end

