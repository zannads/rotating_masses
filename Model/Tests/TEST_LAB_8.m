%% TO DO

% 1. Increment variance of state x, in KF 1 dof

%% 1-dof LQR controllers
A_sys = greybox_id_1dof.A;
B_sys = greybox_id_1dof.B;
C_sys = [1,0,0,0;
        0,0,-1,0];
D_sys = zeros(2,1);

%% Kalman Filter
% check matrix Q before other experiments, look at oscillations at
% steady-state

title = "KF 1dof";
controller.active_observer = 3;
% per fare exp. lungo con tutti minKF, usare exp.49 e active_observer > 2
controller.active_technique = 9;

Q = [1e-6,0,0,0;
    0,1e-4,0,0;
    0,0,1e-6,0;
    0,0,0,1e-4]; %eye(4)*1e-6;
R = [1e-6, 0;
     0, 2e-8];

[P, L, autovals, info] = icare( A_sys', C_sys', Q, R );
L = L';
controller.KF_1dof.L = L;
controller.KF_1dof.A = A_sys-L*C_sys;
controller.KF_1dof.B = [B_sys, L];
controller.KF_1dof.C = eye(4);
controller.KF_1dof.D = zeros(4,3);

A_place = [A_sys, zeros(4,1);[0,0,1,0],0];
B_place = [B_sys;0];

K = place( A_place, B_place, [-20, -50, ...
    -40.7*(0.8+sin(acos(0.8))*1i), -40.7*(0.8-sin(acos(0.8))*1i), ...
    -10] );

controller.c9.K_x = K(1:4);
controller.c9.K_v = K(end);

%% 1-dof LQG control

controller.active_observer = 3;
controller.active_technique = 9;

Q = diag( [50, 0.005, 50, 0.005, 2000] );
R = 0.5e-1;

A_place = [A_sys, zeros(4,1);[0,0,1,0,0]];
B_place = [B_sys;0];

K = lqr( A_place, B_place, Q, R );

controller.c9.Q = Q;
controller.c9.R = R;
controller.c9.K_x = K(1:4);
controller.c9.K_v = K(end);

%% 2-dof LQR control

A_sys = greybox_id_2dof.A;
B_sys = greybox_id_2dof.B;
C_sys = [1,0,0,0,0,0;
         0,0,-1,0,0,0;
         0,0,0,0,-1,0];         

%% 2-dof LQG control

controller.active_observer = 3;
controller.active_technique = 10;

Q = diag( [1e-6, 1e-4, 1e-6, 1e-4, 1e-6, 1e-4] );
R = [1e-6, 0, 0;
     0, 2e-8, 0;
     0, 0, 2e-8];

[P, L, autovals, info] = icare( A_sys', C_sys', Q, R );
L = L';
controller.KF_2dof.Q = Q;
controller.KF_2dof.R = R;
controller.KF_2dof.L = L;
controller.KF_2dof.A = A_sys-L*C_sys;
controller.KF_2dof.B = [B_sys, L];
controller.KF_2dof.C = eye(6);
controller.KF_2dof.D = zeros(6,4);

Q = diag( [50, 0.005, 50, 0.005, 50, 0.005, 1500] );
R = 0.5e-1;

A_place = [A_sys, zeros(6,1);[0,0,0,0,1,0,0]];
B_place = [B_sys;0];

K = lqr( A_place, B_place, Q, R );

controller.c10.Q = Q;
controller.c10.R = R;
controller.c10.K_x = K(1:6);
controller.c10.K_v = K(end);
