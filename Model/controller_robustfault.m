%% LQG 1-dof

A_sys = greybox_id_1dof.A;
B_sys = greybox_id_1dof.B;
C_sys = [1,0,0,0;
        0,0,-1,0];

% KF classic

Q_tilde = diag( [0.3e-4, 1e-2, 1e-8, 1e-4] ); 
R_tilde = [1e-6, 0;
           0, 2e-8];

[~, L, ~, ~] = icare( A_sys', C_sys', Q_tilde, R_tilde );
L = L';
rcontroller.KF_1dof.L = L;
rcontroller.KF_1dof.Q = Q_tilde;
rcontroller.KF_1dof.R = R_tilde;
rcontroller.KF_1dof.A = A_sys-L*C_sys;
rcontroller.KF_1dof.B = [B_sys, L];
rcontroller.KF_1dof.C = eye(4);
rcontroller.KF_1dof.D = zeros(4,3);

% minKF enc 1

C_sys = [0,0,-1,0];

Q_tilde = diag( [0.3e-4, 1e-2, 1e-8, 1e-4] );
R_tilde = 2e-8;

[~, L, ~, ~] = icare( A_sys', C_sys', Q_tilde, R_tilde );
L = L';
rcontroller.minKF_1dof_enc1.L = L;
rcontroller.minKF_1dof_enc1.Q = Q_tilde;
rcontroller.minKF_1dof_enc1.R = R_tilde;
rcontroller.minKF_1dof_enc1.A = A_sys-L*C_sys;
rcontroller.minKF_1dof_enc1.B = [B_sys, L];
rcontroller.minKF_1dof_enc1.C = eye(4);
rcontroller.minKF_1dof_enc1.D = zeros(4,2);

% minKF pot

C_sys = [1,0,0,0];

Q_tilde = diag( [0.3e-4, 1e-2, 1e-8, 1e-4] );
R_tilde = 1e-6;

[~, L, ~, ~] = icare( A_sys', C_sys', Q_tilde, R_tilde );
L = L';
rcontroller.minKF_1dof_pot.L = L;
rcontroller.minKF_1dof_pot.Q = Q_tilde;
rcontroller.minKF_1dof_pot.R = R_tilde;
rcontroller.minKF_1dof_pot.A = A_sys-L*C_sys;
rcontroller.minKF_1dof_pot.B = [B_sys, L];
rcontroller.minKF_1dof_pot.C = eye(4);
rcontroller.minKF_1dof_pot.D = zeros(4,2);

% LQR fast
Q = diag( [50, 0.1, 50, 0.1, 3000] );
R = 0.8;

A_place = [A_sys, zeros(4,1);[0,0,1,0,0]];
B_place = [B_sys;0];

K = lqr( A_place, B_place, Q, R );

rcontroller.c9.t1.Q = Q;
rcontroller.c9.t1.R = R;
rcontroller.c9.t1.K_x = K(1:4);
rcontroller.c9.t1.K_v = K(end);


% LQR slow

Q = diag( [50, 1, 50, 1, 100] );
R = 0.8;

A_place = [A_sys, zeros(4,1);[0,0,1,0,0]];
B_place = [B_sys;0];

K = lqr( A_place, B_place, Q, R );

rcontroller.c9.tl.Q = Q;
rcontroller.c9.tl.R = R;
rcontroller.c9.tl.K_x = K(1:4);
rcontroller.c9.tl.K_v = K(end);

%% LQG 2-dof

A_sys = greybox_id_2dof.A;
B_sys = greybox_id_2dof.B;
C_sys = [1,0,0,0,0,0;
         0,0,-1,0,0,0;
         0,0,0,0,-1,0]; 

% KF classic
Q_tilde = diag( [0.3e-4, 1e-2, 1e-8, 1e-4, 1e-8, 1e-4] );
R_tilde = [1e-6, 0, 0;
     0, 2e-8, 0;
     0, 0, 2e-8];

[~, L, ~, ~] = icare( A_sys', C_sys', Q_tilde, R_tilde );
L = L';
rcontroller.KF_2dof.L = L;
rcontroller.KF_2dof.Q = Q_tilde;
rcontroller.KF_2dof.R = R_tilde;
rcontroller.KF_2dof.A = A_sys-L*C_sys;
rcontroller.KF_2dof.B = [B_sys, L];
rcontroller.KF_2dof.C = eye(6);
rcontroller.KF_2dof.D = zeros(6,4);

% minKF enc 2

C_sys=[0,0,0,0,-1,0];
Q_tilde = diag( [0.3e-4, 1e-2, 1e-8, 1e-4, 1e-8, 1e-4] );
R_tilde = 2e-8;

[~, L, ~, ~] = icare( A_sys', C_sys', Q_tilde, R_tilde );
L = L';
rcontroller.minKF_2dof_enc2.L = L;
rcontroller.minKF_2dof_enc2.Q = Q_tilde;
rcontroller.minKF_2dof_enc2.R = R_tilde;
rcontroller.minKF_2dof_enc2.A = A_sys-L*C_sys;
rcontroller.minKF_2dof_enc2.B = [B_sys, L];
rcontroller.minKF_2dof_enc2.C = eye(6);
rcontroller.minKF_2dof_enc2.D = zeros(6,2);

% minKF pot+enc2

C_sys=[1,0,0,0,0,0;
       0,0,0,0,-1,0];
