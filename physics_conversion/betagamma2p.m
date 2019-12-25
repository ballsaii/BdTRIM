function p = betagamma2p( x )
m0c2 = 0.511E6; % unit in eV
beta = x./sqrt(1+x.^2);
p = beta.*m0c2.*sqrt(1./(1-beta.^2)); % unit in eV/c

end

