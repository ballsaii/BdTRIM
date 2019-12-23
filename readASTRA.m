function dataout = readASTRA()
% create data structure
dataout = struct('data',[],'path',[]);

% call library that get path(s)
path=getPath;

% support multi file
if iscell(path) % multi selction case
    for i=1:length(path)
        dataout(i).data=importTRIM(path{i});
        dataout(i).path=path{i};
    end
else
    dataout.data=importTRIM(path);% single
    dataout.path=path;
end
end

