%% 2-dof state-space controllers

A_sys = greybox_id_2dof.A;
B_sys = greybox_id_2dof.B;
C_sys = [1,0,0,0,0,0;
         0,0,-1,0,0,0;
         0,0,0,0,-1,0];         

%% Observer

title = "obs 2dof";
controller.active_observer = 0; % select best observer
controller.active_technique = 10;

L = place( A_sys', C_sys', -[400 400.1 300 300.1 400.2 400.3] )';
controller.obs_2dof.L = L;
controller.obs_2dof.A = A_sys-L*C_sys;
controller.obs_2dof.B = [B_sys, L];
controller.obs_2dof.C = eye(6);
controller.obs_2dof.D = zeros(6,4);

%% Kalman Filter

title = "KF 2dof";
controller.active_observer = 2; % select best observer
controller.active_technique = 10;

Q = eye(6)*1e-6;
R = [1e-6, 0, 0;
     0, 2e-8, 0;
     0, 0, 2e-8];

[P, L, autovals, info] = icare( A_sys', C_sys', Q, R );
L = L';
controller.KF_2dof.L = L;
controller.KF_2dof.A = A_sys-L*C_sys;
controller.KF_2dof.B = [B_sys, L];
controller.KF_2dof.C = eye(6);
controller.KF_2dof.D = zeros(6,4);

%% Kalman Filter min

title = "minKF 2dof";
controller.active_observer = 3; % select best observer
controller.active_technique = 10;

C_sys=[0,0,0,0,-1,0];
Q = eye(6)*1e-6;
R = 2e-8;

[P, L, autovals, info] = icare( A_sys', C_sys', Q, R );
L = L';
controller.minKF_2dof.L = L;
controller.minKF_2dof.A = A_sys-L*C_sys;
controller.minKF_2dof.B = [B_sys, L];
controller.minKF_2dof.C = eye(6);
controller.minKF_2dof.D = zeros(6,2);

%% Pole-placement

title = "obs + pp 2dof";
controller.active_observer = 2; % select best observer
controller.active_technique = 10;

A_place = [A_sys, zeros(6,1);[0,0,0,0,1,0,0]];
B_place = [B_sys;0];

K = place( A_place, B_place, [-20, -30, ...
    -24.5*(0.6+sin(acos(0.6))*1i), -24.5*(0.6-sin(acos(0.6))*1i), ...
    -61.9*(0.2+sin(acos(0.2))*1i), -61.9*(0.2-sin(acos(0.2))*1i), -10] )
controller.c10.K_x = K(1:6);
controller.c10.K_v = K(end);
%% 
title = "kf and new pp 2dof";
controller.active_observer = 2; % select best observer
controller.active_technique = 10;

A_place = [A_sys, zeros(6,1);[0,0,0,0,1,0,0]];
B_place = [B_sys;0];

K = place( A_place, B_place, [-30, -40, ...
    -24.5*(0.9+sin(acos(0.9))*1i), -24.5*(0.9-sin(acos(0.9))*1i), ...
    -61.9*(0.9+sin(acos(0.9))*1i), -61.9*(0.9-sin(acos(0.9))*1i), -10] )
controller.c10.K_x = K(1:6);
controller.c10.K_v = K(end);

%% 
title = "kf and dominant -20 pp 2dof";
controller.active_observer = 2; % select best observer
controller.active_technique = 10;

A_place = [A_sys, zeros(6,1);[0,0,0,0,1,0,0]];
B_place = [B_sys;0];

K = place( A_place, B_place, [-30, -40, ...
    -24.5*(0.9+sin(acos(0.9))*1i), -24.5*(0.9-sin(acos(0.9))*1i), ...
    -61.9*(0.9+sin(acos(0.9))*1i), -61.9*(0.9-sin(acos(0.9))*1i), -20] )
controller.c10.K_x = K(1:6);
controller.c10.K_v = K(end);

%% 
title = "poles at greybox position 2dof";
controller.active_observer = 2; % select best observer
controller.active_technique = 10;

A_place = [A_sys, zeros(6,1);[0,0,0,0,1,0,0]];
B_place = [B_sys;0];

K = place( A_place, B_place, [-30.6, -40, ...
    -24.9*(0.9+sin(acos(0.9))*1i), -24.9*(0.9-sin(acos(0.9))*1i), ...
    -62.3*(0.9+sin(acos(0.9))*1i), -62.3*(0.9-sin(acos(0.9))*1i), -10] )
controller.c10.K_x = K(1:6);
controller.c10.K_v = K(end);

%% BACK TO FREQUENCY

%% C3
% controller.active_technique = 3;
controller.c3.wc_v = 5;

controller.c3.wn_num_p1 = 24.9;
controller.c3.wn_den_p1 = 24.9;
controller.c3.psi_num_p1 = 1.47e-01;
controller.c3.psi_den_p1 = 0.72;

controller.c3.wn_num_p2 = 62.3;
controller.c3.wn_den_p2 = 62.3;
controller.c3.psi_num_p2 = 2.36e-02;
controller.c3.psi_den_p2 = 0.72;

controller.c3.Pf = 1;

% PI-structure
controller.c3.ki_v = controller.c3.wc_v;
controller.c3.kp_v = controller.c3.wc_v/30.6;
controller.c3.Ti_v = controller.c3.kp_v/controller.c3.ki_v;

% Notch-filter
Nf_1 = notch_definition( controller.c3.wn_num_p1, controller.c3.psi_num_p1, ...
    controller.c3.wn_den_p1, controller.c3.psi_den_p1 );
Nf_2 = notch_definition( controller.c3.wn_num_p2, controller.c3.psi_num_p2, ...
    controller.c3.wn_den_p2, controller.c3.psi_den_p2 );
controller.c3.Nf = Nf_1 * Nf_2;

%% C3
% controller.active_technique = 3;
controller.c3.wc_v = 5;

controller.c3.wn_num_p1 = 24.9;
controller.c3.wn_den_p1 = 100;
controller.c3.psi_num_p1 = 1.47e-01;
controller.c3.psi_den_p1 = 0.72;

controller.c3.wn_num_p2 = 62.3;
controller.c3.wn_den_p2 = 100;
controller.c3.psi_num_p2 = 2.36e-02;
controller.c3.psi_den_p2 = 0.72;

controller.c3.Pf = 1;

% PI-structure
controller.c3.ki_v = controller.c3.wc_v;
controller.c3.kp_v = controller.c3.wc_v/30.6;
controller.c3.Ti_v = controller.c3.kp_v/controller.c3.ki_v;

% Notch-filter
Nf_1 = notch_definition( controller.c3.wn_num_p1, controller.c3.psi_num_p1, ...
    controller.c3.wn_den_p1, controller.c3.psi_den_p1 );
Nf_2 = notch_definition( controller.c3.wn_num_p2, controller.c3.psi_num_p2, ...
    controller.c3.wn_den_p2, controller.c3.psi_den_p2 );
controller.c3.Nf = Nf_1 * Nf_2;

