function [outputArg1,outputArg2] = New_VIS_GUI(a,varargin)
% a is selectedTab
% creat new Vis_GUI
b=Vis_GUI;
b.handles.vis_gui.Name = a.Title;
data = struct(a.data);
switch length(varargin)
    case 0
        % batch
        data = a.data;
    case 1
        % single
        no_item = varargin{1};
        data = a.data(no_item);
    otherwise
        return;
end
whos
end

