function applyunit(unit_fig,this)

% get new unit string
popup_newunit = unit_fig.findobj('Style','popup');
tag_newunit =  get(popup_newunit,'Tag');

% extract unit qualtity
newunit_q = cellfun(@(nu) textscan(nu, 'popup_%s'),tag_newunit);
newunit_string = cellfun(@(nu) unit_fig.findobj('Tag',nu).String{unit_fig.findobj('Tag',nu).Value},tag_newunit,'UniformOutput',0);

for i=1:length(newunit_string)
    setfield(this.unit,newunit_q{i}{1},newunit_string{i})
end
end
