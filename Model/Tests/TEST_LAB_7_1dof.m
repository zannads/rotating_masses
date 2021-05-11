%% 1-dof state-space controllers
A_sys = greybox_id_1dof.A;
B_sys = greybox_id_1dof.B;
C_sys = [1,0,0,0;
        0,0,-1,0];
D_sys = zeros(2,1);

%% observer

title = "observer 1dof";
controller.active_observer = 0; % select best observer
controller.active_technique = 9;

L = place( A_sys', C_sys', -[400 400.1 400.2 400.3] )';
controller.obs_1dof.L = L;
controller.obs_1dof.A = A_sys-L*C_sys;
controller.obs_1dof.B = [B_sys, L];
controller.obs_1dof.C = eye(4);
controller.obs_1dof.D = zeros(4,3);

%% Kalman Filter

title = "KF 1dof";
controller.active_observer = 2; % select best observer
controller.active_technique = 9;

Q = eye(4)*1e-8;
R = [1e-6, 0;
     0, 2e-8];

[P, L, autovals, info] = icare( A_sys', C_sys', Q, R );
L = L';
controller.KF_1dof.L = L;
controller.KF_1dof.A = A_sys-L*C_sys;
controller.KF_1dof.B = [B_sys, L];
controller.KF_1dof.C = eye(4);
controller.KF_1dof.D = zeros(4,3);

%% KF, minimum sensors

title = "minKF 1dof";
controller.active_observer = 3; % select best observer
controller.active_technique = 9;
C_sys = [0,0,-1,0];

Q = eye(4)*1e-8;
R = 2e-8;

[P, L, autovals, info] = icare( A_sys', C_sys', Q, R );
L = L';
controller.minKF_1dof.L = L;
controller.minKF_1dof.A = A_sys-L*C_sys;
controller.minKF_1dof.B = [B_sys, L];
controller.minKF_1dof.C = eye(4);
controller.minKF_1dof.D = zeros(4,2);

%% pole-placement

title = "obs+pp poli cc";
controller.active_observer = 0; % select best observer
controller.active_technique = 9;

A_place = [A_sys, zeros(4,1);[0,0,1,0,0]];
B_place = [B_sys;0];

K = place( A_place, B_place, [-21.1*(0.75+sin(acos(0.75))*1i), -21.1*(0.75-sin(acos(0.75))*1i), ...
    -40.1*(0.05+sin(acos(0.05))*1i), -40.1*(0.05-sin(acos(0.05))*1i), ...
    -10] )

controller.c9.K_x = K(1:4);
controller.c9.K_v = K(end);
