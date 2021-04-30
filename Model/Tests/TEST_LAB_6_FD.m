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
title= "test_2_1-DOF_speed_cancellazione esatta dei poli cc e sostituizione a 60 rad/s";
controller.active_technique = 1;
controller.c1.wc_v = 10;
controller.c1.wn_numNf= 43.1;
controller.c1.wn_denNf= 60;
controller.c1.psi1=8.87e-2; 
controller.c1.psi2=0.72;
controller.c1.Pf=1;
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
title = "test_3_1-DOF_pos_ kp=1.5_wc_v=6";
controller.active_technique = 2;
controller.c2.wc_v = 6; %% frequenza di taglio 10.5 rad/s
controller.c2.kp_p= 4.5;
controller.c2.wn_numNf= 43.1;
controller.c2.wn_denNf= 43.1;
controller.c2.psi1=8.87e-2;
controller.c2.psi2=0.72; % Se gli esperimenti prima è meglio 0.95 cambiarlo
controller.c2.Pf=1;

%% C2 : position
title = "test_4_1-DOF_pos_kp=10_wc_v=8";
controller.active_technique = 2;
controller.c2.kp_p = 8; 
controller.c2.wc_v = 10;
controller.c2.wn_numNf= 43.1;
controller.c2.wn_denNf= 60;
controller.c2.psi1=8.87e-2; 
controller.c2.psi2=0.72;
controller.c2.Pf=1;

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

%% 2-DOF: position










