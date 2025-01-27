
function MI = masterinput(Wingspan,ChordLength,GTOW,Cl)

    
    
    [alpha_data, CL_data, CD_data, CDp_data] = loadAirfoilData('NACA4412.csv');
    
    MI.Wingspan = Wingspan;
    MI.ChordLength = ChordLength;
    MI.GTOW = GTOW;

    % Constants
    MI.AR = MI.Wingspan/MI.ChordLength; 
    MI.AvaTr = 24;           % Available Thrust (lb)
    MI.rho = 0.0023769;      % Air density @ ISA sea level (slugs/ft^3)
    MI.WMax = 55;            % Best team's aircraft weight (lb)
    MI.VMax = 500;           % Best team's aircraft speed (ft/s)
    MI.Llength = 2200;       % Current competition course length (ft)
    MI.M1time = 5;           % Number of minutes for first flight mission
    MI.minroll = 100;        % Maximum desired ground roll to achieve takeoff (ft)
    mu = 3.737e-7;           % Dynamic viscosity of air at sea level (slugs/(ft·s))
    Re = 1e5;                % Assumed reynolds number
    Clmax = 1.4298;          % Cl max based on polar file

    % Wing area
    MI.S = MI.Wingspan * MI.ChordLength; % Wing area (ft^2)


    % Find corresponding alpha for CL_target (interpolation might be needed)
    MI.alpha_target = interp1(CL_data, alpha_data, Cl, 'pchip', 'extrap');  % Linear interpolation

    % Find corresponding CDpressure for the given alpha_target
    CDpressure = interp1(alpha_data, CDp_data, MI.alpha_target, 'pchip', 'extrap');  % Linear interpolation for CD

    MI.K = (Cl^2)/(pi*0.8*MI.AR);  % Induced drag

    MI.VStall = sqrt((2 * MI.GTOW) / (MI.rho * MI.S * Clmax)); % Stall speed (ft/s)
    MI.VTakeoff = 1.2*(sqrt((2 * MI.GTOW) / (MI.rho * MI.S * Cl))); %Takeoff speed should be about 1.2 * stall speed

    


    % Lift and Drag calculations
    Cf = 0.074 / (Re^0.2); % Skin friction coefficient for turbulent flow
    MI.CD = CDpressure + Cf + MI.K;  % Total drag coefficient

    MI.VMax_possible = sqrt((2 * MI.AvaTr) / (MI.rho * MI.S * MI.CD)); % Maximum possible speed (ft/s)

    MI.L = 0.5 * MI.rho * MI.VMax_possible^2 * MI.S * Cl; % Lift produced @ VMax
    MI.D = 0.5 * MI.rho * MI.VMax_possible^2 * MI.S * MI.CD; % Drag produced @ VMax\
    MI.TakeoffL = 0.5 * MI.rho * (MI.VTakeoff^2) * MI.S * Cl; % Lift produced at takeoff
    MI.Tr = MI.AvaTr - MI.D; % Usable thrust

    % Time calculations
    MI.LTime = MI.Llength / MI.VMax_possible; % Best possible single lap time
    MI.Mtime = 6600 / MI.VMax_possible; % Minimum possible mission 1 time
    MI.Ltime_max = MI.Llength / MI.VMax; % Best team overall lap time
    MI.Nlaps = floor((MI.M1time * 60) / MI.LTime); % Number of laps in 5 mins, competition based
    MI.Nlaps_max = floor((MI.M1time * 60) / MI.Ltime_max); % Best team overall lap time
end




