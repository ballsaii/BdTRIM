classdef PARMELAdis
    properties
        phase
    end
    
    %%______________________________________________________________________
    %                 data_array
    %
    %                 data_array =
    %
    %                   struct with fields:
    %
    %                     path: 'D:\BdTRIM\PHASESPACE.TXT'
    %                     data: {[1×1 struct]  [1×1 struct]}
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
    %                                   data: [350000×7 double]
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
    %                         data: {1×10 cell}
    %%______________________________________________________________________
    %                     data_array.data{i=1:10}
    %
    %                     ans =
    %
    %                       struct with fields:
    %
    %                                  ref_phase: 162
    %                         numberparticle: 105184
    %                                   data: [105184×8 double]
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
            
            % relative z,pz,time to absolute value
            obj.phase  = parmeladist.ref_phase + parmeladist.data(:,5);
            
             % assign to obj
            obj.x = parmeladist.data(:,1);
            obj.unit.x = 'cm';
            obj.y = parmeladist.data(:,3);
            obj.unit.y = 'cm';

            switch size(parmeladist.data,2)
                case 7
                    xp = parmeladist.data(:,2);
                    yp = parmeladist.data(:,4);
                case 8
                    xp = parmeladist.data(:,2);
                    yp = parmeladist.data(:,4);
            end
            obj.xp = xp;
            obj.unit.xp = 'mrad';
            obj.yp = yp;
            obj.unit.yp = 'mrad';
            
            obj.pz = pz;
            obj.unit.pz = 'eV/c';
            obj.time = time;
            obj.unit.time = 'ns';

            
        end
        
    end
end


