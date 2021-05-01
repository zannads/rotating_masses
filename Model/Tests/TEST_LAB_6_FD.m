%% 1-DOF SPEED LOOP
load("greybox_id_1dof");
A=greybox_id_1dof.A;
B=greybox_id_1dof.B;
C=greybox_id_1dof.C(2,:);
D=greybox_id_1dof.D(2,:);
G1=C/(s*eye(4)-A)*B+D;

%% C1: cancellazione esatta dei poli cc
title= "test_1_1-DOF_speed_cancellazione_esatta_dei_poli_cc";
controller.active_technique = 1;
controller.c1.wc_v = 6;
controller.c1.wn_numNf= 43.1;
controller.c1.wn_denNf= 43.1;
controller.c1.psi1=8.87e-2; 
controller.c1.psi2=0.72;
controller.c1.Pf=1;

%% C1: attenuazione  dei poli cc
title= "test_2_1-DOF_speed_attenuazione_dei_poli_cc";
controller.active_technique = 1;
controller.c1.wc_v = 6;
controller.c1.wn_numNf= 43.1-0.5;
controller.c1.wn_denNf= 43.1+0.5;
controller.c1.psi1=8.87e-2; 
controller.c1.psi2=0.72;
controller.c1.Pf=1;

%% C1: cancellazione esatta dei poli cc e sostituizione a 60 rad/s
title= "test_3_1-DOF_speed_cancellazione esatta dei poli cc e sostituizione a 60 rad/s";
controller.active_technique = 1;
controller.c1.wc_v = 10;
controller.c1.wn_numNf= 43.1;
controller.c1.wn_denNf= 60;
controller.c1.psi1=8.87e-2; 
controller.c1.psi2=0.72;
controller.c1.Pf=1;

%% sull'esperimento migliore fare sinesweep e rampa
%%
% PI-structure
controller.c1.ki_v = controller.c1.wc_v;
controller.c1.kp_v = controller.c1.wc_v/33.8;
controller.c1.Ti_v = controller.c1.kp_v/controller.c1.ki_v;
% Notch-filter
controller.c1.Nf= (controller.c1.wn_denNf^2/controller.c1.wn_numNf^2)*...
    (s^2+2*controller.c1.psi1*controller.c1.wn_numNf*s+controller.c1.wn_numNf^2)/...
    (s^2+2*controller.c1.psi2*controller.c1.wn_denNf*s+controller.c1.wn_denNf^2);


%% C2 : position
title = "test_4_1-DOF_pos_ kp=1.5_wc_v=6";
controller.active_technique = 2;
controller.c2.wc_v = 6; %% frequenza di taglio 10.5 rad/s
controller.c2.kp_p= 4.5;
controller.c2.wn_numNf= 43.1;
controller.c2.wn_denNf= 43.1;
controller.c2.psi1=8.87e-2;
controller.c2.psi2=0.72; % Se gli esperimenti prima è meglio 0.95 cambiarlo
controller.c2.Pf=1;

%% C2 : position
title = "test_5_1-DOF_pos_kp=10_wc_v=8";
controller.active_technique = 2;
controller.c2.kp_p = 8; 
controller.c2.wc_v = 10;
controller.c2.wn_numNf= 43.1;
controller.c2.wn_denNf= 60;
controller.c2.psi1=8.87e-2; 
controller.c2.psi2=0.72;
controller.c2.Pf=1;

%% su esperimento milgiore fare sinesweep e rampa

%% 
% PI-structure
controller.c2.ki_v = controller.c2.wc_v;
controller.c2.kp_v = controller.c2.wc_v/33.8;
controller.c2.Ti_v = controller.c2.kp_v/controller.c2.ki_v;
% Notch-filter
controller.c2.Nf= (controller.c2.wn_denNf^2/controller.c2.wn_numNf^2)*...
    (s^2+2*controller.c2.psi1*controller.c2.wn_numNf*s+controller.c2.wn_numNf^2)/...
    (s^2+2*controller.c2.psi2*controller.c2.wn_denNf*s+controller.c2.wn_denNf^2);

R=-controller.c2.wc_v*(s/33.8+1)/s;
Lv=R*controller.c2.Nf*G1;
Fv=Lv/(1+Lv);
Lp=Fv*controller.c2.kp_p/s;

