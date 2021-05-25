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
controller.active_observer = 2;
% per fare exp. lungo con tutti minKF, usare exp.49 e active_observer > 2
controller.active_technique = 9;

Q = eye(4)*1e-6;
R = [1e-6, 0;
     0, 2e-8];

[P, L, autovals, info] = icare( A_sys', C_sys', Q, R );
L = L';
controller.KF_1dof.L = L;
controller.KF_1dof.A = A_sys-L*C_sys;
controller.KF_1dof.B = [B_sys, L];
controller.KF_1dof.C = eye(4);
controller.KF_1dof.D = zeros(4,3);

A_place = [A_sys, zeros(4,1);-C_sys, 0];
B_place = [B_sys;0];

K = place( A_place, B_place, [-20, -50, ...
    -40.7*(0.8+sin(acos(0.8))*1i), -40.7*(0.8-sin(acos(0.8))*1i), ...
    -10] );

controller.c9.K_x = K(1:4);
controller.c9.K_v = K(end);

%% 1-dof LQG control

controller.active_observer = 2;
controller.active_technique = 9;

Q = diag( [5, 0.01, 20, 0.01, 1500] );
R = 0.5e-1;

A_place = [A_sys, zeros(4,1);[0,0,1,0,0]];
B_place = [B_sys;0];

K = lqr( A_place, B_place, Q, R );

controller.c9.K_x = K(1:4);
controller.c9.K_v = K(end);

%% 2-dof LQR control

A_sys = greybox_id_2dof.A;
B_sys = greybox_id_2dof.B;
C_sys = [1,0,0,0,0,0;
         0,0,-1,0,0,0;
         0,0,0,0,-1,0];         

%% 2-dof LQG control

controller.active_observer = 2;
controller.active_technique = 10;

Q = diag( [5, 0.01, 5, 0.01, 20, 0.01, 1500] );
R = 0.5e-1;

A_place = [A_sys, zeros(6,1);[0,0,0,0,1,0,0]];
B_place = [B_sys;0];

K = lqr( A_place, B_place, Q, R );

controller.c10.K_x = K(1:6);
controller.c10.K_v = K(end);
