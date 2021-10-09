function [rho,P,T,a] = atmos(h)

% U.S. Standard atmosphere variables
R = 287.053;    gamma = 1.4;

% Temperature
a1 = -6.5e-3;   a2 = 1e-3;  a3 = 2.8e-3;  a4 = -2.8e-3;   a5 = -2e-3;

if h<=11000
    T = 288.16+a1*h;
elseif h>11000 && h<=20000
    T = 216.66;
elseif h>20000 && h<=32000  
    T = 196.65+a2*h;
elseif h>32000 && h<=47000
    T = 139.05+a3*h;
elseif h>47000 && h<=51000
    T = 270.65;
elseif h>51000 && h<=71000
    T = 413.45+a4*h;
elseif h>71000 && h<=84852
    T = 356.65+a5*h;
else 
    T = 186.946;
end

% Pressure
if h<=11000
    % Troposphere
    P = 101325.0*(288.15/(288.15-6.5*h/1000))^(-34.1632/6.5);
elseif h>11000 && h<=20000
    % Lower Stratosphere
    P = 22632.06*exp(-34.1632e-3*(h-11000)/216.65);
elseif h>20000 && h<=32000  
    % Middle Stratosphere
    P = 5474.889*(216.65/(216.65+(h/1000-20)))^(34.1632);
elseif h>32000 && h<=47000
    % Upper Stratosphere
    P = 868.0187*(228.65/(228.65+2.8e-3*(h-32000)))^(34.1632/2.8);
elseif h>47000 && h<=51000
    % Lower Mesosphere
    P = 110.9063*exp(-34.1632*(h/1000-47)/270.65);
elseif h>51000 && h<=71000
    % Middle Mesossphere
    P = 66.93887*(270.65/(270.65-2.8*(h/1000-51)))^(-34.1632/2.8);
elseif h>71000 && h<=85000
    % Upper Mesosphere
    P = 3.956420*(214.65/(214.65-2*(h/1000-71)))^(-34.1632/2);
else
    P = 0;
end

% Density and speed of sound
rho = P/(R*T);
a = sqrt(gamma*R*T);

end