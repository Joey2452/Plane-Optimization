clear;

% Load the results from gamultiobj
data = load('wingopt_results.mat');

% Access the x result and fval
x = data.x_opt;
fval = data.fval;

% Number of solutions (rows) from gamultiobj
numSolutions = size(x, 1);

% Preallocate cell array to hold tables for each solution
Tables = cell(numSolutions, 1);

% Loop through each solution (each row of x_opt)
for i = 1:numSolutions
    % Extract variables for the current solution
    Wingspan = x(i, 1);
    ChordLength = x(i, 2);
    GTOW = x(i, 3);
    Cl = x(i, 4);

    MI = masterinput(Wingspan,ChordLength,GTOW,Cl);
    
    % Constants
    CD=MI.CD;
    alpha_target=MI.alpha_target;
    AR=MI.AR;
    Wmax=MI.WMax;
    Ltime_max=MI.Ltime_max;
    LTime=MI.LTime;
    Nlaps=MI.Nlaps;
    Nlaps_max=MI.Nlaps_max;
    VStall=MI.VStall;
    VTakeoff=MI.VTakeoff;
    TakeoffL=MI.TakeoffL;
    VMax_possible=MI.VMax_possible;


    [m] = missions (GTOW, LTime, Wmax, Ltime_max, Nlaps, Nlaps_max);

    % Store the solution and measures in a table
    sol = [Wingspan; ChordLength; AR; GTOW; VStall; CD; VTakeoff; TakeoffL; LTime; Nlaps; alpha_target; Cl; VMax_possible; m];
    measure = {'Wingspan'; 'Chord Length'; 'Aspect Ratio'; 'gtow'; 'Vstall'; 'Drag Coeff'; 'Takeoff Speed'; 'Takeoff Lift'; 'Lap Time'; 'Number of Laps'; 'Alpha Target'; 'Lift Coefficient (Cl)'; 'Fastest Possible Speed'; 'total score'};

    % Create table for the current solution
    Tables{i} = table(measure, sol);
    
    % Display the table (optional, for debugging or comparison)
    disp(['Table for Solution ' num2str(i)]);
    disp(Tables{i});
end
