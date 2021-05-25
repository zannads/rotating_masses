s=tf('s');
%% 1 DOF
%% SPEED
%% sinesweep (exp.38) & rampa (exp.37)
controller.active_technique = 1;
controller.c1.wc_v = 4.5;

controller.c1.wn_num= 40.7;
controller.c1.psi_num=2.96e-2; %5.18e-2;
controller.c1.wn_den= 40.7;
controller.c1.psi_den=0.72;

controller.c1.Pf=1;

% PI-structure
controller.c1.ki_v = controller.c1.wc_v;
controller.c1.kp_v = controller.c1.wc_v/19;
controller.c1.Ti_v = controller.c1.kp_v/controller.c1.ki_v;

% Notch-filter
controller.c1.Nf = notch_definition( controller.c1.wn_num, controller.c1.psi_num, ...
    controller.c1.wn_den, controller.c1.psi_den );

%% Position: step (exp.44) + sinesweep (exp.48 oppure 50)
controller.active_technique = 2;
controller.c2.wc_v = 4.5;
controller.c2.kp_p = 3.5;
controller.c2.wn_num= 40.7;
controller.c2.psi_num=2.96e-2; %5.18e-2;
controller.c2.wn_den= 40.7;
controller.c2.psi_den=0.72;

controller.c2.Pf=1;

% PI-structure
controller.c2.ki_v = controller.c2.wc_v;
controller.c2.kp_v = controller.c2.wc_v/19;
controller.c2.Ti_v = controller.c2.kp_v/controller.c2.ki_v;

% Notch-filter
controller.c2.Nf = notch_definition( controller.c2.wn_num, controller.c2.psi_num, ...
    controller.c2.wn_den, controller.c2.psi_den );

%% 2 DOF:
% Speed: step (exp.41) + rampa with prefilter (exp.37)
controller.active_technique = 3;

controller.c3.wc_v = 5;

controller.c3.wn_num_p1 = 24.9;
controller.c3.wn_den_p1 = 100;
controller.c3.psi_num_p1 = 1.47e-01;
controller.c3.psi_den_p1 = 0.72;

controller.c3.wn_num_p2 = 62.3;
controller.c3.wn_den_p2 = 100;
controller.c3.psi_num_p2 = 2.36e-02;
controller.c3.psi_den_p2 = 0.72;

controller.c3.Pf = 1/(s/7+1);

% PI-structure
controller.c3.ki_v = controller.c3.wc_v;
controller.c3.kp_v = controller.c3.wc_v/30.6;
controller.c3.Ti_v = controller.c3.kp_v/controller.c3.ki_v;

% Notch-filter
Nf_1 = notch_definition( controller.c3.wn_num_p1, controller.c3.psi_num_p1, ...
    controller.c3.wn_den_p1, controller.c3.psi_den_p1 );
Nf_2 = notch_definition( controller.c3.wn_num_p2, controller.c3.psi_num_p2, ...
    controller.c3.wn_den_p2, controller.c3.psi_den_p2 );
controller.c3.Nf = Nf_1 * Nf_2;

%% Speed: sinesweep senza prefiltro (exp.38)

controller.c3.wc_v = 5;

controller.c3.wn_num_p1 = 24.9;
controller.c3.wn_den_p1 = 100;
controller.c3.psi_num_p1 = 1.47e-01;
controller.c3.psi_den_p1 = 0.72;

controller.c3.wn_num_p2 = 62.3;
controller.c3.wn_den_p2 = 100;
controller.c3.psi_num_p2 = 2.36e-02;
controller.c3.psi_den_p2 = 0.72;

controller.c3.Pf = 1;

% PI-structure
controller.c3.ki_v = controller.c3.wc_v;
controller.c3.kp_v = controller.c3.wc_v/30.6;
controller.c3.Ti_v = controller.c3.kp_v/controller.c3.ki_v;

% Notch-filter
Nf_1 = notch_definition( controller.c3.wn_num_p1, controller.c3.psi_num_p1, ...
    controller.c3.wn_den_p1, controller.c3.psi_den_p1 );
Nf_2 = notch_definition( controller.c3.wn_num_p2, controller.c3.psi_num_p2, ...
    controller.c3.wn_den_p2, controller.c3.psi_den_p2 );
controller.c3.Nf = Nf_1 * Nf_2;

%% Position: 
%% step (exp.44), sinesweep (exp.48)
controller.active_technique = 4;
controller.c4.wc_v = 5;

controller.c4.wn_num_p1 = 24.9;
controller.c4.wn_den_p1 = 100;
controller.c4.psi_num_p1 = 1.47e-01;
controller.c4.psi_den_p1 = 0.72;

controller.c4.kp_p=3; %????%

controller.c4.wn_num_p2 = 62.3;
controller.c4.wn_den_p2 = 100;
controller.c4.psi_num_p2 = 2.36e-02;
controller.c4.psi_den_p2 = 0.72;

controller.c4.Pf = 1;

% PI-structure
controller.c4.ki_v = controller.c4.wc_v;
controller.c4.kp_v = controller.c4.wc_v/30.6;
controller.c4.Ti_v = controller.c4.kp_v/controller.c4.ki_v;

% Notch-filter
Nf_1 = notch_definition( controller.c4.wn_num_p1, controller.c4.psi_num_p1, ...
    controller.c4.wn_den_p1, controller.c4.psi_den_p1 );
Nf_2 = notch_definition( controller.c4.wn_num_p2, controller.c4.psi_num_p2, ...
    controller.c4.wn_den_p2, controller.c4.psi_den_p2 );
controller.c4.Nf = Nf_1 * Nf_2;