%% 2-DOF

load("greybox_id_2dof");
A=greybox_id_2dof.A;
B=greybox_id_2dof.B;
C=greybox_id_2dof.C(4,:);
D=greybox_id_2dof.D(4,:);
G2=minreal(C/(s*eye(6)-A)*B+D);

%% 2-DOF speed loop
%% test_6_2-DOF_speed_wc_v=8_no_prefilter

title = "test_6_2-DOF_speed_wc_v=8_no_prefilter";
controller.active_technique = 3;
controller.c3.wc_v=8;
controller.c3.wn_p1=24.5;
controller.c3.psi_p1=1.37e-01;
controller.c3.wn_p2=61.9;
controller.c3.psi_p2=2.38e-02;
controller.c3.psi_nf1=0.9;
controller.c3.psi_nf2=0.9;
controller.c3.Pf=1;
controller.c3.wn_p3=100;
%% test_7_2-DOF_speed_wc_v=8_no_prefilter_rampa
title = "test_7_2-DOF_speed_wc_v=8_no_prefilter_rampa";
controller.active_technique = 3;
controller.c3.wc_v=8;
controller.c3.wn_p1=24.5;
controller.c3.psi_p1=1.37e-01;
controller.c3.wn_p2=61.9;
controller.c3.psi_p2=2.38e-02;
controller.c3.psi_nf1=0.9;
controller.c3.psi_nf2=0.9;
controller.c3.Pf=1;
controller.c3.wn_p3=100;

%% test_8_2-DOF_speed_wc_v=8_no_prefilter_sinesweep
title = "test_8_2-DOF_speed_wc_v=8_no_prefilter_sinesweep";
controller.active_technique = 3;
controller.c3.wc_v=8;
controller.c3.wn_p1=24.5;
controller.c3.psi_p1=1.37e-01;
controller.c3.wn_p2=61.9;
controller.c3.psi_p2=2.38e-02;
controller.c3.psi_nf1=0.9;
controller.c3.psi_nf2=0.9;
controller.c3.Pf=1;
controller.c3.wn_p3=100;


%% test_9_2-DOF_speed_wc_v=8_with_prefilter

title = "test_9_2-DOF_speed_wc_v=8_with_prefilter";
controller.active_technique = 3;
controller.c3.wc_v=8;
controller.c3.wn_p1=24.5;
controller.c3.psi_p1=1.37e-01;
controller.c3.wn_p2=61.9;
controller.c3.psi_p2=2.38e-02;
controller.c3.psi_nf1=0.9;
controller.c3.psi_nf2=0.9;
controller.c3.Pf=1/(s/7+1);
controller.c3.wn_p3=100;

%% test_10_2-DOF_speed_wc_v=8_with_prefilter_rampa

title = "test_10_2-DOF_speed_wc_v=8_with_prefilter_rampa";
controller.active_technique = 3;
controller.c3.wc_v=8;
controller.c3.wn_p1=24.5;
controller.c3.psi_p1=1.37e-01;
controller.c3.wn_p2=61.9;
controller.c3.psi_p2=2.38e-02;
controller.c3.psi_nf1=0.9;
controller.c3.psi_nf2=0.9;
controller.c3.Pf=1/(s/7+1);
controller.c3.wn_p3=100;

%% test_11_2-DOF_speed_wc_v=8_with_prefilter_sinesweep

title = "test_11_2-DOF_speed_wc_v=8_with_prefilter_sinesweep";
controller.active_technique = 3;
controller.c3.wc_v=8;
controller.c3.wn_p1=24.5;
controller.c3.psi_p1=1.37e-01;
controller.c3.wn_p2=61.9;
controller.c3.psi_p2=2.38e-02;
controller.c3.psi_nf1=0.9;
controller.c3.psi_nf2=0.9;
controller.c3.Pf=1/(s/7+1);
controller.c3.wn_p3=100;

%% 
% PI-structure
controller.c3.ki_v = controller.c3.wc_v;
controller.c3.kp_v = controller.c3.wc_v/34.9;
controller.c3.Ti_v = controller.c3.kp_v/controller.c3.ki_v;

