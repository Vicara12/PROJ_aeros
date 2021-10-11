%--------------------------------------------------------------------------
%                   PEA - FLIGHT PERFORMANCE ANALYSIS
%                   AUTHORS: Aerodynamics department 
%          fran.14hg@gmail.com, MARTA@gmail.com, VÃ?CTOR@gmail.com
%--------------------------------------------------------------------------
%% MAIN
clc, clear all, close all

%% ------------------------------------------------------------------------
%                               1. INPUT
%           User definition of the different solver's inputs
%--------------------------------------------------------------------------

% 1.1. Flight parameters
m = 2000;                 % Mass [kg]
v0 = 100/3.6;             % Initial velocity [m/s]
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
% TRAJ_XX = [ Maneuver time (sec) , Thrust (N), ...
%          Climb angle [rad], STATIC (0) or DYNAMIC (1) ]
traj_12 = [50,      5000,    2*pi/180,   1]; % Ascent flight
traj_23 = [50,      5000,    0*pi/180,   0]; % Straight flight
traj_34 = [50,      1000,   -2*pi/180,   1]; % Descent flight
traj_45 = [20,      5000,    2*pi/180,   1]; % Ascent recovery flight
traj_56 = [20,      1000,    0*pi/180,   1]; % Straight recovery flight
traj_67 = [45*60,   5000,    0*pi/180,   0]; % Waiting turn (ignore 4th comp)
traj_78 = [20,      1000,   -2*pi/180,   1]; % Descent recovery flight

%% ------------------------------------------------------------------------
%                             2. CALCULUS
%        Aerodynamic coefficients calculation and performance analysis
%--------------------------------------------------------------------------

% 2.1. Vector of the parameters
vect_coeff = [b, c, S, St, Sv, lt, hv, iwb, it, awb, at, av, tau_e, ...
    tau_a, tau_v, Cmacwb, eta_t, eta_v, xcg, xacwb, eps0, epsDalpha, sigmaDbeta];

% 2.2. Aerodynamic coefficients calculation
[COEFF] = aerod_coeff(vect_coeff);

% 2.3. Trajectory determination
% 2.3.1. Ascent Flight: POS 1-2
BC_12 = [0 0 v0]; 
gamma_12(1:N,1) = traj_12(3); time_12(1:N,1) = linspace(0,traj_12(1),N);
[x_12,h_12,v_12,CL_12,Cd_12] = ...
    straight_flight(traj_12(2),g,S,Cd0,k,m*g,traj_12(3),1,1,time_12,traj_12(4),BC_12);
y_12(1:N,1) = zeros(N,1);

% 2.3.2. Straight Flight: POS 2-3
BC_23 = [x_12(end), h_12(end), v_12(end)];
gamma_23(1:N,1) = traj_23(3); time_23(1:N,1) = linspace(0,traj_23(1),N);
[x_23,h_23,v_23,CL_23,Cd_23] = ...
    straight_flight(traj_23(2),g,S,Cd0,k,m*g,traj_23(3),1,1,time_23,traj_23(4),BC_23);
y_23(1:N,1) = zeros(N,1);

% 2.3.3. Descent Flight: POS 3-4
BC_34 = [x_23(end), h_23(end), v_23(end)];
gamma_34(1:N,1) = traj_34(3); time_34(1:N,1) = linspace(0,traj_34(1),N);
[x_34,h_34,v_34,CL_34,Cd_34] = ...
    straight_flight(traj_34(2),g,S,Cd0,k,m*g,traj_34(3),1,1,time_34,traj_34(4),BC_34);
y_34(1:N,1) = zeros(N,1);

% 2.3.4. Ascent Recovery Flight: POS 4-5
BC_45 = [x_34(end), h_34(end), v_34(end)];
gamma_45(1:N,1) = traj_45(3); time_45(1:N,1) = linspace(0,traj_45(1),N);
[x_45,h_45,v_45,CL_45,Cd_45] = ...
    straight_flight(traj_45(2),g,S,Cd0,k,m*g,traj_45(3),1,1,time_45,traj_45(4),BC_45);
y_45(1:N,1) = zeros(N,1);

% 2.3.5. Straight Recovery Flight: POS 5-6
BC_56 = [x_45(end), h_45(end), v_45(end)];
gamma_56(1:N,1) = traj_56(3); time_56(1:N,1) = linspace(0,traj_56(1),N);
[x_56,h_56,v_56,CL_56,Cd_56] = ...
    straight_flight(traj_56(2),g,S,Cd0,k,m*g,traj_56(3),1,1,time_56,traj_56(4),BC_56);
y_56(1:N,1) = zeros(N,1);

% 2.3.6. Waiting Turn: POS 6-7
vect_turn = [traj_67(2), Cd0, k, pi/60, atmos(BC_56(2)), S, g];
BC_67 = [x_56(end), h_56(end), v_56(end)];
gamma_67(1:N,1) = traj_67(3); time_67(1:N,1) = linspace(0,traj_67(1),N);
[x_67,y_67,h_67,Xi_67,v_67,CL_67,Cd_67,mu_67,R_67,Xi_p_67] = ...
    turn_equations(time_67,vect_turn,BC_67);

voltes_totals = Xi_p_67*traj_67(1)/(2*pi);  % Completed 360º turns
temps_volta = traj_67(1)/voltes_totals;     % Time per full turn [sec]

% 2.3.7. Descent Recovery Flight: POS 7-8
BC_78 = [x_67(end), h_67(end), v_67(end)];
gamma_78(1:N,1) = traj_78(3); time_78(1:N,1) = linspace(0,traj_78(1),N);
[r_78,h_78,v_78,CL_78,Cd_78] = ...
    straight_flight(traj_78(2),g,S,Cd0,k,m*g,traj_78(3),1,1,time_78,traj_78(4),BC_78);
x_78 = x_67(end) + (r_78-r_78(1))*cos(Xi_67(end));
y_78 = y_67(end) - (r_78-r_78(1))*sin(Xi_67(end));

% 2.4. Assembly
X = [x_12; x_23; x_34; x_45; x_56; x_67; x_78]; 
Y = [y_12; y_23; y_34; y_45; y_56; y_67; y_78];
H = [h_12; h_23; h_34; h_45; h_56; h_67; h_78];
CL = [CL_12; CL_23; CL_34; CL_45; CL_56; CL_67; CL_78];
Cd = [Cd_12; Cd_23; Cd_34; Cd_45; Cd_56; Cd_67; Cd_78];
V = [v_12; v_23; v_34; v_45; v_56; v_67; v_78];
T = [traj_12(2)*ones(N,1); traj_23(2)*ones(N,1); traj_34(2)*ones(N,1); ...
    traj_45(2)*ones(N,1); traj_56(2)*ones(N,1); traj_67(2)*ones(N,1); ...
    traj_78(2)*ones(N,1)];
Time = linspace(0,traj_12(1)+traj_23(1)+traj_34(1)+traj_45(1)+traj_56(1)+ ...
    traj_67(1)+traj_78(1),7*N)';

%% ------------------------------------------------------------------------
%                             3. PLOTTING
%        Aerodynamic coefficients calculation and performance analysis
%--------------------------------------------------------------------------
% 3.1 Plotting forces vs alpha_wb for differents delta_e
 % 3.1.1 Inputs
delta_e = -5:2:10;
alpha_wb = 0:1:15;

 % 3.1.2 Plotting
%[p1,p2] = delta_e_plotting(delta_e,COEFF,alpha_wb);
plotting(X,Y,H,T,CL,Cd,Time,V,S,m*g)

% 3.2 Equilibrium Flight
% Alpha wing-body range

