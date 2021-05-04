%% 1_DOF: speed loop

%% C1: cancellazione esatta dei poli cc
title= "1-DOF_speed_cancellazione_esatta_dei_poli_cc";

controller.active_technique = 1;

controller.c1.wc_v = 6;

controller.c1.wn_num= 43.1;
controller.c1.psi_num=8.87e-2;
controller.c1.wn_den= 43.1;
controller.c1.psi_den=0.72;

controller.c1.Pf=1;

% PI-structure
controller.c1.ki_v = controller.c1.wc_v;
controller.c1.kp_v = controller.c1.wc_v/33.8;
controller.c1.Ti_v = controller.c1.kp_v/controller.c1.ki_v;

% Notch-filter
controller.c1.Nf = notch_definition( controller.c1.wn_num, controller.c1.psi_num, ...
    controller.c1.wn_den, controller.c1.psi_den );

% %% C1: attenuazione  dei poli cc
% title= "test_2_1-DOF_speed_attenuazione_dei_poli_cc";
% controller.active_technique = 1;
% 
% controller.c1.wc_v = 6;
% 
% controller.c1.wn_num = 43.1 - 0.5;
% controller.c1.psi_num = 8.87e-2; %5.18e-2;
% controller.c1.wn_den = 43.1 + 0.5;
% controller.c1.psi_den = 0.72;
% 
% controller.c1.Pf = 1;
% 
% % PI-structure
% controller.c1.ki_v = controller.c1.wc_v;
% controller.c1.kp_v = controller.c1.wc_v/33.8;
% controller.c1.Ti_v = controller.c1.kp_v/controller.c1.ki_v;
% 
% % Notch-filter
% controller.c1.Nf = notch_definition( controller.c1.wn_num, controller.c1.psi_num, ...
%     controller.c1.wn_den, controller.c1.psi_den );


%% C1: cancellazione esatta dei poli cc e sostituizione a 60 rad/s
title= "1-DOF_speed_cancellazione esatta dei poli cc e sostituizione a 60 rad/s";
controller.active_technique = 1;

controller.c1.wc_v = 10;

controller.c1.wn_num = 43.1;
controller.c1.psi_num = 8.87e-2; %5.18e-2;
controller.c1.wn_den = 60;
controller.c1.psi_den = 0.72;

controller.c1.Pf = 1;

% PI-structure
controller.c1.ki_v = controller.c1.wc_v;
controller.c1.kp_v = controller.c1.wc_v/33.8;
controller.c1.Ti_v = controller.c1.kp_v/controller.c1.ki_v;

% Notch-filter
controller.c1.Nf = notch_definition( controller.c1.wn_num, controller.c1.psi_num, ...
    controller.c1.wn_den, controller.c1.psi_den );

%% sull'esperimento migliore fare sinesweep e rampa

%% 1-DOF: position loop: 
% NB scegliere inner loop preferito

%% C2 : 

title = "1-DOF_pos_kp=4.5_wc_v=6";
controller.active_technique = 2;

controller.c2.wc_v = 6;
controller.c2.kp_p= 4.5;
controller.c2.wn_num = 43.1;
controller.c2.psi_num =8.87e-2;
controller.c2.wn_den = 43.1;
controller.c2.psi_den =0.72; % Se gli esperimenti prima è meglio 0.95 cambiarlo

controller.c2.Pf = 1;

% PI-structure
controller.c2.ki_v = controller.c2.wc_v;
controller.c2.kp_v = controller.c2.wc_v/33.8;
controller.c2.Ti_v = controller.c2.kp_v/controller.c2.ki_v;
% Notch-filter
controller.c2.Nf = notch_definition( controller.c2.wn_num, controller.c2.psi_num, ...
    controller.c2.wn_den, controller.c2.psi_den );

%% C2 : 
title = "1-DOF_pos_kp=8_wc_v=10";
controller.active_technique = 2;

controller.c2.kp_p = 8; 
controller.c2.wc_v = 10;

controller.c2.wn_num = 43.1;
controller.c2.psi_num = 8.87e-2;
controller.c2.wn_den = 60;
controller.c2.psi_den = 0.72; % Se gli esperimenti prima è meglio 0.95 cambiarlo

controller.c2.Pf = 1;

% PI-structure
controller.c2.ki_v = controller.c2.wc_v;
controller.c2.kp_v = controller.c2.wc_v/33.8;
controller.c2.Ti_v = controller.c2.kp_v/controller.c2.ki_v;

% Notch-filter
controller.c2.Nf = notch_definition( controller.c2.wn_num, controller.c2.psi_num, ...
    controller.c2.wn_den, controller.c2.psi_den );

%% su esperimento milgiore fare sinesweep

%% 2-DOF: speed loop
%% 2-DOF_speed_wc_v=8_no_prefilter_sinesweep
title = "2-DOF_speed_wc_v=8_no_prefilter_sinesweep";
controller.active_technique = 3;

controller.c3.wc_v = 8;

controller.c3.wn_num_p1 = 24.5;
controller.c3.psi_num_p1 = 1.37e-01;
controller.c3.wn_den_p1 = 60;
controller.c3.psi_den_p1 = 0.72;

