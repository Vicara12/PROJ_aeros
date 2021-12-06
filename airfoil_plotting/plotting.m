function plotting(v)

% DATA MATRIX columns
%  alpha     CL        CD       CDp       Cm    Top Xtr Bot Xtr   Cpmin    Chinge    XCp    

set(0,'defaulttextInterpreter','latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');

% Legend string
V = strrep(v,'_','\_');

% CL PLOT
figure('Name','Lift coefficient')
for i = 1:length(v)
    DATA = load(v(i));
    alpha = DATA(:,1);
    CL = DATA(:,2);
    plot(alpha,CL), hold on
end
title('\textbf{Lift coefficient}'), grid on
legend(V,'Location','southeast','FontSize',7)
xlabel('$\alpha [^\circ]$'), ylabel('$C_l$')

% Legend for the flap plot
legend('FLAP: $-15^\circ$', 'FLAP:  $-7^\circ$', 'FLAP:  $0^\circ$', ...
    'FLAP:  $+7^\circ$', 'FLAP:  $+15^\circ$', 'Location','southeast','FontSize',7)

% CD PLOT
figure('Name','Drag coefficient')
for i = 1:length(v)
    DATA = load(v(i));
    CL = DATA(:,2);
    CD = DATA(:,3);
    plot(CL,CD), hold on
end
title('\textbf{Drag coefficient}'), grid on
legend(V,'Location','northwest','FontSize',7)
xlabel('$C_l$'), ylabel('$C_d$')

% CM PLOT
figure('Name','Torque coefficient')
for i = 1:length(v)
    DATA = load(v(i));
    alpha = DATA(:,1);
    Cm = DATA(:,5);      
    plot(alpha,Cm), hold on
end
title('\textbf{Pitch torque coefficient}'), grid on
legend(V,'Location','northwest','FontSize',7)
xlabel('$\alpha [^\circ]$'), ylabel('$C_m$')

end