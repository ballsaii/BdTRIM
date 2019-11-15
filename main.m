function [outputArg1,outputArg2] = main()
%   This main function calls the 'main.fig'

%   Initialize the main figure main_fig is an object-handle while Mhandles is a
%   handle (data)
    main_fig = open('main.fig');
    Mhandles = guihandles(main_fig);
    guidata(main_fig,Mhandles)
    
%   Initialized call_back function to objects
    set(Mhandles.menu_new_workspace,'Callback',{@new_workspace});
    
    % Intialized #object for result fig
    current_no_workspace=1;
    
    function new_workspace(hObject,evendata)
    
    % call function for open resultfig
    new_workspacefig(current_no_workspace)
    
    % increase index for next workspace
    current_no_workspace = current_no_workspace+1;
    
    end
    
end

