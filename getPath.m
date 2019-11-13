function [filepath] = getPath
% library that return path as object

% uigetfile for single file (simutanously)
[file,path,filter_index]=uigetfile('*.txt','Select TRIM distribution file','BdTRIM:Select');
filepath = fullfile(path,file);
% uigetfile from loading

end