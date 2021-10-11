function [x,y,h,Xi,v,CL,Cd,mu,R,Xi_p] = turn_equations(time,vect,BC)

% Input assignation
T = vect(1);
Cd0 = vect(2);
K = vect(3);
Xi_p = vect(4); % Desired turn rate [rad/s]
rho = vect(5);
S = vect(6);
g = vect(7);
v = BC(3);

% Analytical equations resolution
Cd = T/(1/2*rho*v^2*S);
CL = sqrt((Cd-Cd0)/K);

% ICAO NORMATIVE
% Turn at 3º/sec or 25 bank angle, the one with lesser bank
R = v/Xi_p;
mu = atan(Xi_p^2*R/g);

if mu*180/pi > 25
    mu = 25/180*pi;
    Xi_p = tan(mu)*g/v;
    R = v/Xi_p;
end    
    
% Create vectors
Xi(:,1) = Xi_p.*time;
CL(1:length(time),1) = CL;
Cd(1:length(time),1) = Cd;
v(1:length(time),1)  = v;
h(1:length(time),1)  = BC(2);
x = R*sin(Xi) + BC(1);
y = R.*(cos(Xi) - 1);

end