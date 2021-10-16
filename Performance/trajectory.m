function [traj_12,traj_23,traj_34,traj_45,traj_56,traj_67, traj_78] = trajectory(P_max)

% TRAJ_XX = [ Maneuver time (sec) , Power (W), Climb angle [rad], STATIC (0) or DYNAMIC (1) ]
    
    traj_12 = [50,     0.8*P_max,   +5*pi/180,   1];    % Ascent flight 835,4
    traj_23 = [50,     0.5*P_max,    0*pi/180,   0];    % Straight flight 5000
    traj_34 = [50,     0.2*P_max,   -2*pi/180,   1];    % Descent flight
    traj_45 = [20,     0.8*P_max,   +2*pi/180,   1];    % Ascent recovery flight
    traj_56 = [20,     0.5*P_max,    0*pi/180,   1];    % Straight recovery flight
    traj_67 = [45*60,  0.5*P_max,    0*pi/180,   0];    % Waiting turn (ignore 4th comp)
    traj_78 = [20,     0.2*P_max,   -2*pi/180,   1];    % Descent recovery flight

end