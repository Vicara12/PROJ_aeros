function plotting(v)

% DATA MATRIX columns
%  alpha     CL        CD       CDp       Cm    Top Xtr Bot Xtr   Cpmin    Chinge    XCp    

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
title('Lift coefficient'), grid on
legend(V,'Location','southeast','FontSize',7)
xlabel('\alpha [º]'), ylabel('C_L')

% CD PLOT
figure('Name','Drag coefficient')
for i = 1:length(v)
    DATA = load(v(i));
    CL = DATA(:,2);
    CD = DATA(:,3);
    plot(CL,CD), hold on
end
title('Drag coefficient'), grid on
legend(V,'Location','northwest','FontSize',7)
xlabel('C_L'), ylabel('C_D')

% CM PLOT
figure('Name','Torque coefficient')
for i = 1:length(v)
    DATA = load(v(i));
    alpha = DATA(:,1);
    Cm = DATA(:,5);      
    plot(alpha,Cm), hold on
end
title('Pitch torque coefficient'), grid on
legend(V,'Location','northwest','FontSize',7)
xlabel('\alpha [º]'), ylabel('C_m')

end