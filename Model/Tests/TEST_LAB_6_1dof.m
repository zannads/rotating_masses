%% 1-dof Pole-placement + observer

A_sys = greybox_id_1dof.A;
B_sys = greybox_id_1dof.B;
C_sys = greybox_id_1dof.C;         % in lab, con sensori togliere i "-"
D_sys = greybox_id_1dof.D;

% Observer 1-dof

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

% K = place( A_sys, B_sys, [-40+20i -40-20.1i -100 -0] );
A_place = [A_sys,zeros(4,1);
           -C_sys(1,:),0];
B_place = [B_sys;0];
K = place( A_sys, B_sys, [-0, -33.8, -43.1, -43.101] )
A_new = A_sys-B_sys*K;
sys_place = -C_sys(1,:)/(s*eye(4)-A_new)*B_sys;
margin( minreal( sys_place ) )
controller.c10.K_x = K(1:4);
controller.c10.K_v = 3;
margin( minreal( sys_place ) * controller.c10.K_v )
