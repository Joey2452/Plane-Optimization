
function [c, ceq] = constraints(x)


Wingspan = x(1);
ChordLength = x(2);
GTOW = x(3);
Cl = x(4);

MI = masterinput(Wingspan,ChordLength, GTOW, Cl);

%GAMULTIOBJ May violate these bounds SLIGHTLY, if it violates it more than
%that, there is an issue in the code OR the constraints are too tight.
%Loosen the constraints or change your objective

c(1) = -(MI.AR)+5; % Minimum desired aspect ratio
c(2) = MI.VMax_possible - 240;
c(3) = GTOW - MI.TakeoffL; %Forces GTOW to be a function of lift

ceq = [];

end
