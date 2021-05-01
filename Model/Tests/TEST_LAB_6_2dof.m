%% 2-dof Pole-placement + observer

A_sys = greybox_id_2dof.A;
B_sys = greybox_id_2dof.B;
C_sys = greybox_id_2dof.C;         
D_sys = greybox_id_2dof.D;

%% ORE 
title = "test 1 2-dof pole-placement + observer + loop_speed";
% Pole-placement 2-dof
controller.active_technique = 11;

A_place = [A_sys,zeros(6,1);
           -C_sys(end,:),0];
B_place = [B_sys;0];
K = place( A_place, B_place, [-0, -34.9, ...
    -24.5*(0.72+sin(acos(0.72))*1i), -24.5*(0.72-sin(acos(0.72))*1i), ...
    -61.9*(0.72+sin(acos(0.72))*1i), -61.9*(0.72-sin(acos(0.72))*1i), -12] );
controller.c11.K_x = K(1:6);
controller.c11.K_v = K(end);

%% ORE 
title = "test 3 2-dof pole-placement + observer + loop_pos";
% Pole-placement 2-dof
controller.active_technique = 12;

K = place( A_sys, B_sys, [-0, -34.9, ...
    -24.5*(0.72+sin(acos(0.72))*1i), -24.5*(0.72-sin(acos(0.72))*1i), ...
    -61.9*(0.72+sin(acos(0.72))*1i), -61.9*(0.72-sin(acos(0.72))*1i)] );
controller.c12.K_x = K(1:6);
controller.c12.K_v = 2;

%% ORE 
title = "test 3 2-dof pole-placement + red observer + loop_speed";
% Pole-placement 2-dof
controller.active_technique = 15;

A_place = [A_sys,zeros(6,1);
           -C_sys(end,:),0];
B_place = [B_sys;0];
K = place( A_place, B_place, [-0, -34.9, ...
    -24.5*(0.72+sin(acos(0.72))*1i), -24.5*(0.72-sin(acos(0.72))*1i), ...
    -61.9*(0.72+sin(acos(0.72))*1i), -61.9*(0.72-sin(acos(0.72))*1i), -12] );
controller.c15.K_x = K(1:6);
controller.c15.K_v = K(end);

%% ORE 
title = "test 4 2-dof pole-placement + red observer + loop_pos";
% Pole-placement 2-dof
controller.active_technique = 16;

K = place( A_sys, B_sys, [-0, -34.9, ...
    -24.5*(0.72+sin(acos(0.72))*1i), -24.5*(0.72-sin(acos(0.72))*1i), ...
    -61.9*(0.72+sin(acos(0.72))*1i), -61.9*(0.72-sin(acos(0.72))*1i)] );
controller.c16.K_x = K(1:6);
controller.c16.K_v = 2;

%% to avoid misunderstandings delete support variables
clear A_sys B_sys C_sys D_sys
clear A_place B_place K
