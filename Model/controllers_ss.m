%% Pole-placement x speed control + observer 1 dof 

A_sys = greybox_id_1dof.A;
B_sys = greybox_id_1dof.B;
C_sys = greybox_id_1dof.C;       
D_sys = greybox_id_1dof.D;

% observer
controller.c9.L = place( A_sys', C_sys', -[400 400.1 300 100] )';
controller.c9.A_obs = A_sys-controller.c9.L*C_sys;
controller.c9.B_obs = [B_sys-controller.c9.L*D_sys, controller.c9.L];
controller.c9.C_obs = eye(4);
controller.c9.D_obs = zeros(4,3);

%poleplacement
A_place = [A_sys,zeros(4,1);
           -C_sys(end,:),0];
B_place = [B_sys;0];
K = place( A_place, B_place, [-0, -33.8, -43.1, -43.101, -10] );

controller.c9.K_x = K(1:4);
controller.c9.K_v = K(end);

%% Pole-placement x position control + observer 1 dof 
% observer
controller.c10.L = place( A_sys', C_sys', -[400 400.1 300 100] )';
controller.c10.A_obs = A_sys-controller.c10.L*C_sys;
controller.c10.B_obs = [B_sys-controller.c10.L*D_sys, controller.c10.L];
controller.c10.C_obs = eye(4);
controller.c10.D_obs = zeros(4,3);

%poleplacement
K = place( A_sys, B_sys, [-0, -33.8, -43.1, -43.101] );

controller.c10.K_x = K(1:4);
controller.c10.K_v = 3;

%% Pole-placement x speed control + observer 2 dof

A_sys = greybox_id_2dof.A;
B_sys = greybox_id_2dof.B;
C_sys = greybox_id_2dof.C;         
D_sys = greybox_id_2dof.D;

% Observer 
controller.c11.L = place( A_sys', C_sys', -[400 400.1 300 100 100.1 100.2] )';
controller.c11.A_obs = A_sys-controller.c11.L*C_sys;
controller.c11.B_obs = [B_sys-controller.c11.L*D_sys, controller.c11.L];
controller.c11.C_obs = eye(6);
controller.c11.D_obs = zeros(6,5);

%poleplacement
A_place = [A_sys,zeros(6,1);
           -C_sys(end,:),0];
B_place = [B_sys;0];
K = place( A_place, B_place, [-0, -34.9, ...
    -24.5*(0.72+sin(acos(0.72))*1i), -24.5*(0.72-sin(acos(0.72))*1i), ...
    -61.9*(0.72+sin(acos(0.72))*1i), -61.9*(0.72-sin(acos(0.72))*1i), -12] );

controller.c11.K_x = K(1:6);
controller.c11.K_v = K(end);

%% Pole-placement x position control + observer 2 dof

% % observer
% controller.c12.L = place( A_sys', C_sys', -[400 400.1 300 100 100.1 100.2] )';
% controller.c12.A_obs = A_sys-controller.c12.L*C_sys;
% controller.c12.B_obs = [B_sys-controller.c12.L*D_sys, controller.c12.L];
% controller.c12.C_obs = eye(6);
% controller.c12.D_obs = zeros(6,5);
% 
% %poleplacement
% K = place( A_sys, B_sys, [-0, -33.8, -43.1, -43.101] )
% 
% controller.c10.K_x = K(1:6);
% controller.c10.K_v = 3;

%% to avoid misunderstandings delete support variables
clear A_sys B_sys C_sys D_sys
clear A_place B_place K