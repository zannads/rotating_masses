%% 1-dof Pole-placement + observer

A_sys = greybox_id_1dof.A;
B_sys = greybox_id_1dof.B;
C_sys = greybox_id_1dof.C;        
D_sys = greybox_id_1dof.D;

%% Complete order observer 1-dof

controller.c9.L = place( A_sys', C_sys', -[400 400.1 300 100] )';
controller.c9.A_obs = A_sys-controller.c9.L*C_sys;
controller.c9.B_obs = [B_sys-controller.c9.L*D_sys, controller.c9.L];
controller.c9.C_obs = eye(4);
controller.c9.D_obs = zeros(4,3);

controller.c10.L = place( A_sys', C_sys', -[400 400.1 300 100] )';
controller.c10.A_obs = A_sys-controller.c10.L*C_sys;
controller.c10.B_obs = [B_sys-controller.c10.L*D_sys, controller.c10.L];
controller.c10.C_obs = eye(4);
controller.c10.D_obs = zeros(4,3);

%% ORE 
title = "test 1 1-dof pole-placement + observer + loop_speed";
% Pole-placement 1-dof
controller.active_technique = 9;

A_place = [A_sys,zeros(4,1);
           -C_sys(end,:),0];
B_place = [B_sys;0];
K = place( A_place, B_place, [-0, -100, -43.1*(0.72+sin(acos(0.72))*1i), -43.1*(0.72-sin(acos(0.72))*1i), -6.15] );
controller.c9.K_x = K(1:4);
controller.c9.K_v = K(end);

%% ORE 
title = "test 2 1-dof pole-placement + observer + loop_speed";
% Pole-placement 1-dof
controller.active_technique = 9;

A_place = [A_sys,zeros(4,1);
           -C_sys(end,:),0];
B_place = [B_sys;0];
K = place( A_place, B_place, [-0, -33.8, -43.1, -43.11, -10] );
controller.c9.K_x = K(1:4);
controller.c9.K_v = K(end);

%% ORE 
title = "test 3 1-dof pole-placement + observer + loop_pos";
% Pole-placement 1-dof
controller.active_technique = 10;

% A_place = [A_sys,zeros(4,1);
%            -C_sys(1,:),0];
% B_place = [B_sys;0];
K = place( A_sys, B_sys, [-0, -33.8, -43.1, -43.101] )
A_new = A_sys-B_sys*K;
sys_place = -C_sys(1,:)/(s*eye(4)-A_new)*B_sys;
margin( minreal( sys_place ) )
controller.c10.K_x = K(1:4);
controller.c10.K_v = 3;
margin( minreal( sys_place ) * controller.c10.K_v )

%% Reduced order observer 1-dof

T = zeros(4);
T(1:2,1:2) = eye(2);
T(3:4,:) = C_sys;

A_tilde = T*A_sys/T;
B_tilde = T*B_sys;
C_tilde = C_sys/T;

B_tilde_1 = B_tilde(3:4);
B_tilde_2 = B_tilde(1:2);
A_tilde_11 = A_tilde(3:4,3:4);
A_tilde_12 = A_tilde(3:4,1:2);
A_tilde_21 = A_tilde(1:2,3:4);
A_tilde_22 = A_tilde(1:2,1:2);

L = place( A_tilde_22', A_tilde_12', -[400 400.1] )';
controller.c13.L = L;
controller.c13.A_obs = A_tilde_22-controller.c13.L*A_tilde_12;
controller.c13.B_obs = [B_tilde_2-L*B_tilde_1, A_tilde_21-L*A_tilde_11+A_tilde_22*L-L*A_tilde_12*L];
controller.c13.C_obs = eye(2);
controller.c13.D_obs = zeros(2,3);

controller.c14.L = L;
controller.c14.A_obs = A_tilde_22-controller.c13.L*A_tilde_12;
controller.c14.B_obs = [B_tilde_2-L*B_tilde_1, A_tilde_21-L*A_tilde_11+A_tilde_22*L-L*A_tilde_12*L];
controller.c14.C_obs = eye(2);
controller.c14.D_obs = zeros(2,3);

%% ORE 
title = "test 4 1-dof pole-placement + red observer + loop_speed";
% Pole-placement 1-dof
controller.active_technique = 13;

A_place = [A_sys,zeros(4,1);
           -C_sys(end,:),0];
B_place = [B_sys;0];
K = place( A_place, B_place, [-0, -100, -43.1*(0.72+sin(acos(0.72))*1i), -43.1*(0.72-sin(acos(0.72))*1i), -6.15] );
controller.c13.K_x = K(1:4);
controller.c13.K_v = K(end);

%% ORE 
title = "test 5 1-dof pole-placement + red observer + loop_pos";
% Pole-placement 1-dof
controller.active_technique = 14;

% A_place = [A_sys,zeros(4,1);
%            -C_sys(1,:),0];
% B_place = [B_sys;0];
K = place( A_sys, B_sys, [-0, -33.8, -43.1, -43.101] )
A_new = A_sys-B_sys*K;
sys_place = -C_sys(1,:)/(s*eye(4)-A_new)*B_sys;
margin( minreal( sys_place ) )
controller.c14.K_x = K(1:4);
controller.c14.K_v = 3;
margin( minreal( sys_place ) * controller.c14.K_v )
