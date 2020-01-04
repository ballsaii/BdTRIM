function this = applyunit(unit_fig,this)

tag_newunit =  get(unit_fig.findobj('Style','popup'),'Tag');

% extract unitq from GUI
unitn = fieldnames(this);
new_unit = flip(cellfun(@(nu) unit_fig.findobj('Tag',nu).String{unit_fig.findobj('Tag',nu).Value},tag_newunit,'UniformOutput',0));
old_unit = struct2cell(this.unit);

% changing unit
that = this;
for i=1:length(old_unit)
this = this.unitconvert(unitn{i},old_unit{i},new_unit{i});
end
% for i=1:length(unitn)
%     % set new unit 
%     this.unit = setfield(this.unit,unitn{i}{1},new_unit{i});
%     
%     % change value
%     f1 = convertunit(setunitq(unitn{i}{1}),old_unit{i},new_unit{i});
% 
% end


% converting unit


end