Q_tilde = diag( [0.3e-4, 1e-2, 1e-8, 1e-4, 1e-8, 1e-4] );
R_tilde = [1e-6, 0; 0,2e-8];

[~, L, ~, ~] = icare( A_sys', C_sys', Q_tilde, R_tilde );
L = L';
rcontroller.minKF_2dof_potenc2.L = L;
rcontroller.minKF_2dof_potenc2.Q = Q_tilde;
rcontroller.minKF_2dof_potenc2.R = R_tilde;
rcontroller.minKF_2dof_potenc2.A = A_sys-L*C_sys;
rcontroller.minKF_2dof_potenc2.B = [B_sys, L];
rcontroller.minKF_2dof_potenc2.C = eye(6);
rcontroller.minKF_2dof_potenc2.D = zeros(6,3);


% minKF enc1+enc2

C_sys=[0,0,-1,0,0,0;
       0,0,0,0,-1,0];
Q_tilde = diag( [0.3e-4, 1e-2, 1e-8, 1e-4, 1e-8, 1e-4] );
R_tilde = [2e-8, 0; 0,2e-8];

[~, L, ~, ~] = icare( A_sys', C_sys', Q_tilde, R_tilde );
L = L';
rcontroller.minKF_2dof_enc1enc2.L = L;
rcontroller.minKF_2dof_enc1enc2.Q = Q_tilde;
rcontroller.minKF_2dof_enc1enc2.R = R_tilde;
rcontroller.minKF_2dof_enc1enc2.A = A_sys-L*C_sys;
rcontroller.minKF_2dof_enc1enc2.B = [B_sys, L];
rcontroller.minKF_2dof_enc1enc2.C = eye(6);
rcontroller.minKF_2dof_enc1enc2.D = zeros(6,3);

% minKF enc 1

C_sys=[0,0,-1,0,0,0];
Q_tilde = diag( [0.3e-4, 1e-2, 1e-8, 1e-4, 1e-8, 1e-4] );
R_tilde = 2e-8;

[~, L, ~, ~] = icare( A_sys', C_sys', Q_tilde, R_tilde );
L = L';
rcontroller.minKF_2dof_enc1.L = L;
rcontroller.minKF_2dof_enc1.Q = Q_tilde;
rcontroller.minKF_2dof_enc1.R = R_tilde;
rcontroller.minKF_2dof_enc1.A = A_sys-L*C_sys;
rcontroller.minKF_2dof_enc1.B = [B_sys, L];
rcontroller.minKF_2dof_enc1.C = eye(6);
rcontroller.minKF_2dof_enc1.D = zeros(6,2);

% minKF pot+enc1

C_sys=[1,0,0,0,0,0;
       0,0,-1,0,0,0];
Q_tilde = diag( [0.3e-4, 1e-2, 1e-8, 1e-4, 1e-8, 1e-4] );
R_tilde = [1e-6, 0; 0,2e-8];

[~, L, ~, ~] = icare( A_sys', C_sys', Q_tilde, R_tilde );
L = L';
rcontroller.minKF_2dof_potenc1.L = L;
rcontroller.minKF_2dof_potenc1.Q = Q_tilde;
rcontroller.minKF_2dof_potenc1.R = R_tilde;
rcontroller.minKF_2dof_potenc1.A = A_sys-L*C_sys;
rcontroller.minKF_2dof_potenc1.B = [B_sys, L];
rcontroller.minKF_2dof_potenc1.C = eye(6);
rcontroller.minKF_2dof_potenc1.D = zeros(6,3);

% minKF pot

C_sys=[1,0,0,0,0,0];
Q_tilde = diag( [0.3e-4, 1e-2, 1e-8, 1e-4, 1e-8, 1e-4] );
R_tilde = 1e-6;

[~, L, ~, ~] = icare( A_sys', C_sys', Q_tilde, R_tilde );
L = L';
rcontroller.minKF_2dof_pot.L = L;
rcontroller.minKF_2dof_pot.Q = Q_tilde;
rcontroller.minKF_2dof_pot.R = R_tilde;
rcontroller.minKF_2dof_pot.A = A_sys-L*C_sys;
rcontroller.minKF_2dof_pot.B = [B_sys, L];
rcontroller.minKF_2dof_pot.C = eye(6);
rcontroller.minKF_2dof_pot.D = zeros(6,2);

% LQR fast
Q = diag( [10, 0.8, 10, 0.8, 80, 0.8, 4500] );
R = 2.5;

A_place = [A_sys, zeros(6,1);[0,0,0,0,1,0,0]];
B_place = [B_sys;0];

K = lqr( A_place, B_place, Q, R );

rcontroller.c10.t2.Q = Q;
rcontroller.c10.t2.R = R;
rcontroller.c10.t2.K_x = K(1:6);
rcontroller.c10.t2.K_v = K(end);

% LQR slow

Q = diag( [10, 0.1, 10, 0.1, 10, 0.1, 20] );
R = 40;

A_place = [A_sys, zeros(6,1);[0,0,0,0,1,0,0]];
B_place = [B_sys;0];

K = lqr( A_place, B_place, Q, R );

rcontroller.c10.tl.Q = Q;
rcontroller.c10.tl.R = R;
rcontroller.c10.tl.K_x = K(1:6);
rcontroller.c10.tl.K_v = K(end);

%% to avoid misunderstandings delete support variables

clear A_sys B_sys C_sys D_sys
clear Q_tilde R_tilde Q R 
