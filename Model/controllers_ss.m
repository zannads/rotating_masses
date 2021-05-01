%% Pole-placement x speed control + observer 1 dof 

A_sys = greybox_id_1dof.A;
B_sys = greybox_id_1dof.B;
C_sys = greybox_id_1dof.C;       
D_sys = greybox_id_1dof.D;

% observer
L = place( A_sys', C_sys', -[400 400.1 300 100] )';
controller.obs_1dof.L = L;
controller.obs_1dof.A = A_sys-L*C_sys;
controller.obs_1dof.B = [B_sys-L*D_sys, L];
controller.obs_1dof.C = eye(4);
controller.obs_1dof.D = zeros(4,3);

%% Pole-placement x speed control + observer 1 dof 

A_place = [A_sys,zeros(4,1);
           -C_sys(end,:),0];
B_place = [B_sys;0];
K = place( A_place, B_place, [-0, -33.8, -43.1, -43.101, -10] );

controller.c9.K_x = K(1:4);
controller.c9.K_v = K(end);

%% Pole-placement x position control + observer 1 dof 

K = place( A_sys, B_sys, [-0, -33.8, -43.1, -43.101] );

controller.c10.K_x = K(1:4);
controller.c10.K_v = 3;

%% Pole-placement x speed control + observer 2 dof

A_sys = greybox_id_2dof.A;
B_sys = greybox_id_2dof.B;
C_sys = greybox_id_2dof.C;         
D_sys = greybox_id_2dof.D;

% Observer 
L = place( A_sys', C_sys', -[400 400.1 300 100 100.1 100.2] )';
controller.obs_2dof.L = L;
controller.obs_2dof.A = A_sys-L*C_sys;
controller.obs_2dof.B = [B_sys-L*D_sys, L];
controller.obs_2dof.C = eye(6);
controller.obs_2dof.D = zeros(6,5);

%% Pole-placement x speed control + observer 2 dof

A_place = [A_sys,zeros(6,1);
           -C_sys(end,:),0];
B_place = [B_sys;0];
K = place( A_place, B_place, [-0, -34.9, ...
    -24.5*(0.72+sin(acos(0.72))*1i), -24.5*(0.72-sin(acos(0.72))*1i), ...
    -61.9*(0.72+sin(acos(0.72))*1i), -61.9*(0.72-sin(acos(0.72))*1i), -12] );

controller.c11.K_x = K(1:6);
controller.c11.K_v = K(end);

%% Pole-placement x position control + observer 2 dof

K = place( A_sys, B_sys, [-0, -34.9, ...
    -24.5*(0.72+sin(acos(0.72))*1i), -24.5*(0.72-sin(acos(0.72))*1i), ...
    -61.9*(0.72+sin(acos(0.72))*1i), -61.9*(0.72-sin(acos(0.72))*1i)] );
controller.c12.K_x = K(1:6);
controller.c12.K_v = 2;

%% Reduced order observer 1-dof

A_sys = greybox_id_1dof.A;
B_sys = greybox_id_1dof.B;
C_sys = greybox_id_1dof.C;       
D_sys = greybox_id_1dof.D;

T = zeros(4);
T(1:2,1:2) = eye(2);
T(3:4,:) = C_sys;

A_tilde = T*A_sys/T;
B_tilde = T*B_sys;
C_tilde = C_sys/T;

B_tilde_1 = B_tilde(3:4);
B_tilde_2 = B_tilde(1:2);
A_tilde_11 = A_tilde(3:4,3:4);
A_tilde_12 = A_tilde(3:4,1:2);
A_tilde_21 = A_tilde(1:2,3:4);
A_tilde_22 = A_tilde(1:2,1:2);

L = place( A_tilde_22', A_tilde_12', -[400 400.1] )';
controller.red_obs_1dof.L = L;
controller.red_obs_1dof.A = A_tilde_22-L*A_tilde_12;
controller.red_obs_1dof.B = [B_tilde_2-L*B_tilde_1, A_tilde_21-L*A_tilde_11+A_tilde_22*L-L*A_tilde_12*L];
controller.red_obs_1dof.C = eye(2);
controller.red_obs_1dof.D = zeros(2,3);

%% Pole-placement x speed control + red observer 1 dof

A_place = [A_sys,zeros(4,1);
           -C_sys(end,:),0];
B_place = [B_sys;0];
K = place( A_place, B_place, [-0, -100, -43.1*(0.72+sin(acos(0.72))*1i), -43.1*(0.72-sin(acos(0.72))*1i), -6.15] );
controller.c13.K_x = K(1:4);
controller.c13.K_v = K(end);

%% Pole-placement x position control + red observer 1 dof

K = place( A_sys, B_sys, [-0, -33.8, -43.1, -43.101] );
controller.c14.K_x = K(1:4);
controller.c14.K_v = 3;

%% Reduced order observer 2-dof

A_sys = greybox_id_2dof.A;
B_sys = greybox_id_2dof.B;
C_sys = greybox_id_2dof.C;       
D_sys = greybox_id_2dof.D;

T = zeros(6);
T(1:2,1:2) = eye(2);
T(3:6,:) = C_sys;

A_tilde = T*A_sys/T;
B_tilde = T*B_sys;
C_tilde = C_sys/T;

B_tilde_1 = B_tilde(3:6);
B_tilde_2 = B_tilde(1:2);
A_tilde_11 = A_tilde(3:6,3:6);
A_tilde_12 = A_tilde(3:6,1:2);
A_tilde_21 = A_tilde(1:2,3:6);
A_tilde_22 = A_tilde(1:2,1:2);

L = place( A_tilde_22', A_tilde_12', -[400 400.1] )';
controller.red_obs_2dof.L = L;
controller.red_obs_2dof.A = A_tilde_22-L*A_tilde_12;
controller.red_obs_2dof.B = [B_tilde_2-L*B_tilde_1, A_tilde_21-L*A_tilde_11+A_tilde_22*L-L*A_tilde_12*L];
controller.red_obs_2dof.C = eye(2);
controller.red_obs_2dof.D = zeros(2,5);

%% Pole-placement x speed control + red observer 2 dof

A_place = [A_sys,zeros(6,1);
           -C_sys(end,:),0];
B_place = [B_sys;0];
K = place( A_place, B_place, [-0, -34.9, ...
    -24.5*(0.72+sin(acos(0.72))*1i), -24.5*(0.72-sin(acos(0.72))*1i), ...
    -61.9*(0.72+sin(acos(0.72))*1i), -61.9*(0.72-sin(acos(0.72))*1i), -12] );
controller.c15.K_x = K(1:6);
controller.c15.K_v = K(end);

%% Pole-placement x position control + red observer 2 dof

K = place( A_sys, B_sys, [-0, -34.9, ...
    -24.5*(0.72+sin(acos(0.72))*1i), -24.5*(0.72-sin(acos(0.72))*1i), ...
    -61.9*(0.72+sin(acos(0.72))*1i), -61.9*(0.72-sin(acos(0.72))*1i)] );
controller.c16.K_x = K(1:6);
controller.c16.K_v = 2;

%% to avoid misunderstandings delete support variables
clear A_sys B_sys C_sys D_sys
clear A_place B_place K
