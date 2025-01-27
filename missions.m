function [m] = missions (GTOW, Ltime, Wmax, Ltime_max, Nlaps, Nlaps_max)


RequiredNumofLaps = 3;
MissionTimeLimit = 5;
MU_BonusScore = 3; % our bonus score (this is box score divided by x-1 vechile weight)
Best_BonusScore = 10; % best team's bonus score (this is box score divided by x-1 vechile weight)

% Missions
% --------------------------
% mission 1 = just fly
% mission 2 = most weight
% mission 3 = fastest lap

if (RequiredNumofLaps*Ltime) < (MissionTimeLimit*60)
    M1 = 1; % complete all laps, 5 mins
else
    M1 = 0;
end

M2 = 1+((GTOW)/(RequiredNumofLaps*Ltime))/((Wmax)/(Ltime_max));
M3 = 2+(Nlaps +MU_BonusScore) / (Nlaps_max + Best_BonusScore);
if M2 > 2
    M2 = 2;
end
if M3 > 3
    M3 =3; 
end
m = (M1+M2+M3);