function [COEFF] = aerod_coeff(vect)
%% INPUT

% Geometry parameters
b   = sym('b', 'positive');          % Wing span
c   = sym('c', 'positive');          % MAC 
S   = sym('S', 'positive');          % Wing surface
St  = sym('St','positive');          % Horizontal tail surface
Sv  = sym('Sv','positive');          % Vertical tail surface
lt  = sym('lt','positive');          % Distance from CM to tail (= lv)
hv  = sym('hv','positive');          % Height vertical stabilizer

% Aerodynamic parameters
iwb = sym('iwb','real');             % LSN angle, wing+body
it  = sym('it' ,'real');             % LSN angle, tail
awb = sym('awb','real');             % Lift slope wing+body
at  = sym('at' ,'real');             % Lift slope tail horizontal
av  = sym('av' ,'real');             % Lift slope tail vertical
tau_e = sym('tau_e','positive');     % Elevator efficiency
tau_a = sym('tau_a','positive');     % Ailerons efficiency
tau_v = sym('tau_v','positive');     % Rudder efficiency
Cmacwb = sym('Cmacwb','real');       % Wing+body free moment coefficient
eta_t = sym('eta_t','positive');     % Horizontal wind relation (vt/v)^2
eta_v = sym('eta_v','positive');     % Vertical wind relation (v_v/v)^2   

% Configuration parameters
xcg = sym('xcg','real');             % Gravity center position (from cockpit), adimensional (MAC)
xacwb = sym('xac','real');           % Wing+body aerod. center position (from cockpit), adimensional (MAC)

% Interference parameters
eps0 = sym('eps0','positive');              % Reference epsilon
epsDalpha = sym('epsDalpha','real');        % Epsilon over alpha derivative
sigmaDbeta = sym('sigmaDbeta','real');      % Sigma over beta derivative

%% Longitudinal coefficients
% Geometry relations
sA = St/S;
Vt = sA*lt/c;

% Lift coefficients
CL_0 = at*(it - iwb - eps0)*eta_t*sA;
CL_alpha_wb = awb + at*eta_t*sA*(1 - epsDalpha);
CL_delta_e = at*eta_t*sA*tau_e;

% Pitch torque coefficients
Cm_0 = Cmacwb - at*eta_t*Vt*(it-iwb-eps0);
Cm_alpha_wb = awb*(xcg - xacwb) - at*eta_t*Vt*(1-epsDalpha);
Cm_delta_e = -at*eta_t*Vt*tau_e;

%% Lateral coefficients
% Geometry relations
sV = Sv/S;

% Side force
CY_beta = -eta_v*sV*av*(1-sigmaDbeta);
CY_delta_a = 0; % Approx
CY_delta_r = -eta_v*sV*av*tau_v;

% Roll torque
Cl_beta = -eta_v*sV*hv/b*av*(1 - sigmaDbeta); % MILLORABLE!!!! REPASSAR
Cl_delta_a = tau_a/2;
Cl_delta_r = -eta_v*sV*hv/b*av*tau_v;

% Yaw torque
Cn_beta = -CY_beta*lt/b;
Cn_delta_a = 0; % MILLORABLE!!!! REPASSAR
Cn_delta_r = -CY_delta_r*lt/b;

%% MATRIX OF COEFFICIENTS
% Vector of symbolic parameters
vect_symb = [b, c, S, St, Sv, lt, hv, iwb, it, awb, at, av, tau_e, ...
    tau_a, tau_v, Cmacwb, eta_t, eta_v, xcg, xacwb, eps0, epsDalpha, sigmaDbeta];

% Definition of the matrix
COEFF_symb = [
    CL_0      CL_alpha_wb    CL_delta_e ;
    Cm_0      Cm_alpha_wb    Cm_delta_e ;
    CY_beta   CY_delta_a     CY_delta_r ;
    Cl_beta   Cl_delta_a     Cl_delta_r ;
    Cn_beta   Cn_delta_a     Cn_delta_r ;
    ];

% Substitution
COEFF = double(subs(COEFF_symb,vect_symb,vect));

end