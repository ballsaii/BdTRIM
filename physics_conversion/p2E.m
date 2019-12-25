function energy= p2E( p )
% unit p in eV/c
% unit energy in MeV
m0c2 = 0.511E6; % eV
totalenergy = sqrt(p.^2+m0c2^2);
energy = (totalenergy - m0c2)/1E6;
end

