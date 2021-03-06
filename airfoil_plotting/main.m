clc, clear all, close all

% PATH
addpath('./export')

% INPUT
NACA2312 = ["NACA 2312_T1_Re1.700_M0.00_N9.0.txt", "NACA 2312_T1_Re2.700_M0.00_N9.0.txt", ...
    "NACA 2312_T1_Re3.700_M0.00_N9.0.txt", "NACA 2312_T1_Re4.700_M0.00_N9.0.txt", ...
    "NACA 2312_T1_Re5.700_M0.00_N9.0.txt", "NACA 2312_T1_Re6.700_M0.00_N9.0.txt", ...
    "NACA 2312_T1_Re7.700_M0.00_N9.0.txt", "NACA 2312_T1_Re8.700_M0.00_N9.0.txt", ...
    "NACA 2312_T1_Re9.700_M0.00_N9.0.txt"];

NACA0010 = ["NACA 0010_T1_Re1.700_M0.00_N9.0.txt", "NACA 0010_T1_Re2.700_M0.00_N9.0.txt", ...
    "NACA 0010_T1_Re3.700_M0.00_N9.0.txt", "NACA 0010_T1_Re4.700_M0.00_N9.0.txt", ...
    "NACA 0010_T1_Re5.700_M0.00_N9.0.txt", "NACA 0010_T1_Re6.700_M0.00_N9.0.txt", ...
    "NACA 0010_T1_Re7.700_M0.00_N9.0.txt", "NACA 0010_T1_Re8.700_M0.00_N9.0.txt", ...
    "NACA 0010_T1_Re9.700_M0.00_N9.0.txt"];

NACA2312_FLAP = ['NACA 2312 flap -15_T1_Re1.700_M0.00_N9.0.txt', 'NACA 2312 flap -7_T1_Re1.700_M0.00_N9.0.txt', ...
    "NACA 2312_T1_Re1.700_M0.00_N9.0.txt", 'NACA 2312 flap 7_T1_Re1.700_M0.00_N9.0.txt', ...
    'NACA 2312 flap 15_T1_Re1.700_M0.00_N9.0.txt'];
    
NACA0010_FLAP = ["NACA 0010 flap -15_T1_Re5.000_M0.00_N9.0.txt", 'NACA 0010 flap -7_T1_Re5.000_M0.00_N9.0.txt', ...
     'NACA 0010_T1_Re4.700_M0.00_N9.0.txt', 'NACA 0010 flap 7_T1_Re5.000_M0.00_N9.0.txt', ...
     'NACA 0010 flap 15_T1_Re5.000_M0.00_N9.0.txt'];

RUDDER = ["rudder_0.txt", "rudder_7.txt"]; 
 
%[Cl_coeffs, Cd_coeffs, avg_cm] = getAirfoilData(NACA0010(1), -5, 15);
 
% Efficiency calculation
tau_2312 = flap_efficiency(NACA2312_FLAP, 30, -5:10);
tau_0010 = flap_efficiency(NACA0010_FLAP, 30, -5:10);
tau_r    = rudder_efficiency(RUDDER, 7, 3:15);

% Plotting function
%plotting(NACA2312)
%plotting(NACA0010)
plotting(NACA2312_FLAP)
plotting(NACA0010_FLAP)
%plotting_rudder(RUDDER)
