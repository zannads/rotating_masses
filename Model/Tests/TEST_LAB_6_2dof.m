%% 2-dof Pole-placement + observer

A_sys = greybox_id_2dof.A;
B_sys = greybox_id_2dof.B;
C_sys = greybox_id_2dof.C;         % in lab, con sensori togliere i "-"
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
% Pole-placement 1-dof
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
% Pole-placement 1-dof
controller.active_technique = 12;

% K = place( A_sys, B_sys, [-40+20i -40-20.1i -100 -0] );
A_place = [A_sys,zeros(4,1);
           -C_sys(1,:),0];
B_place = [B_sys;0];
K = place( A_sys, B_sys, [-0, -33.8, -43.1, -43.101] )
damp( A_sys-B_sys*K )
A_new = A_sys-B_sys*K;
sys_place = -C_sys(1,:)/(s*eye(4)-A_new)*B_sys;
margin( minreal( sys_place ) )
controller.c10.K_x = K(1:6);
controller.c10.K_v = 3;
margin( minreal( sys_place ) * controller.c10.K_v )
