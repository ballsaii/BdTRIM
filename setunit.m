function output = setunit(unit)
% convert unit
switch unit
    case 'x'
        unitq = 'length';
        output = pos_unit(unitq);
    case 'y'
        unitq = 'length';
        output = pos_unit(unitq);
    case 'z'
        unitq = 'length';
        output = pos_unit(unitq);
    case 'px'
        unitq = 'momentum';
        output = pos_unit(unitq);
    case 'py'
        unitq = 'momentum';
        output = pos_unit(unitq);
    case 'pz'
        unitq = 'momentum';
        output = pos_unit(unitq);
    case 'xp'
        unitq = 'divergent';
        output = pos_unit(unitq);
    case 'yp'
        unitq = 'divergent';
        output = pos_unit(unitq);
    case 'Ek'
        unitq = 'energy';
        output = pos_unit(unitq);
    case 'charge'
        unitq = 'charge';
        output = pos_unit(unitq);
    case 'time'
        unitq = 'charge';
        output = pos_unit(unitq);
    case 'time2'
        unitq = 'charge';
        output = pos_unit(unitq);
    case 'index'
        unitq = 'none';
        output = pos_unit(unitq);
    case 'flag'
        unitq = 'none';
        output = pos_unit(unitq);
    case 'phase'
        unitq = 'phase';
        output =  pos_unit(unitq);

end

end

