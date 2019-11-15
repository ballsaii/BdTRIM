function data = readTRIM()
% create data structure
data = struct('data',[],'path',[]);

% call library that get path(s)
path=getPath;

% support multi file
if iscell(path) % multi selction case
    for i=1:length(path)
        data(i).data=importTRIM(path{i});
        data(i).path=path{i};
    end
else
    data(1)=importTRIM(path);% single
    data(1).path=path;
end
end

