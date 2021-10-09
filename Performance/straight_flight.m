function [x,h,v,Cl,Cd] = straight_flight(rho,T,g,S,Cd0,k,W,gamma,UP,right,time,BC)

% Solve differential equation system
%X(1) = x, X(2) = h, X(3) = v

if right == 1
    f = @(tv,X) [ X(3)*cos(gamma);
        X(3)*sin(gamma);
        g/W*(T-0.5*rho*X(3)^2*S*(Cd0+k*(-W.*cos(gamma) ./ (0.5*rho*X(3)^2*S))^2) - W*sin(gamma))];
elseif right == 0
    f = @(tv,X) [ -X(3)*cos(gamma);
        X(3)*sin(gamma);
        g/W*(T-0.5*rho*X(3)^2*S*(Cd0+k*(-W.*cos(gamma) ./ (0.5*rho*X(3)^2*S))^2) - W*sin(gamma))];
end

[t,X]=ode45(f,time,BC);
x(:,1) = X(:,1);
h(:,1) = X(:,2);
v(:,1) = X(:,3);

% Cl calculation
if UP == 1
    Cl(:,1) = W.*cos(gamma) ./ (0.5*rho.*v.^2*S);
elseif UP == 0
    Cl(:,1) = -W.*cos(gamma) ./ (0.5*rho.*v.^2*S);
end

% Cd and thrust calculation
Cd(:,1) = Cd0+k.*Cl.^2;

end