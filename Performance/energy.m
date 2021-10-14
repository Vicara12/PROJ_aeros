function [E] = energy(T,V,Time)

% Calculation
E_trapz = trapz(Time,T.*V);

% From J to kWh
E = E_trapz/(1000*3600); % kWh

end