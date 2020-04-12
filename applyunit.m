function this = applyunit(unit_fig,this)

newunit_index =  flipud(get(unit_fig.findobj('Style','popup'),'Value'));
pos = flipud(get(unit_fig.findobj('Style','popup'),'String'));
f = fieldnames(this.unit);

mean(this.x)
for i=1:length(f)
    % change string
    new_unit{i} = pos{i}{newunit_index{i}};
    
    old_unit = getfield(this.unit,f{i});
    convert_factor{i} = convertunit(unit2unitq(old_unit),old_unit,new_unit{i});
    new_value{i} = getfield(this,f{i})*convert_factor{i};
    this = setfield(this,f{i},new_value{i});
    
end

% apply new unit
this.unit = cell2struct(new_unit',f);


end
