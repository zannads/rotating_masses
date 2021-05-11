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
controller.active_observer = 0; % select best observer
controller.active_technique = 10;

A_place = [A_sys, zeros(6,1);[0,0,0,0,1,0,0]];
B_place = [B_sys;0];

K = place( A_place, B_place, [-20, -30, ...
    -24.5*(0.6+sin(acos(0.6))*1i), -24.5*(0.6-sin(acos(0.6))*1i), ...
    -61.9*(0.2+sin(acos(0.2))*1i), -61.9*(0.2-sin(acos(0.2))*1i), -10] )
controller.c10.K_x = K(1:6);
controller.c10.K_v = K(end);