controller.c3.wn_num_p2 = 61.9;
controller.c3.wn_den_p2 = 100;
controller.c3.psi_num_p2 = 2.38e-02;
controller.c3.psi_den_p2 = 0.9;

controller.c3.Pf = 1;

% PI-structure
controller.c3.ki_v = controller.c3.wc_v;
controller.c3.kp_v = controller.c3.wc_v/34.9;
controller.c3.Ti_v = controller.c3.kp_v/controller.c3.ki_v;

% Notch-filter
Nf_1 = notch_definition( controller.c3.wn_num_p1, controller.c3.psi_num_p1, ...
    controller.c3.wn_den_p1, controller.c3.psi_den_p1 );
Nf_2 = notch_definition( controller.c3.wn_num_p2, controller.c3.psi_num_p2, ...
    controller.c3.wn_den_p2, controller.c3.psi_den_p2 );
controller.c3.Nf = Nf_1 * Nf_2;

%% 2-DOF_speed_wc_v=8_with_prefilter

title = "2-DOF_speed_wc_v=8_with_prefilter_step";
controller.active_technique = 3;

controller.c3.wc_v = 8;

controller.c3.wn_num_p1 = 24.5;
controller.c3.psi_num_p1 = 1.37e-01;
controller.c3.wn_den_p1 = 60;
controller.c3.psi_den_p1 = 0.72;

controller.c3.wn_num_p2 = 61.9;
controller.c3.wn_den_p2 = 100;
controller.c3.psi_num_p2 = 2.38e-02;
controller.c3.psi_den_p2 = 0.9;

controller.c3.Pf = 1/(s/7+1);

% PI-structure
controller.c3.ki_v = controller.c3.wc_v;
controller.c3.kp_v = controller.c3.wc_v/34.9;
controller.c3.Ti_v = controller.c3.kp_v/controller.c3.ki_v;

% Notch-filter
Nf_1 = notch_definition( controller.c3.wn_num_p1, controller.c3.psi_num_p1, ...
    controller.c3.wn_den_p1, controller.c3.psi_den_p1 );
Nf_2 = notch_definition( controller.c3.wn_num_p2, controller.c3.psi_num_p2, ...
    controller.c3.wn_den_p2, controller.c3.psi_den_p2 );
controller.c3.Nf = Nf_1 * Nf_2;

%% 2_DOF: position loop

%% 2-DOF_kp_p=2.2_wc_v=4
title = "2-DOF_kp_p=3_wc_v=5_step";

controller.active_technique = 4;

controller.c4.kp_p = 3; %% margine di fase 71,2 
controller.c4.wc_v = 4;

controller.c4.wn_num_p1 = 24.5 ;
controller.c4.psi_num_p1 = 1.37e-01;
controller.c4.wn_den_p1 = 60;
controller.c4.psi_den_p1 = 0.72;

controller.c4.wn_num_p2 = 61.9;
controller.c4.wn_den_p2 = 100;
controller.c4.psi_num_p2 = 2.38e-02;
controller.c4.psi_den_p2 = 0.9;

controller.c4.Pf = 1;

% PI-structure
controller.c4.ki_v = controller.c4.wc_v;
controller.c4.kp_v = controller.c4.wc_v/34.9;
controller.c4.Ti_v = controller.c4.kp_v/controller.c4.ki_v;

% Notch-filter
Nf_1 = notch_definition( controller.c4.wn_num_p1, controller.c4.psi_num_p1, ...
    controller.c4.wn_den_p1, controller.c4.psi_den_p1 );
Nf_2 = notch_definition( controller.c4.wn_num_p2, controller.c4.psi_num_p2, ...
    controller.c4.wn_den_p2, controller.c4.psi_den_p2 );
controller.c4.Nf = Nf_1 * Nf_2;


%% 2-DOF_kp_p=2.2_wc_v=4_sinesweep

title = "2-DOF_kp_p=3_wc_v=5_sinesweep";

controller.active_technique = 4;

controller.c4.kp_p = 3; %% margine di fase 71,2 
controller.c4.wc_v = 5;

controller.c4.wn_num_p1 = 24.5;
controller.c4.psi_num_p1 = 1.37e-01;
controller.c4.wn_den_p1 = 60;
controller.c4.psi_den_p1 = 0.72;

controller.c4.wn_num_p2 = 61.9;
controller.c4.wn_den_p2 = 100;
controller.c4.psi_num_p2 = 2.38e-02;
controller.c4.psi_den_p2 = 0.9;

controller.c4.Pf = 1;

% PI-structure
controller.c4.ki_v = controller.c4.wc_v;
controller.c4.kp_v = controller.c4.wc_v/34.9;
controller.c4.Ti_v = controller.c4.kp_v/controller.c4.ki_v;

% Notch-filter
Nf_1 = notch_definition( controller.c4.wn_num_p1, controller.c4.psi_num_p1, ...
    controller.c4.wn_den_p1, controller.c4.psi_den_p1 );
Nf_2 = notch_definition( controller.c4.wn_num_p2, controller.c4.psi_num_p2, ...
    controller.c4.wn_den_p2, controller.c4.psi_den_p2 );
controller.c4.Nf = Nf_1 * Nf_2;
