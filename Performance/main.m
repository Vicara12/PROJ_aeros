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

% 1.1. Flight parameters
m = 2000;                 % Mass [kg]
Ixx = 1100;               % Plane inertia in x direction [kg*m^2]
v0 = 100/3.6;               % Initial velocity [m/s]
g = 9.81;                 % Gravity [N/kg]

% 1.2. Geometry parameters
b   = 11;                 % Wing span [m]
c   = 1.2;                % MAC [m]
S   = 16.2;               % Wing surface [m^2]
St  = 12;                 % Horizontal tail surface [m^2]
Sv  = 8;                  % Vertical tail surface [m^2]
lt  = 5;                  % Distance from CM to tail (= lv) [m]
hv  = 1;                  % Height vertical stabilizer [m]

% 1.3. Aerodynamic parameters
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
Cd0 = 0.012;              % Parasit drag coefficient [ad]
k = 0.015;                % Induced drag coefficient [ad]

% 1.4. Configuration parameters
xcg = 4;                  % Gravity center position (from cockpit), [ad] (MAC)
xacwb = 5;                % Wing+body aerod. center position (from cockpit), [ad] (MAC)

% 1.5. Interference parameters
eps0 = 0.1;               % Reference epsilon [rad]
epsDalpha = 0.1;          % Epsilon over alpha derivative [ad]
sigmaDbeta = 0.1;         % Sigma over beta derivative [ad]

% 1.6. Numerical parameters
N = 1000;                 % Time discretization [ad]

% 1.7. Trajectory BC parameters
t12 = 50;                 % Time step position 1-2 [sec]
T12 = 10000;               % Thrust position 1-2 [N]
gamma12 = 1*pi/180;       % Climb angle position 1-2 [rad]
acc12 = 1;                % STATIC [0] or DYNAMIC [1] flight

t23 = 50;                 % Time step position 2-3 [sec]
T23 = 10000;               % Thrust position 2-3 [N]
gamma23 = 0*pi/180;       % Climb angle position 2-3 [rad]
acc23 = 0;                % STATIC [0] or DYNAMIC [1] flight

%% ------------------------------------------------------------------------
%                             2. CALCULUS
%        Aerodynamic coefficients calculation and performance analysis
%--------------------------------------------------------------------------

% 2.1. Vector of the parameters
vect = [b, c, S, St, Sv, lt, hv, iwb, it, awb, at, av, tau_e, ...
    tau_a, tau_v, Cmacwb, eta_t, eta_v, xcg, xacwb, eps0, epsDalpha, sigmaDbeta];

% 2.2. Aerodynamic coefficients calculation
[COEFF] = aerod_coeff(vect);

% 2.3. Trajectory determination
% 2.3.1. Ascent Flight: POS 1-2
BC_12 = [0 0 v0]; 
gamma_12(1:N,1) = gamma12; time_12(1:N,1) = linspace(0,t12,N);
[x_12,h_12,v_12,Cl_12,Cd_12] = ...
    straight_flight(T12,g,S,Cd0,k,m*g,gamma12,1,1,time_12,acc12,BC_12);

% 2.3.2. Straight Flight: POS 2-3
BC_23 = [x_12(end), h_12(end), v_12(end)];
gamma_23(1:N,1) = gamma23; time_23(1:N,1) = linspace(0,t23,N);
[x_23,h_23,v_23,Cl_23,Cd_23] = ...
    straight_flight(T23,g,S,Cd0,k,m*g,gamma23,1,1,time_23,acc23,BC_23);

