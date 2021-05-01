%% 1-dof Pole-placement + observer

A_sys = greybox_id_1dof.A;
B_sys = greybox_id_1dof.B;
C_sys = greybox_id_1dof.C;
D_sys = greybox_id_1dof.D;

%% ORE 
title = "test 1 1-dof pole-placement + observer + loop_speed";
% Pole-placement 1-dof
controller.active_technique = 9;

A_place = [A_sys,zeros(4,1);
           -C_sys(end,:),0];
B_place = [B_sys;0];
K = place( A_place, B_place, [-0, -100, -43.1*(0.72+sin(acos(0.72))*1i), ...
    -43.1*(0.72-sin(acos(0.72))*1i), -6.15] );
controller.c9.K_x = K(1:4);
controller.c9.K_v = K(end);

%% ORE 
title = "test 2 1-dof pole-placement + observer + loop_speed";
% Pole-placement 1-dof
controller.active_technique = 9;

A_place = [A_sys,zeros(4,1);
           -C_sys(end,:),0];
B_place = [B_sys;0];
K = place( A_place, B_place, [-0, -33.8, -43.1, -43.11, -10] );
controller.c9.K_x = K(1:4);
controller.c9.K_v = K(end);

%% ORE 
title = "test 3 1-dof pole-placement + observer + loop_pos";
% Pole-placement 1-dof
controller.active_technique = 10;

% A_place = [A_sys,zeros(4,1);
%            -C_sys(1,:),0];
% B_place = [B_sys;0];
K = place( A_sys, B_sys, [-0, -33.8, -43.1, -43.101] );
controller.c10.K_x = K(1:4);
controller.c10.K_v = 3;

%% ORE 
title = "test 4 1-dof pole-placement + red observer + loop_speed";
% Pole-placement 1-dof
controller.active_technique = 13;

A_place = [A_sys,zeros(4,1);
           -C_sys(end,:),0];
B_place = [B_sys;0];
K = place( A_place, B_place, [-0, -100, -43.1*(0.72+sin(acos(0.72))*1i), ...
    -43.1*(0.72-sin(acos(0.72))*1i), -6.15] );
controller.c13.K_x = K(1:4);
controller.c13.K_v = K(end);

%% ORE 
title = "test 5 1-dof pole-placement + red observer + loop_pos";
% Pole-placement 1-dof
controller.active_technique = 14;

% A_place = [A_sys,zeros(4,1);
%            -C_sys(1,:),0];
% B_place = [B_sys;0];
K = place( A_sys, B_sys, [-0, -33.8, -43.1, -43.101] );
controller.c14.K_x = K(1:4);
controller.c14.K_v = 3;

%% to avoid misunderstandings delete support variables
clear A_sys B_sys C_sys D_sys
clear A_place B_place K
