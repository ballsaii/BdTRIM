function convert_factor = convertunit(unitq,unit_old,unit_new)

% create converting factor
f1 = convertu(unit_old);
f2 = convertu(unit_new);
convert_factor = f1/f2;

    function factor = convertu(unit)
        % find index in pos_unit
        test = strcmp(pos_unit(unitq),unit);
        unit_index = find(test==true);
        
        switch unitq
            case 'length'
                % {'cm','mm','um','nm','A'}
                v = [ 1E-2 1E-3 1E-6 1E-9 1E-10];
            case 'energy'
                % {'eV/c','keV/c','MeV/c'}
                v = [1 1E3 1E6];
            case 'time'
                % {'us','ns','ps'};
                v = [1E-6 1E-9 1E-12];
            case 'divergent'
                % {'mrad','rad'};
                v = [1E-3 1];
            case 'energy'
                % {'keV','MeV'};
                v = [1E3 1E6];
            case 'charge'
                % {'nC','pC'};
                v = [1E-9 1E-12];
        end
        factor = v(unit_index);
    end

end

