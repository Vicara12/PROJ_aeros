%--------------------------------------------------------------------------
%                   PEA - FLIGHT PERFORMANCE ANALYSIS
%                   AUTHORS: Aerodynamics department 
%          fran.14hg@gmail.com, MARTA@gmail.com, VÍCTOR@gmail.com
%--------------------------------------------------------------------------
%% MAIN
clc, clear all, close all

%% ------------------------------------------------------------------------
%                               1. INPUT
%           User definition of the different solver's inputs
%--------------------------------------------------------------------------

% 1.1. Geometry parameters
b   = 11;                 % Wing span [m]
c   = 1.2;                % MAC [m]
S   = 16.2;               % Wing surface [m^2]
St  = 12;                 % Horizontal tail surface [m^2]
Sv  = 8;                  % Vertical tail surface [m^2]
lt  = 5;                  % Distance from CM to tail (= lv) [m]
hv  = 1;                  % Height vertical stabilizer [m]

% 1.2. Aerodynamic parameters
iwb = 0.05;               % LSN angle, wing+body [rad]
it  = 0.05;               % LSN angle, tail [rad]
awb = 2*pi;               % Lift slope wing+body [rad^-1]
at  = 2*pi;               % Lift slope tail horizontal [rad^-1]
av  = 2*pi;               % Lift slope tail vertical [rad^-1]
tau_e = 3.25;             % Elevator efficiency [rad^-1]
tau_a = 3.25;             % Ailerons efficiency [rad^-1]
tau_v = 3.25;             % Rudder efficiency [rad^-1]
Cmacwb = 0.1;             % Wing+body free moment coefficient [ad]
eta_t = 0.95;             % Horizontal wind relation (vt/v)^2 [ad]
eta_v = 0.95;             % Vertical wind relation (v_v/v)^2  [ad]

% 1.3. Configuration parameters
xcg = 4;                  % Gravity center position (from cockpit), [ad] (MAC)
xacwb = 5;                % Wing+body aerod. center position (from cockpit), [ad] (MAC)

% 1.4. Interference parameters
eps0 = 0.1;               % Reference epsilon [rad]
epsDalpha = 0.1;          % Epsilon over alpha derivative [ad]
sigmaDbeta = 0.1;         % Sigma over beta derivative [ad]

%% ------------------------------------------------------------------------
%                             2. CALCULUS
%        Aerodynamic coefficients calculation and performance analysis
%--------------------------------------------------------------------------

% 2.1. Vector of the parameters
vect = [b, c, S, St, Sv, lt, hv, iwb, it, awb, at, av, tau_e, ...
    tau_a, tau_v, Cmacwb, eta_t, eta_v, xcg, xacwb, eps0, epsDalpha, sigmaDbeta];

% 2.2. Aerodynamic coefficients calculation
[COEFF] = aerod_coeff(vect);

% 2.3. Blablabla test pull
