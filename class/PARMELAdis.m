classdef PARMELAdis
    properties
        x
        y
        px
        py
        pz
        xp
        yp
        Ek
        phase
        unit
        
    end
    
    %%______________________________________________________________________
    %                 data_array
    %
    %                 data_array =
    %
    %                   struct with fields:
    %
    %                     path: 'D:\BdTRIM\PHASESPACE.TXT'
    %                     data: {[1�1 struct]  [1�1 struct]}
    %%______________________________________________________________________
    %                     data_array.data{i=1:2}
    %
    %                     ans =
    %
    %                       struct with fields:
    %
    %                         numberparticle: 350000
    %                                  ref_z: 0
    %                              ref_phase: 180.1180
    %                                   data: [350000�7 double]
    %
    %
    %                 Column	Parameter	Description
    %                 1	x	x coordinate in cm.
    %                 2	xp	x divergence coordinate in milliradians.
    %                 3	y	x coordinate in cm.
    %                 4	yp	x divergence coordinate in milliradians.
    %                 5	phase	Phase coordinate in degrees
    %                 6	W	Energy in MeV
    %                 7	n	Particle number.
    %%______________________________________________________________________
    %%______________________________________________________________________
    %                     data_array =
    %
    %                       struct with fields:
    %
    %                         path: 'D:\BdTRIM\TAPE3.txt'
    %                         data: {1�10 cell}
    %%______________________________________________________________________
    %                     data_array.data{i=1:10}
    %
    %                     ans =
    %
    %                       struct with fields:
    %
    %                                  ref_phase: 162
    %                         numberparticle: 105184
    %                                   data: [105184�8 double]
    %
    %                 Table IV-4. Contents of file named by TimeStepOutName.
    %                 Column	Parameter	Description
    %                 1	x	x coordinate in cm.
    %                 2	(bg)x	Dimensionless momentum in x direction.
    %                 3	y	x coordinate in cm.
    %                 4	(bg)y	Dimensionless momentum in y direction.
    %                 5	z	Phase coordinate in degrees
    %                 6	(bg)z	Dimensionless momentum in z direction.
    %                 7	ParticleType	Particle species.
    %                 8	Charge	Electric charge of the particle.
    %%______________________________________________________________________
    methods
        function obj = PARMELAdis(parmeladist)
            
            switch size(parmeladist.data,2)
                case 8
                    % filter NAN out
                    
                    raw = parmeladist.data((all((~isnan(parmeladist.data)),2)),:);
                    % relative z,pz,time to absolute value
                    phase  = parmeladist.ref_phase + raw(:,5);
                    
                    %
                    x = raw(:,1);
                    y = raw(:,3);
                    
                    
                    bgx = raw(:,2);
                    bgy = raw(:,4);
                    bgz = raw(:,6);
                    
                    px = betagamma2p(bgx);
                    py = betagamma2p(bgy);
                    pz = betagamma2p(bgz);
                    
                    ptotal = sqrt(px.^2+py.^2+pz.^2);
                    
                    Ek = p2E(ptotal);
                    
                    xp = atan(px./pz)*1000;
                    yp = atan(px./pz)*1000;
                    
                    % assign
                    obj.x = x;
                    obj.y = y;
                    obj.px = px;
                    obj.py = py;
                    obj.pz = pz;
                    obj.xp = xp;
                    obj.yp = yp;
                    obj.Ek = Ek;
                    obj.phase = phase;
                    
                    obj.unit.x = 'cm';
                    obj.unit.y = 'cm';
                    obj.unit.px = 'eV/c';
                    obj.unit.py = 'eV/c';
                    obj.unit.pz = 'eV/c';
                    obj.unit.xp = 'mrad';
                    obj.unit.yp = 'mrad';
                    obj.unit.Ek = 'MeV';
                    obj.unit.phase = 'degree';
                    
                case 7
                    % relative z,pz,time to absolute value
                    raw = parmeladist.data;
                    phase  = parmeladist.ref_phase + raw(:,5);
                    
                    %
                    x = raw(:,1);
                    y = raw(:,3);
                    
                    xp = raw(:,2);
                    yp = raw(:,4);
                    
                    Ek = raw(:,6);
                    
                    % assign
                    obj.x = x;
                    obj.y = y;
                    obj.xp = xp;
                    obj.yp = yp;
                    obj.phase = phase;
                    obj.Ek = Ek;
                    
                    obj.unit.x = 'cm';
                    obj.unit.y = 'cm';
                    obj.unit.xp = 'mrad';
                    obj.unit.yp = 'mrad';
                    obj.unit.Ek = 'MeV';
                    obj.unit.phase = 'degree';
            end
            
        end
        
    end
end


