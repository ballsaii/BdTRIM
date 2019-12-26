function setunit(unit)
%% convert unit
switch unit
    case 'x'
    case 'y'
    case 'z'
    case 'px'
    case 'py'
    case 'pz'
    case 'xp'
    case 'yp'
    case 'Ek'    
    case 'charge'
    case 'time'
    case 'time2'
    case 'index'
    case 'flag'
    case 'unit'

end
unit_GUI.Children.findobj('Tag','pop_length').String = objbeam.unit.x;
unit_GUI.Children.findobj('Tag','pop_divergence').String = objbeam.unit.x;

objbeam
end

