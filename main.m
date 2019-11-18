function [outputArg1,outputArg2] = main()
%   This main function calls the 'main.fig'

%   Initialize the main figure main_fig is an object-handle while Mhandles is a
%   handle (data)
    main_fig = open('main.fig');
    Mhandles = guihandles(main_fig);
    guidata(main_fig,Mhandles)
    
    % set window arragnement
    screensize = get(0,'screensize');
    screen_width = screensize(3);
    screen_height = screensize(4);
    
    Mhandles.main_fig.OuterPosition=[0,0,screen_width/2,screen_height];
    
%   Initialized call_back function to objects
    set(Mhandles.menu_new_workspace,'Callback',{@new_workspace});
    
    % Intialized #object for result fig
    current_no_workspace=0;
    
    
    
    function new_workspace(hObject,evendata)
    % increase index for next workspace
    current_no_workspace = current_no_workspace+1;  
    
    % call function for open resultfig
    [res_fig,res_handles] = new_workspacefig(current_no_workspace);
    guidata(Mhandles,res_fig)
    end

    
end

