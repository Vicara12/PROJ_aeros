clc, clear all, close all
set(0,'defaulttextInterpreter','latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');

% Input
data_COM = importdata("CM_WING.txt");
data_POL = importdata("POLARS_WING.txt");

% Data management
data_COM = data_COM.data;
data_POL = data_POL.data;

% Lift coefficient plot
figure(1)
subplot(1,3,1)
plot(data_POL(:,1),data_POL(:,3))
title('\textbf{Wing - Lift coefficient}')
xlabel('$\alpha$ [$^\circ$]')
ylabel('$C_L$')
grid on

% Drag coefficient plot
p = polyfit(data_POL(:,3),data_POL(:,6),2);
syms x
subplot(1,3,2)
fplot(p(1)*x^2 + p(2)*x + p(3))
title('\textbf{Wing - Polar curve}')
xlabel('$C_L$')
ylabel('$C_D$')
xlim([-1.5 +1.5])
ylim([0 0.14])
grid on

% Cm plot
subplot(1,3,3)
plot(data_COM(:,1),data_COM(:,2)), hold on
plot(data_COM(:,3),data_COM(:,4)), hold on
plot(data_COM(:,5),data_COM(:,6)), hold on
plot(data_COM(:,7),data_COM(:,8)), hold on
plot(data_COM(:,11),data_COM(:,12)), hold on
plot(data_COM(:,9),data_COM(:,10)), hold on

title('\textbf{Wing - Moment coefficient}')
xlabel('$\alpha$ [$^\circ$]')
ylabel('$C_M$')
grid on
legend('$x_{COM} = 0.00\;m$', '$x_{COM} = 0.10\;m$', ...
    '$x_{COM} = 0.20\;m$', '$x_{COM} = 0.30\;m$', ...
    '$x_{COM} = 0.40\;m$', '$x_{COM} = 0.42\;m$', ...
    'location', 'southwest')

