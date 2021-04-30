%% 2-dof Pole-placement + observer

A_sys = greybox_id_2dof.A;
B_sys = greybox_id_2dof.B;
C_sys = greybox_id_2dof.C;         
D_sys = greybox_id_2dof.D;

% Observer 2-dof

controller.c11.L = place( A_sys', C_sys', -[400 400.1 300 100 100.1 100.2] )';
controller.c11.A_obs = A_sys-controller.c11.L*C_sys;
controller.c11.B_obs = [B_sys-controller.c11.L*D_sys, controller.c11.L];
controller.c11.C_obs = eye(6);
controller.c11.D_obs = zeros(6,5);

controller.c12.L = place( A_sys', C_sys', -[400 400.1 300 100 100.1 100.2] )';
controller.c12.A_obs = A_sys-controller.c12.L*C_sys;
controller.c12.B_obs = [B_sys-controller.c12.L*D_sys, controller.c12.L];
controller.c12.C_obs = eye(6);
controller.c12.D_obs = zeros(6,5);

%% ORE 
title = "test 1 2-dof pole-placement + observer + loop_speed";
% Pole-placement 2-dof
controller.active_technique = 11;

A_place = [A_sys,zeros(6,1);
           -C_sys(end,:),0];
B_place = [B_sys;0];
K = place( A_place, B_place, [-0, -34.9, ...
    -24.5*(0.72+sin(acos(0.72))*1i), -24.5*(0.72-sin(acos(0.72))*1i), ...
    -61.9*(0.72+sin(acos(0.72))*1i), -61.9*(0.72-sin(acos(0.72))*1i), -12] );
controller.c11.K_x = K(1:6);
controller.c11.K_v = K(end);

%% ORE 
title = "test 3 2-dof pole-placement + observer + loop_pos";
% Pole-placement 2-dof
controller.active_technique = 12;

% K = place( A_sys, B_sys, [-40+20i -40-20.1i -100 -0] );
% A_place = [A_sys,zeros(6,1);
%            -C_sys(3,:),0];
% B_place = [B_sys;0];
K = place( A_sys, B_sys, [-0, -34.9, ...
    -24.5*(0.72+sin(acos(0.72))*1i), -24.5*(0.72-sin(acos(0.72))*1i), ...
    -61.9*(0.72+sin(acos(0.72))*1i), -61.9*(0.72-sin(acos(0.72))*1i)] )
damp( A_sys-B_sys*K )
A_new = A_sys-B_sys*K;
sys_place = -C_sys(3,:)/(s*eye(6)-A_new)*B_sys;
margin( minreal( sys_place ) )
controller.c12.K_x = K(1:6);
controller.c12.K_v = 2;
margin( minreal( sys_place ) * controller.c12.K_v )

%% Reduced order observer 2-dof

T = zeros(6);
T(1:2,1:2) = eye(2);
T(3:6,:) = C_sys;

A_tilde = T*A_sys/T;
B_tilde = T*B_sys;
C_tilde = C_sys/T;

B_tilde_1 = B_tilde(3:6);
B_tilde_2 = B_tilde(1:2);
A_tilde_11 = A_tilde(3:6,3:6);
A_tilde_12 = A_tilde(3:6,1:2);
A_tilde_21 = A_tilde(1:2,3:6);
A_tilde_22 = A_tilde(1:2,1:2);

L = place( A_tilde_22', A_tilde_12', -[400 400.1] )';
controller.c15.L = L;
controller.c15.A_obs = A_tilde_22-controller.c15.L*A_tilde_12;
controller.c15.B_obs = [B_tilde_2-L*B_tilde_1, A_tilde_21-L*A_tilde_11+A_tilde_22*L-L*A_tilde_12*L];
controller.c15.C_obs = eye(2);
controller.c15.D_obs = zeros(2,5);

controller.c16.L = L;
controller.c16.A_obs = A_tilde_22-controller.c16.L*A_tilde_12;
controller.c16.B_obs = [B_tilde_2-L*B_tilde_1, A_tilde_21-L*A_tilde_11+A_tilde_22*L-L*A_tilde_12*L];
controller.c16.C_obs = eye(2);
controller.c16.D_obs = zeros(2,5);

%% ORE 
title = "test 3 2-dof pole-placement + red observer + loop_speed";
% Pole-placement 2-dof
controller.active_technique = 15;

A_place = [A_sys,zeros(6,1);
           -C_sys(end,:),0];
B_place = [B_sys;0];
K = place( A_place, B_place, [-0, -34.9, ...
    -24.5*(0.72+sin(acos(0.72))*1i), -24.5*(0.72-sin(acos(0.72))*1i), ...
    -61.9*(0.72+sin(acos(0.72))*1i), -61.9*(0.72-sin(acos(0.72))*1i), -12] );
controller.c15.K_x = K(1:6);
controller.c15.K_v = K(end);

%% ORE 
title = "test 4 2-dof pole-placement + red observer + loop_pos";
% Pole-placement 2-dof
controller.active_technique = 16;

% K = place( A_sys, B_sys, [-40+20i -40-20.1i -100 -0] );
% A_place = [A_sys,zeros(6,1);
%            -C_sys(3,:),0];
% B_place = [B_sys;0];
K = place( A_sys, B_sys, [-0, -34.9, ...
    -24.5*(0.72+sin(acos(0.72))*1i), -24.5*(0.72-sin(acos(0.72))*1i), ...
    -61.9*(0.72+sin(acos(0.72))*1i), -61.9*(0.72-sin(acos(0.72))*1i)] )
damp( A_sys-B_sys*K )
A_new = A_sys-B_sys*K;
sys_place = -C_sys(3,:)/(s*eye(6)-A_new)*B_sys;
margin( minreal( sys_place ) )
controller.c16.K_x = K(1:6);
controller.c16.K_v = 2;
margin( minreal( sys_place ) * controller.c16.K_v )
