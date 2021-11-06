function lever_force(TAB,COEFF,H,V,Time,DELTA_T,VEL,N)

% Assignation of vector TAB
G = TAB(1);
Ch_0 = TAB(2);
Ch_alpha_wb = TAB(3); 
Ch_delta_e = TAB(4); 
Ch_delta_t = TAB(5);
eta_t = TAB(6);
Se = TAB(7);
ce = TAB(8);
W = TAB(9);
S = TAB(10);
iwb = TAB(11);
it = TAB(12);

% Coefficients assignation
CL_alpha_wb = COEFF(1,2);
Cm_alpha_wb = COEFF(2,2);
Cm_delta_e = COEFF(2,3);
Cm_alpha_f = Cm_alpha_wb-Cm_delta_e/Ch_delta_e*Ch_alpha_wb;

% Symbolic parameters
syms F F_eq alpha_wb delta_e delta_t rho v

% Lever force equation coefficients
A_ = Ch_0 + Ch_alpha_wb*iwb + Ch_delta_e*(it-Cm_alpha_wb/Cm_delta_e*iwb);
A  = G*Se*ce*eta_t* W/(S*CL_alpha_wb) * (Ch_delta_e/Cm_delta_e)*Cm_alpha_f;
B  = G*Se*ce*eta_t*(A_ + Ch_delta_t*delta_t);

% Lever force symbolic equation
F_eq = A + 0.5*rho*v^2*B;

% Calculation
for i = 1:length(H)
    % Vector of force
    F(i,1) = subs( F_eq, [rho, v], [atmos(H(i)), V(i)] );
   
    % Calculation of 0 force tab deflection angle
    TRIM_tab_angle(i,1) = solve(F(i,1) == 0, delta_t);
end

% Plotting of the 0 force tab deflection angle
figure('Name','Trim Condition')
plot(Time,double(TRIM_tab_angle)*180/pi), grid on
title('No-Force TAB Deflection Angle')
ylabel('TAB Deflection Angle [deg]')
xlim([0 Time(end)])
xticks([0, linspace(Time(end)/16, Time(end)-Time(end)/16, 7), Time(end)]);
xticklabels({'t_0','Asc.','Cruise','Desc.','Asc. Rec.', ...
    'Straight Rec.','Turning','Desc. Rec.','t_{max}'})
xlabel('Flight segment')

% Cruise flight LEVER-FORCE diagram
figure('Name','Cruise LEVER-FORCE')
for i = 1:length(DELTA_T)
    F_eq_cr = subs(F_eq, [rho, delta_t], [atmos(H(N+1)), DELTA_T(i)*pi/180] );
    ezplot(F_eq_cr,VEL/3.6), hold on
    legend_str(i,:) = convertCharsToStrings(['\delta_t = ' num2str(DELTA_T(i)) '^\circ']);
end
title('Lever force diagram for cruise condition')
xlabel('Velocity [km/h]')
ylabel('Lever Force [N]')
legend(legend_str,'location','northwest')
grid on
set(gca,'XTick', linspace(VEL(1)/3.6,VEL(2)/3.6,10))
set(gca,'XTickLabel', round(linspace(VEL(1),VEL(2),10),0))

end