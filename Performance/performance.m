function [x_12,y_12,h_12,v_12,CL_12,Cd_12, x_23,y_23,h_23,v_23,CL_23,Cd_23,x_34,y_34,h_34,v_34,CL_34,...
    Cd_34,x_45,y_45,h_45,v_45,CL_45,Cd_45,x_56,y_56,h_56,v_56,CL_56,Cd_56, x_67,y_67,h_67,Xi_67,...
    v_67,CL_67,Cd_67,mu_67,R_67,Xi_p_67,T_67, r_78,h_78,v_78,CL_78,Cd_78, x_78, y_78, temps_volta]...
    = performance(traj_12,traj_23,traj_34,traj_45,traj_56,traj_67,traj_78,S,Cd0,k,m,g,v0,N)

 % -------------------- 2.3. Trajectory determination --------------------
    
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
    vect_turn = [traj_67(2), Cd0, k, pi/60, atmos(BC_56(2)), S, g, m];
    BC_67 = [x_56(end), h_56(end), v_56(end)];
     gamma_67(1:N,1) = traj_67(3); time_67(1:N,1) = linspace(0,traj_67(1),N);
    [x_67,y_67,h_67,Xi_67,v_67,CL_67,Cd_67,mu_67,R_67,Xi_p_67,T_67] = ...
        turn_equations(time_67,vect_turn,BC_67);

    traj_67(2) = T_67;                          % New value of thrust
    voltes_totals = Xi_p_67*traj_67(1)/(2*pi);  % Completed 360º turns
    temps_volta = traj_67(1)/voltes_totals;     % Time per full turn [sec]

% 2.3.7. Descent Recovery Flight: POS 7-8
    BC_78 = [x_67(end), h_67(end), v_67(end)];
     gamma_78(1:N,1) = traj_78(3); time_78(1:N,1) = linspace(0,traj_78(1),N);
    [r_78,h_78,v_78,CL_78,Cd_78] = ...
        straight_flight(traj_78(2),g,S,Cd0,k,m*g,traj_78(3),1,1,time_78,traj_78(4),BC_78);
    x_78 = x_67(end) + (r_78-r_78(1))*cos(Xi_67(end));
    y_78 = y_67(end) - (r_78-r_78(1))*sin(Xi_67(end));
    
end
