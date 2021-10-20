function plotting(X,Y,H,T,ANGLES,Cl,Cd,Time,v,S,W)

% Density evolution
for i = 1:length(H)
    rho(i,1) = atmos(H(i));
end

% Trajectory plotting
figure('Name','Trajectory')
plot3(X/1000,Y/1000,H*3.28084), grid on
title('Maneuver Trajectory')
xlabel('Horizontal Position [km]')
ylabel('Lateral Position [km]')
zlabel('Height [ft]')

% Aerodynamic coefficients and forces
figure('Name','Aerodynamic Coefficients')
yyaxis left
plot(Time,Cl)
ylabel('Lift Coefficient')
yyaxis right
plot(Time,Cd), grid on
ylabel('Drag Coefficient')
legend('Cl','Cd')
title('Aerodynamic Coefficients')
xlim([0 Time(end)])
xticks([0, linspace(Time(end)/16, Time(end)-Time(end)/16, 7), Time(end)]);
xticklabels({'t_0','Asc.','Cruise','Desc.','Asc. Rec.', ...
    'Straight Rec.','Turning','Desc. Rec.','t_{max}'})
xlabel('Flight segment')

% Velocity
figure('Name','Velocity')
plot(Time,v*3.6), grid on
title('Velocity')
ylabel('v [km/h]')
xlim([0 Time(end)])
xticks([0, linspace(Time(end)/16, Time(end)-Time(end)/16, 7), Time(end)]);
xticklabels({'t_0','Asc.','Cruise','Desc.','Asc. Rec.', ...
    'Straight Rec.','Turning','Desc. Rec.','t_{max}'})
xlabel('Flight segment')

% Forces
figure('Name','Forces')
yyaxis left
plot(Time,0.5*rho.*v.^2*S.*Cl,'-')
grid on
ylabel('Lift [N]')
title('Forces over the plane')
yyaxis right
plot(Time,T,'m'), hold on;
plot(Time,0.5*rho.*v.^2*S.*Cd,'-')
ylabel('Drag & Thrust [N]')
legend('L','T','D')
xlim([0 Time(end)])
xticks([0, linspace(Time(end)/16, Time(end)-Time(end)/16, 7), Time(end)]);
xticklabels({'t_0','Asc.','Cruise','Desc.','Asc. Rec.', ...
    'Straight Rec.','Turning','Desc. Rec.','t_{max}'})
xlabel('Flight segment')

% Longitudinal equilibrium angles
figure('Name','Longitudinal angles')
yyaxis left
plot(Time,ANGLES(:,3)*180/pi), grid on
title('Longitudinal Angles')
ylabel('Elevator Angle [º]')
yyaxis right
plot(Time,ANGLES(:,1)*180/pi)
ylabel('Attack Angle [º]')
legend('\delta_e','\alpha')
xlim([0 Time(end)])
xticks([0, linspace(Time(end)/16, Time(end)-Time(end)/16, 7), Time(end)]);
xticklabels({'t_0','Asc.','Cruise','Desc.','Asc. Rec.', ...
    'Straight Rec.','Turning','Desc. Rec.','t_{max}'})
xlabel('Flight segment')

% Lateral equilibrium angles
figure('Name','Lateral-directional angles')
plot(Time,ANGLES(:,2)*180/pi), hold on
plot(Time,ANGLES(:,4)*180/pi), hold on
plot(Time,ANGLES(:,5)*180/pi), grid on
title('Lateral-directional angles')
legend('\beta','\delta_a','\delta_r')
ylabel('Degrees [º]')
xlim([0 Time(end)])
xticks([0, linspace(Time(end)/16, Time(end)-Time(end)/16, 7), Time(end)]);
xticklabels({'t_0','Asc.','Cruise','Desc.','Asc. Rec.', ...
    'Straight Rec.','Turning','Desc. Rec.','t_{max}'})
xlabel('Flight segment')

% Load factor
figure('Name','Load Factor')
plot(Time,0.5*rho.*v.^2*S.*Cl/W), grid on
title('Load Factor')
ylabel('n [L/W]')
xlim([0 Time(end)])
xticks([0, linspace(Time(end)/16, Time(end)-Time(end)/16, 7), Time(end)]);
xticklabels({'t_0','Asc.','Cruise','Desc.','Asc. Rec.', ...
    'Straight Rec.','Turning','Desc. Rec.','t_{max}'})
xlabel('Flight segment')

end