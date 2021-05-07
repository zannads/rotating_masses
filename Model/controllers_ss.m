%% Pole-placement x speed control + observer 1 dof 
controller.active_observer = 0; 

A_sys = greybox_id_1dof.A;
B_sys = greybox_id_1dof.B;
C_sys = [1,0,0,0;
        0,0,-1,0];
D_sys = zeros(2,1);

% observer
L = place( A_sys', C_sys', -[400 400.1 400.2 400.3] )';
controller.obs_1dof.L = L;
controller.obs_1dof.A = A_sys-L*C_sys;
controller.obs_1dof.B = [B_sys, L];
controller.obs_1dof.C = eye(4);
controller.obs_1dof.D = zeros(4,3);

%% Reduced order observer 1-dof

% T = zeros(4);
% T(1:2,1:2) = eye(2);
% T(3:4,:) = C_sys;
% 
% A_tilde = T*A_sys/T;
% B_tilde = T*B_sys;
% %C_tilde = C_sys/T;
% 
% B_tilde_1 = B_tilde(3:4);
% B_tilde_2 = B_tilde(1:2);
% A_tilde_11 = A_tilde(3:4,3:4);
% A_tilde_12 = A_tilde(3:4,1:2);
% A_tilde_21 = A_tilde(1:2,3:4);
% A_tilde_22 = A_tilde(1:2,1:2);
% 
% L = place( A_tilde_22', A_tilde_12', -[400 400.1] )';
% controller.red_obs_1dof.L = L;
% controller.red_obs_1dof.A = A_tilde_22-L*A_tilde_12;
% controller.red_obs_1dof.B = [B_tilde_2-L*B_tilde_1, A_tilde_21-L*A_tilde_11+A_tilde_22*L-L*A_tilde_12*L];
% controller.red_obs_1dof.C = eye(2);
% controller.red_obs_1dof.D = zeros(2,3);

%% Kalman Filter 1 dof
controller.active_observer = 2; 

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

%% KF with 1 dof, minimum sensors
controller.active_observer = 3; 

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

%% Pole-placement x pos control + observer 1 dof

A_place = [A_sys, zeros(4,1);[0,0,1,0,0]];
B_place = [B_sys;0];

K = place( A_place, B_place, [-50, -60, -60.1, -40, -10] );

controller.c9.K_x = K(1:4);
controller.c9.K_v = K(end);

%% Pole-placement x speed control + observer 2 dof

A_sys = greybox_id_2dof.A;
B_sys = greybox_id_2dof.B;
C_sys = [1,0,0,0,0,0;
         0,0,-1,0,0,0;
         0,0,0,0,-1,0];         

% Observer 
L = place( A_sys', C_sys', -[400 400.1 300 300.1 400.2 400.3] )';
controller.obs_2dof.L = L;
controller.obs_2dof.A = A_sys-L*C_sys;
controller.obs_2dof.B = [B_sys, L];
controller.obs_2dof.C = eye(6);
controller.obs_2dof.D = zeros(6,4);

%% Reduced order observer 2-dof

% T = zeros(6);
% T(1:2,1:2) = eye(2);
% T(3:6,:) = C_sys;
% 
% A_tilde = T*A_sys/T;
% B_tilde = T*B_sys;
% %C_tilde = C_sys/T;
% 
% B_tilde_1 = B_tilde(3:6);
% B_tilde_2 = B_tilde(1:2);
% A_tilde_11 = A_tilde(3:6,3:6);
% A_tilde_12 = A_tilde(3:6,1:2);
% A_tilde_21 = A_tilde(1:2,3:6);
% A_tilde_22 = A_tilde(1:2,1:2);
% 
% L = place( A_tilde_22', A_tilde_12', -[400 400.1] )';
% controller.red_obs_2dof.L = L;
% controller.red_obs_2dof.A = A_tilde_22-L*A_tilde_12;
% controller.red_obs_2dof.B = [B_tilde_2-L*B_tilde_1, A_tilde_21-L*A_tilde_11+A_tilde_22*L-L*A_tilde_12*L];
% controller.red_obs_2dof.C = eye(2);
% controller.red_obs_2dof.D = zeros(2,5);

%% Kalman Filter 2 dof
controller.active_observer = 2; 

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

%% Pole-placement x position control + observer 2 dof
A_place = [A_sys, zeros(6,1);[0,0,0,0,1,0,0]];
B_place = [B_sys;0];


K = place( A_place, B_place, [-10, -34.9, ...
    -24.5*(0.9+sin(acos(0.9))*1i), -24.5*(0.9-sin(acos(0.9))*1i), ...
    -61.9*(0.9+sin(acos(0.9))*1i), -61.9*(0.9-sin(acos(0.9))*1i), -80] );
controller.c10.K_x = K(1:6);
controller.c10.K_v = K(end);

%% to avoid misunderstandings delete support variables
clear A_sys B_sys C_sys D_sys
clear A_place B_place K
