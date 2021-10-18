function [traj_12,traj_23,traj_34,traj_45,traj_56,traj_67, traj_78] = trajectory(P_max)

% TRAJ_XX = [ Maneuver time (sec) , Power (W), Climb angle [rad], STATIC (0) or DYNAMIC (1) ]
    
    traj_12 = [1018,   0.90*P_max,     +3*pi/180,   1];    % Ascent flight
    traj_23 = [16000,  0.80*P_max,      0*pi/180,   0];    % Straight flight
    traj_34 = [500,    0.085*P_max,    -3*pi/180,   1];    % Descent flight
    traj_45 = [100,    0.90*P_max,     +3*pi/180,   1];    % Ascent recovery flight
    traj_56 = [60,     0.80*P_max,      0*pi/180,   0];    % Straight recovery flight
    traj_67 = [20*60,  0.80*P_max,      0*pi/180,   0];    % Waiting turn (ignore 4th comp)
    traj_78 = [770,    0.067*P_max,  -3.2*pi/180,   1];    % Descent recovery flight

end