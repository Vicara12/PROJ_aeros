function [p1,p2] = delta_e_plotting(delta_e,COEFF,alpha_wb)

%------------------------------------------------------------------------------------
% Remember 
    %  Lift coefficients
    % CL = CL_0 + CL_alpha_wb*alpha_wb + CL_delta_e*delta_e
    % CL_0 = at*(it - iwb - eps0)*eta_t*sA;
    % CL_alpha_wb = awb + at*eta_t*sA*(1 - epsDalpha);
    % CL_delta_e = at*eta_t*sA*tau_e;
    % 
    %  Pitch torque coefficients
    % Cm = Cm_0 + Cm_alpha_wb*alpha_wb + Cm_delta_e*delta_e
    % Cm_0 = Cmacwb - at*eta_t*Vt*(it-iwb-eps0);
    % Cm_alpha_wb = awb*(xcg - xacwb) - at*eta_t*Vt*(1-epsDalpha);
    % Cm_delta_e = -at*eta_t*Vt*tau_e;
%------------------------------------------------------------------------------------

% Definition of coefficients
Cl = zeros(1,length(alpha_wb),length(delta_e)); 
Cm = zeros(1,length(alpha_wb),length(delta_e)); 

    for i = 1:length(delta_e)
        for j = 1:length(alpha_wb)
            Cl(1,j,i) = COEFF(1,:)*[1; alpha_wb(1,j); delta_e(1,i)];
            Cm(1,j,i) = COEFF(2,:)*[1; alpha_wb(1,j); delta_e(1,i)];
        end
    end

% Plotting lift coefficient
    figure(1)
    for i  = 1:length(delta_e)
        p1(i) = plot(alpha_wb,Cl(1,:,i));
        hold on
    end
    
    title ('CL vs \alpha_{wb} for differents \delta_{e}')
    xlabel ('\alpha_{wb}')
    ylabel ('Lift coefficient, Cl')
    grid on 
    grid minor

% Plotting moment coefficient
    figure(2)
    for i =  1:length(delta_e)
        p2(i) = plot(alpha_wb,Cm(1,:,i));
        hold on 
    end
    
    title ('Cm vs \alpha_{wb} for differents \delta_{e}')
    xlabel ('\alpha_{wb}')
    ylabel ('Moment coefficient, Cm')
    grid on 
    grid minor

end


