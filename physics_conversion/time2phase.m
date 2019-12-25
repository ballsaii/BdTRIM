function phase = time2phase (time,freq)
% freq unit in MHz
peroid = 1000/freq; % unit in ns
phase = 360*time/peroid;


end

