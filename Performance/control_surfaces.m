function [ANGLES] = control_surfaces(COEFF,CL,mu)

% Symbolic parameters
syms CL_sym mu_sym alpha_wb beta_w delta_e delta_a delta_r

% Unknowns
INC = [alpha_wb; beta_w; delta_e; delta_a; delta_r];

% Coefficient matrix
MAT = [ % alpha_wb  beta    delta_e    delta_a      delta_r
        COEFF(1,2)   0     COEFF(1,3)     0            0        ;   % CL
        COEFF(2,2)   0     COEFF(2,3)     0            0        ;   % Cm
            0     COEFF(3,1)   0      COEFF(3,2)   COEFF(3,3)   ;   % CY
            0     COEFF(4,1)   0      COEFF(4,2)   COEFF(4,3)   ;   % Cl
            0     COEFF(5,1)   0      COEFF(5,2)   COEFF(5,3)  ];   % Cn

% Independent
IND = [CL_sym; 0; -CL_sym*sin(mu_sym); 0; 0];  

% Solve system
SOL = solve(MAT*INC == IND, INC);

ANGLES = zeros(length(CL),5);
for i = 1:length(CL)
    ANGLES(i,1) = subs(SOL.alpha_wb,[CL_sym, mu_sym], [CL(i), mu(i)]);  % alpha_wb
    ANGLES(i,2) = subs(SOL.beta_w,  [CL_sym, mu_sym], [CL(i), mu(i)]);  % beta
    ANGLES(i,3) = subs(SOL.delta_e, [CL_sym, mu_sym], [CL(i), mu(i)]);  % delta_e
    ANGLES(i,4) = subs(SOL.delta_a, [CL_sym, mu_sym], [CL(i), mu(i)]);  % delta_a
    ANGLES(i,5) = subs(SOL.delta_r, [CL_sym, mu_sym], [CL(i), mu(i)]);  % delta_r
end    
ANGLES = double(ANGLES);

end