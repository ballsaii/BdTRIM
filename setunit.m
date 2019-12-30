function output = setunit(unit)
%% convert unit
switch unit
    case 'x'
        unit = 'length';
        output = pos_unit(unit);
    case 'y'
        unit = 'length';
        output = pos_unit(unit);
    case 'z'
        unit = 'length';
        output = pos_unit(unit);
    case 'px'
        unit = 'momentum';
        output = pos_unit(unit);
    case 'py'
        unit = 'momentum';
        output = pos_unit(unit);
    case 'pz'
        unit = 'momentum';
        output = pos_unit(unit)
    case 'xp'
        unit = 'divergent';
        output = pos_unit(unit)
    case 'yp'
        unit = 'divergent';
        output = pos_unit(unit)
    case 'Ek'
        unit = 'energy';
        output = pos_unit(unit)
    case 'charge'
        unit = 'charge';
        output = pos_unit(unit)
    case 'time'
        unit = 'charge';
        output = pos_unit(unit)
    case 'time2'
        unit = 'charge';
        output = pos_unit(unit)
    case 'index'
        unit = 'none';
        output = pos_unit(unit)
    case 'flag'
        unit = 'none';
        output = pos_unit(unit)
        
end

end

