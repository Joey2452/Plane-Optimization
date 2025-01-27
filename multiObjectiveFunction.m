function f = multiObjectiveFunction(x)
    Wingspan = x(1);
    ChordLength = x(2);
    GTOW = x(3);
    Cl = x(4);

    MI = masterinput(Wingspan,ChordLength,GTOW,Cl);

    %Penalty allows me to weight a constraint as an optimization function.
    %This essentially tells the program that a VStall over 55 makes the
    %resulting function significantly less valuable to me
    %The program will get around this by violating the penalty
    %SIGNIFICANTLY to make up the value

    %If the program violates these, it's telling you that it's "worth it"
    %to violate it
    if MI.VStall > 55
        penalty=1e20*(MI.VStall-55);
    else
        penalty=0;
    end


    S = MI.S; % Wing area
    K = MI.K; % Induced drag coeff
    Tr = MI.Tr;
    WMax=MI.WMax;
    Ltime = MI.LTime; 
    Ltime_max = MI.Ltime_max; % best score based
    Nlaps = MI.Nlaps; % num of laps in 5 mins, competition based
    Nlaps_max = MI.Nlaps_max; % see above ^


    [m] = missions (GTOW, Ltime, WMax, Ltime_max, Nlaps, Nlaps_max);
    
    f(1)=MI.VStall+penalty;
    f(2)=-m;
    f(3)=-GTOW;
    



    
    


end
