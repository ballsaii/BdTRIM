function dataout = importPARMELA(filepath)
%% PARMELA import
% single file selection
if iscell(filepath)
    % not support multi files
%     for i=1:length(filepath)
%         dataout(i).data = importdata(filepath{i});
%         dataout(i).path = filepath{i};
%     end
else
        dataout.path = filepath;
end

targetfile = dataout.path;
stoprun = 0;
 
try
    output2 = TAPE2;
    h = msgbox('TAPE2');
catch
    output2 = TAPE3;
    h = msgbox('TAPE3');
end

dataout.data = output2;

%% TAPE2
    function output = TAPE2
        fid = fopen(targetfile,'r');
        while ~stoprun
            header = textscan(fid, 'numbuf=%f, ne=%f, z=%fref. particle phase=%f(%f)',1,'HeaderLines', 0, 'CollectOutput', 1);
            if isempty(header{1})
                return
                stoprun=1;
            else
                stoprun=0;
            end
            blank1 = fgetl(fid);
            blank2 =fgetl(fid);
            blank3 =fgetl(fid);
            ne = header{1}(2);
            output{ne}.numberparticle = header{1}(1);
            output{ne}.ref_z = header{1}(3);
            output{ne}.ref_phase = header{1}(5);
            output{ne}.data= cell2mat(textscan(fid, '%f %f %f %f %f %f %f',output{ne}.numberparticle,'HeaderLines', 0, 'CollectOutput', 1));
        end
        fclose(fid);
        h = msgbox('TAPE2','PARMELA');
    end
%% TAPE3
    function output = TAPE3
        fid = fopen(targetfile,'r');
        output = {''};
        blank1 = fgetl(fid);
        blank2 =fgetl(fid);
        blank3 =fgetl(fid);
        ne=1;
        while ~stoprun
            header1 = textscan(fid, 'Coordinate dump at phase %f',1,'HeaderLines', 0, 'CollectOutput', 1);
            header2 = textscan(fid, 'Number of particles: %f',1,'HeaderLines', 0, 'CollectOutput', 1);
            
            if isempty(header1{1})
                
                return
                stoprun=1;
            else
                stoprun=0;
            end
            
            output{ne}.ref_phase=header1{1};
            output{ne}.numberparticle=header2{1};
            % output{ne}.data= cell2mat(textscan(fid, '%f %f %f %f %f %f %d %d',header2{1},'HeaderLines', 1, 'CollectOutput', 1));
            blank4 =fgetl(fid);
            output{ne}.data = cell2mat(textscan(fid, '%f %f %f %f %f %f %f %f',header2{1},'HeaderLines', 1, 'CollectOutput', 1));
            
            ne=ne+1;
        end
        fclose(fid);
        h = msgbox('TAPE3','PARMELA');
    end





end


