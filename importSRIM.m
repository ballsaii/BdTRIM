function dataout = importSRIM(filename)

dataout = struct('data',[],'path',[]);

% import SRIM
formatSpec = '%1s%5s%3s%13s%14s%11s%11s%11s%10s%s%[^\n\r]';

% Open the text file.
if iscell(filename)
    for i=1:length(filename)
    fileID = fopen(filename{i},'r');
    dataout(i).data = textscan(fileID, formatSpec,'Delimiter', '', ...
        'WhiteSpace', '','HeaderLines', 12,'TextType', 'string','ReturnOnError', false, 'EndOfLine', '\r\n');
    dataout(i).path = filename{i};
    fclose(fileID);
    end
else
    fileID = fopen(filename,'r');
    dataout.data = textscan(fileID, formatSpec,'Delimiter', '', ...
        'WhiteSpace', '','HeaderLines', 12,'TextType', 'string','ReturnOnError', false, 'EndOfLine', '\r\n');
    dataout.path = filename;
    fclose(fileID);
end

end

