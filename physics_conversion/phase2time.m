function time = phase2time(phase,f0)
% unit phase in degree
% unit f0 in MHz
% unit time in ns

peroid = 1000/f0; % unit in ns
time  = phase*peroid/360;
end