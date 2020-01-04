function unitq = unit2unitq(unit)
% classify unit to unitq

if ismember(unit,pos_unit('length'))
    unitq = 'length';
elseif ismember(unit,pos_unit('momentum'))
    unitq = 'momentum';
elseif ismember(unit,pos_unit('divergent'))
    unitq = 'divergent';
elseif ismember(unit,pos_unit('time'))
    unitq = 'time';
elseif ismember(unit,pos_unit('energy'))
    unitq = 'energy';
elseif ismember(unit,pos_unit('charge'))
    unitq = 'charge';
else
    unitq = 'none';
end

end

