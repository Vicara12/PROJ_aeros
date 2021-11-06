%--------------------------------------------------------------------------
%                   PEA - FLIGHT PERFORMANCE ANALYSIS
%                   AUTHORS: Aerodynamics department 
% fran.14hg@gmail.com, 
% marta.arnabatmartin0506@gmail.com 
% victorcarballoar@gmail.com
%--------------------------------------------------------------------------
%% MAIN
clc, clear all, close all

%% ------------------------------------------------------------------------
%                               1. INPUT
%           User definition of the different solver's inputs
%--------------------------------------------------------------------------

% 1.1. Flight parameters
m = 2000;                 % Mass [kg]
v0 = 160/3.6;             % Initial velocity [m/s]
g = 9.81;                 % Gravity [N/kg]
P_max = 220*1000;         % Maximum required power [W]

% 1.2. Geometry parameters
b   = 11;                 % Wing span [m]
c   = 1.509;              % MAC [m]
ce  = 0.25;               % Elevator chord [m] (IMPROVE!)
S   = 16.5;               % Wing surface [m^2]
St  = 3.43;               % Horizontal tail surface [m^2]
Sv  = 1.71;               % Vertical tail surface [m^2]
Se  = 1.00;               % Elevator surface (IMPROVE!)
lt  = 4.32;               % Distance from CM to tail (= lv) [m]
hv  = 1.06;               % Height vertical stabilizer [m]
lf = 8.5;                 % Fuselage length [m]
df = 2.5;                 % Maximum height of the fuselage 
Ss = 1.02*(lf*df + Sv);   % Projected surface  
h1 = 2;                   % Height of fuselage at 1/4 lf    
h2 = 0.95;                % Height of fuselage at 3/4 lf
w1 = 1.3;                 % Width of fuselage at 1/4 lf
w2 = 1;                   % Width of fuselage at 3/4 lf
kb = 0.15;                % Coefficient given by the ratio betwwen lf and h 

% 1.3. Aerodynamic parameters
iwb = 0.03835;            % LSN angle, wing+body [rad]
it  = 0.01187;            % LSN angle, tail [rad]
awb = 4.3644;             % Lift slope wing+body [rad^-1]
at  = 3.2664;             % Lift slope tail horizontal [rad^-1]
av  = 3.2664;             % Lift slope tail vertical [rad^-1]
tau_e = 3.2310;           % Elevator efficiency [rad^-1]
tau_a = 3.2534;           % Ailerons efficiency [rad^-1]
tau_v = 3.2310;           % Rudder efficiency [rad^-1]
Cmacwb = -0.05333;        % Wing+body free moment coefficient [ad]
eta_t = 0.95;             % Horizontal wind relation (vt/v)^2 [ad]
eta_v = 0.95;             % Vertical wind relation (v_v/v)^2  [ad]
Cd0 = 0.015;              % Parasite drag coefficient [ad] (0.009)
k = 0.08;                 % Induced drag coefficient [ad]

% 1.4. Configuration parameters
xcg = 3/c;                % Gravity center position (from cockpit), [ad] (MAC)
xacwb = (0.65+1.86)/c;    % Wing+body aerod. center position (from cockpit), [ad] (MAC)
d = 0.5;                  % Distance between COM and AC

% 1.5. Interference parameters
eps0 = 0.1;               % Reference epsilon [rad]
epsDalpha = 0.1;          % Epsilon over alpha derivative [ad]
sigmaDbeta = 0.1;         % Sigma over beta derivative [ad]

% 1.6. Trim parameters (TAB)
G = -1;                   % Gear relation [m^-1] (IMPROVE!)
Ch_0 = 0;                 % Hinge free coefficient
Ch_alpha_wb = -0.295;     % Hinge AoA coefficient
Ch_delta_e = -0.59;       % Hinge elevator coefficient
Ch_delta_t = -0.5;        % Hinge tab coefficent (IMPROVE!)

