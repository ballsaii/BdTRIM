function [filepath] = getPath
% library that return path as object

% uigetfile for single file (simutanously)
% support multi-selection
[file,path,filter_index]=uigetfile('*.txt','Select TRIM distribution file','BdTRIM:Select'...
    ,'MultiSelect','on');
filepath = fullfile(path,file);
% uigetfile from loading

end