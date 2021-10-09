function [x,h,v,Cl,Cd] = straight_flight(T,g,S,Cd0,k,W,gamma,UP,right,time,acc,BC)

% Solve differential equation system
%X(1) = x, X(2) = h, X(3) = v

% Non-accelerated situation
if acc == 0
    if right == 1
        f = @(tv,X) [ X(3)*cos(gamma);
            X(3)*sin(gamma);
            0];
    elseif right == 0
        f = @(tv,X) [ -X(3)*cos(gamma);
            X(3)*sin(gamma);
            0];
    end
end

% Accelerated situation
if acc == 1
    if right == 1
        f = @(tv,X) [ X(3)*cos(gamma);
            X(3)*sin(gamma);
            g/W*(T-0.5*atmos(X(2))*X(3)^2*S*(Cd0+k*(-W.*cos(gamma) ./ (0.5*atmos(X(2))*X(3)^2*S))^2) - W*sin(gamma))];
    elseif right == 0
        f = @(tv,X) [ -X(3)*cos(gamma);
            X(3)*sin(gamma);
            g/W*(T-0.5*atmos(X(2))*X(3)^2*S*(Cd0+k*(-W.*cos(gamma) ./ (0.5*atmos(X(2))*X(3)^2*S))^2) - W*sin(gamma))];
    end
end

% ODE numerical resolution
[~,X]=ode45(f,time,BC);
x(:,1) = X(:,1);
h(:,1) = X(:,2);
v(:,1) = X(:,3);

% Density evolution
for i = 1:length(h)
    rho(i,1) = atmos(h(i));
end

% Cl calculation
if UP == 1
    Cl(:,1) = W.*cos(gamma) ./ (0.5.*rho.*v.^2*S);
elseif UP == 0
    Cl(:,1) = -W.*cos(gamma) ./ (0.5.*rho.^2*S);
end

% Cd calculation
Cd(:,1) = Cd0+k.*Cl.^2;

end