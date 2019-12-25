function p = E2p( energy )
% unit energy in MeV
% unit p in eV/c
m0c2 = 0.511;
totalenergy = energy + m0c2;
p = sqrt(totalenergy.^2-m0c2.^2)*1E6; % MeV/c to eV/c
end

