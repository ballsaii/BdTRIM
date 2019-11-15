function [outputArg1,outputArg2] = main()
%   This main function calls the 'main.fig'

%   Initialize the main figure
    main_fig = open('main.fig');
    Mhandles = guihandles(main_fig);
    guidata(main_fig,Mhandles)
    
%   Initialized call_back function to objects
    set(Mhandles.menu_new_resultfig,'Callback',{@new_resultfig});
    
    % Intialized #object for result fig
    no_window_result=1;
    
    function new_resultfig(hObject,evendata)
%   Initialize a new result fig
    result_fig = open('result.fig');
    Rhandles = guihandles(result_fig);
    guidata(result_fig,Rhandles);

    % Create a dummy GUI handle
    gui1Handles(no_window_result) = guidata(result_fig);
    % Load data to result window
    gui1Handles(no_window_result).result_fig.Name = num2str(no_window_result);
    no_window_result = no_window_result+1;
    end
    
end

