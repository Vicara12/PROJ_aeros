function [X,Y,H,CL,Cd,V,T,Mu,Time] = assembly(x_12, x_23, x_34, x_45, x_56, x_67, x_78, mu_67,...
    y_12, y_23, y_34, y_45, y_56, y_67, y_78, h_12, h_23, h_34, h_45, h_56, h_67, h_78,...
    CL_12, CL_23, CL_34, CL_45, CL_56, CL_67, CL_78, Cd_12, Cd_23, Cd_34, Cd_45, Cd_56, Cd_67, Cd_78,...
    v_12, v_23, v_34, v_45, v_56, v_67, v_78, traj_12,traj_23,traj_34,traj_45,traj_56,traj_67,traj_78, N)

    X = [x_12; x_23; x_34; x_45; x_56; x_67; x_78]; 
    Y = [y_12; y_23; y_34; y_45; y_56; y_67; y_78];
    H = [h_12; h_23; h_34; h_45; h_56; h_67; h_78];
    CL = [CL_12; CL_23; CL_34; CL_45; CL_56; CL_67; CL_78];
    Cd = [Cd_12; Cd_23; Cd_34; Cd_45; Cd_56; Cd_67; Cd_78];
    V = [v_12; v_23; v_34; v_45; v_56; v_67; v_78];
    T = [traj_12(2)./v_12; traj_23(2)./v_23; traj_34(2)./v_34; ...
        traj_45(2)./v_45; traj_56(2)./v_56; traj_67(2)./v_67; ...
        traj_78(2)./v_78];
    Mu = [zeros(5*N,1); mu_67*ones(N,1); zeros(N,1)];
    Time = linspace(0,traj_12(1)+traj_23(1)+traj_34(1)+traj_45(1)+traj_56(1)+ ...
        traj_67(1)+traj_78(1),7*N)';

end