% 1.7. Numerical parameters
N = 10;                   % Time discretization [ad]

% 1.8. Trajectory BC parameters
[traj_12,traj_23,traj_34,traj_45,traj_56,traj_67, traj_78] = trajectory(P_max);

%% ------------------------------------------------------------------------
%                             2. CALCULUS
%        Aerodynamic coefficients calculation and performance analysis
%--------------------------------------------------------------------------

% 2.1. Vector of the parameters
vect_coeff = [b, c, S, St, Sv, lt, hv, iwb, it, awb, at, av, tau_e, ...
    tau_a, tau_v, Cmacwb, eta_t, eta_v, xcg, xacwb, eps0, epsDalpha, sigmaDbeta,...
    h1, h2, w1, w2, lf, Ss, d, kb];

% 2.2. Aerodynamic coefficients calculation
[COEFF] = aerod_coeff(vect_coeff);

% 2.3. Trajectory determination
[x_12,y_12,h_12,v_12,CL_12,Cd_12, x_23,y_23,h_23,v_23,CL_23,Cd_23,x_34,y_34,h_34,v_34,CL_34,...
    Cd_34,x_45,y_45,h_45,v_45,CL_45,Cd_45,x_56,y_56,h_56,v_56,CL_56,Cd_56, x_67,y_67,h_67,Xi_67,...
    v_67,CL_67,Cd_67,mu_67,R_67,Xi_p_67,T_67, r_78,h_78,v_78,CL_78,Cd_78, x_78, y_78, temps_volta]...
    = performance(traj_12,traj_23,traj_34,traj_45,traj_56,traj_67,traj_78,S,Cd0,k,m,g,v0,N);

% 2.4. Assembly
[X,Y,H,CL,Cd,V,T,Mu,Time] = assembly(x_12, x_23, x_34, x_45, x_56, x_67, x_78, mu_67, ...
    y_12, y_23, y_34, y_45, y_56, y_67, y_78, h_12, h_23, h_34, h_45, h_56, h_67, h_78,...
    CL_12, CL_23, CL_34, CL_45, CL_56, CL_67, CL_78, Cd_12, Cd_23, Cd_34, Cd_45, Cd_56, Cd_67, Cd_78,...
    v_12, v_23, v_34, v_45, v_56, v_67, v_78, traj_12,traj_23,traj_34,traj_45,traj_56,traj_67,traj_78, N);

% 2.5. Control surfaces position
[ANGLES] = control_surfaces(COEFF, CL, Mu);

% 2.6. Energy needed
E = energy(T,V,Time); % kWh

%% ------------------------------------------------------------------------
%                             3. PLOTTING
%        Aerodynamic coefficients calculation and performance analysis
%--------------------------------------------------------------------------

% 3.1. Plotting of aircraft aerodynamic curves
% 3.1.1. Inputs
delta_e = -5:2:10;          % Deflection elevator range
alpha_wb = -5:1:15;         % Alpha wing-body range

% 3.1.2. Plotting
coeff_plotting(delta_e,COEFF,alpha_wb);

% 3.2. Plotting forces, velocity, height and position along the time 
plotting(X,Y,H,T,ANGLES,CL,Cd,Time,V,S,m*g)

% 3.3. Neutral point [adimensional with MAC]
N0 = xacwb + at/awb*eta_t*St/S*lt/c*(1-epsDalpha);
N0_f = N0 + 1/awb*COEFF(2,3)/Ch_delta_e*Ch_alpha_wb;

% 3.4. Plotting lever force
% 3.4.1. Input
delta_t = 0:0.2:1;          % Plot for the cruise flight [deg]
vel = [0 400];              % Plot for the cuirse flight [km/h]

% 3.4.2. Plotting
TAB = [G, Ch_0, Ch_alpha_wb, Ch_delta_e, Ch_delta_t,eta_t,Se,ce,m*g,S,iwb,it];
lever_force(TAB,COEFF,H,V,Time,delta_t,vel,N)

