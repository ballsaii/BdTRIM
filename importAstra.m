function dataout = importAstra(filepath)
% funtion import ASTRA format

if iscell(filepath)
    % multi files
    for i=1:length(filepath)
        dataout(i).data = importdata(filepath{i});
        dataout(i).path = filepath{i};
    end
else
        dataout.data = importdata(filepath);
        dataout.path = filepath;
end

end