% Notch-filter
Nfp1 = ...
    ((controller.c3.wn_p3)^2/(controller.c3.wn_p1)^2)*...
    (s^2+2*controller.c3.psi_p1*(controller.c3.wn_p1)*s+(controller.c3.wn_p1)^2)/...
    (s^2+2*controller.c3.psi_nf1*(controller.c3.wn_p3)*s+(controller.c3.wn_p3)^2);
Nfp2 = ...
    ((controller.c3.wn_p3)^2/(controller.c3.wn_p2)^2)*...
    (s^2+2*controller.c3.psi_p2*(controller.c3.wn_p2)*s+(controller.c3.wn_p2)^2)/...
    (s^2+2*controller.c3.psi_nf2*(controller.c3.wn_p3)*s+(controller.c3.wn_p3)^2);

controller.c3.Nf = Nfp1*Nfp2;

R=-controller.c3.wc_v*(s/34.9+1)/s;
Lv=R*controller.c3.Nf*G1;
Fv=Lv/(1+Lv);

%% 2_DOF: position loop


%% test_10_2-DOF_kp_p=2.2_wc_v=4

controller.active_technique = 4;

title = "test_10_2-DOF_kp_p=2.2_wc_v=4";

controller.c4.kp_p=2.2; %% margine di fase 71,2 
controller.c4.wc_v=4;
controller.c4.wn_p1=24.5;
controller.c4.psi_p1=1.36e-01;
controller.c4.wn_p2=61.9;
controller.c4.psi_p2=2.52e-02;
controller.c4.psi_nf1=0.72;
controller.c4.psi_nf2=0.9;
controller.c4.Pf=1;

%% test_10_2-DOF_kp_p=2.2_wc_v=4_rampa

controller.active_technique = 4;

title = "test_10_2-DOF_kp_p=2.2_wc_v=4_rampa";

controller.c4.kp_p=2.2;
controller.c4.wc_v=4;
controller.c4.wn_p1=24.5;
controller.c4.psi_p1=1.36e-01;
controller.c4.wn_p2=61.9;
controller.c4.psi_p2=2.52e-02;
controller.c4.psi_nf1=0.72;
controller.c4.psi_nf2=0.9;
controller.c4.Pf=1;

%% test_10_2-DOF_kp_p=2.2_wc_v=4_sinesweep

controller.active_technique = 4;

title = "test_10_2-DOF_kp_p=2.2_wc_v=4_sinesweep";

controller.c4.kp_p=2.2;
controller.c4.wc_v=4;
controller.c4.wn_p1=24.5;
controller.c4.psi_p1=1.36e-01;
controller.c4.wn_p2=61.9;
controller.c4.psi_p2=2.52e-02;
controller.c4.psi_nf1=0.72;
controller.c4.psi_nf2=0.9;
controller.c4.Pf=1;

%%
% PI-structure
controller.c4.ki_v = controller.c4.wc_v;
controller.c4.kp_v = controller.c4.wc_v/33.3;
controller.c4.Ti_v = controller.c4.kp_v/controller.c4.ki_v;
% Notch-filter

Nfp1 = ...
    ((controller.c4.wn_p1-0.5)^2/(controller.c4.wn_p1+0.5)^2)*...
    (s^2+2*controller.c4.psi_p1*(controller.c4.wn_p1+0.5)*s+(controller.c4.wn_p1+0.5)^2)/...
    (s^2+2*controller.c4.psi_nf1*(controller.c4.wn_p1-0.5)*s+(controller.c4.wn_p1-0.5)^2);
Nfp2 = ...
    ((controller.c4.wn_p2-0.5)^2/(controller.c4.wn_p2+0.5)^2)*...
    (s^2+2*controller.c4.psi_p2*(controller.c4.wn_p2+0.5)*s+(controller.c4.wn_p2+0.5)^2)/...
    (s^2+2*controller.c4.psi_nf2*(controller.c4.wn_p2-0.5)*s+(controller.c4.wn_p2-0.5)^2);
controller.c4.Nf = Nfp1*Nfp2;

R=-controller.c4.wc_v*(s/33.8+1)/s;
Lv=R*controller.c4.Nf*G1;
Fv=Lv/(1+Lv);
Lp=Fv*controller.c4.kp_p/s;










