%% LAB 9

%% Frequency Domain
%% 1-DOF: position (sinesweep se possibile)

controller.active_technique = 7;

controller.c7.Kp_p = -2;
controller.c7.Pf = 1;

controller.c7.wn_num= 40.7;
controller.c7.psi_num=2.96e-2;
controller.c7.wn_den= 40.7;
controller.c7.psi_den=0.72;
controller.c7.Nf = notch_definition( controller.c7.wn_num, controller.c7.psi_num, ...
    controller.c7.wn_den, controller.c7.psi_den );

%% 2-DOF: position (sinesweep se possibile)

controller.active_technique = 8;

controller.c8.Kp_p = -1;
controller.c8.Pf = 1;

controller.c8.wn_num_p1 = 24.9;
controller.c8.wn_den_p1 = 100;
controller.c8.psi_num_p1 = 1.47e-01;
controller.c8.psi_den_p1 = 0.72;

controller.c8.wn_num_p2 = 62.3;
controller.c8.wn_den_p2 = 100;
controller.c8.psi_num_p2 = 2.36e-02;
controller.c8.psi_den_p2 = 0.72;

Nf_1 = notch_definition( controller.c8.wn_num_p1, controller.c8.psi_num_p1, ...
    controller.c8.wn_den_p1, controller.c8.psi_den_p1 );
Nf_2 = notch_definition( controller.c8.wn_num_p2, controller.c8.psi_num_p2, ...
    controller.c8.wn_den_p2, controller.c8.psi_den_p2 );
controller.c8.Nf = Nf_1 * Nf_2;

