%% Pole-placement + observer

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

% Pole-placement 1-dof

% K = place( A_sys, B_sys, [-40+20i -40-20.1i -100 -0] );
A_place = [A_sys,zeros(4,1);
           -C_sys(end,:),0];
B_place = [B_sys;0];
K = place( A_place, B_place, [-0, -33.8, -43.1, -43.101, -10] );
controller.c9.K_x = K(1:4);
controller.c9.K_v = K(end);
