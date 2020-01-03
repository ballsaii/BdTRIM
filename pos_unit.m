function output = pos_unit(unit)
%UNTITLED2 Summary of this function goes here
switch unit
    case 'length'
        output = {'cm','mm','um','nm','A'};
    case 'momentum'
        output = {'eV/c','keV/c','MeV/c'};
    case 'time'
        output = {'us','ns','ps'};
    case 'divergent'
        output = {'mrad','rad','1'};
    case 'energy'
        output = {'keV','MeV'};
    case 'charge'
        output = {'nC','pC'};
    otherwise
        output = {'1'};
            
end
end

