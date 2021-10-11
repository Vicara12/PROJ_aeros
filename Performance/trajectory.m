function [traj_12,traj_23,traj_34,traj_45,traj_56,traj_67, traj_78] = trajectory()

% TRAJ_XX = [ Maneuver time (sec) , Thrust (N), Climb angle [rad], STATIC (0) or DYNAMIC (1) ]
    
    traj_12 = [50,      5000,    2*pi/180,   1];    % Ascent flight
    traj_23 = [50,      5000,    0*pi/180,   0];    % Straight flight
    traj_34 = [50,      1000,   -2*pi/180,   1];    % Descent flight
    traj_45 = [20,      5000,    2*pi/180,   1];    % Ascent recovery flight
    traj_56 = [20,      1000,    0*pi/180,   1];    % Straight recovery flight
    traj_67 = [45*60,   5000,    0*pi/180,   0];    % Waiting turn (ignore 4th comp)
    traj_78 = [20,      1000,   -2*pi/180,   1];    % Descent recovery flight


end