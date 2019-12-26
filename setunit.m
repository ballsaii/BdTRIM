function setunit(objbeam,unit_GUI)
%% convert unit
unit_GUI.Children.findobj('Tag','pop_length').String = objbeam.unit.x;
unit_GUI.Children.findobj('Tag','pop_divergence').String = objbeam.unit.x;

objbeam
end

