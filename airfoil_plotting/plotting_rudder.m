function plotting_rudder(v)

% DATA MATRIX columns
% alpha      CL          ICd        PCd        TCd        CY        Cm         Rm         Ym       IYm       QInf        XCP

% Legend string
V = strrep(v,'_','\_');

% CL PLOT
figure('Name','Lift coefficient')
for i = 1:length(v)
    DATA = load(v(i));
    alpha = DATA(:,1);
    CL = DATA(:,6);
    plot(alpha,CL), hold on
end
title('Rudder side force coefficient'), grid on
legend(V,'Location','southeast','FontSize',7)
xlabel('\alpha [º]'), ylabel('C_Y')

end

