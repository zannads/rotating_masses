load( 'greybox_id_1dof.mat', 'greybox_id_1dof' );
load( 'blackbox_id_1dof.mat', 'blackbox_id_1dof' );
load( 'greybox_id_2dof.mat', 'greybox_id_2dof' );
load( 'blackbox_id_2dof.mat', 'blackbox_id_2dof' );

s=tf('s');
controller.active_technique = 0;

%% C1
% controller.active_technique = 1;
controller.c1.wc_v = 3.5;
controller.c1.wn_numNf= 42;
controller.c1.wn_denNf= 41;
controller.c1.psi1=8.3e-2; %5.18e-2;
controller.c1.psi2=0.72;
controller.c1.Pf=1;

% PI-structure
controller.c1.ki_v = controller.c1.wc_v;
controller.c1.kp_v = controller.c1.wc_v/33.4;
controller.c1.Ti_v = controller.c1.kp_v/controller.c1.ki_v;
% Notch-filter
controller.c1.Nf= (controller.c1.wn_denNf^2/controller.c1.wn_numNf^2)*...
    (s^2+2*controller.c1.psi1*controller.c1.wn_numNf*s+controller.c1.wn_numNf^2)/...
    (s^2+2*controller.c1.psi2*controller.c1.wn_denNf*s+controller.c1.wn_denNf^2);

%% C2
% controller.active_technique = 2;
controller.c2.wc_v = 5;
controller.c2.kp_p= 6;
controller.c2.wn_numNf= 42;
controller.c2.wn_denNf= 41;
controller.c2.psi1=8.3e-2;
controller.c2.psi2=0.72; % Se gli esperimenti prima è meglio 0.95 cambiarlo
controller.c2.Pf=1;
% PI-structure
controller.c2.ki_v = controller.c2.wc_v;
controller.c2.kp_v = controller.c2.wc_v/33.4;
controller.c2.Ti_v = controller.c2.kp_v/controller.c2.ki_v;
% Notch-filter
controller.c2.Nf= (controller.c2.wn_denNf^2/controller.c2.wn_numNf^2)*...
    (s^2+2*controller.c2.psi1*controller.c2.wn_numNf*s+controller.c2.wn_numNf^2)/...
    (s^2+2*controller.c2.psi2*controller.c2.wn_denNf*s+controller.c2.wn_denNf^2);

%% C3
% controller.active_technique = 3;
controller.c3.wc_v=5;
controller.c3.wn_p1=24.5;
controller.c3.psi_p1=1.36e-01;
controller.c3.wn_p2=61.9;
controller.c3.psi_p2=2.52e-02;
controller.c3.psi_nf1=0.72;
controller.c3.psi_nf2=0.9;
controller.c3.Pf=1;

% PI-structure
controller.c3.ki_v = controller.c3.wc_v;
controller.c3.kp_v = controller.c3.wc_v/33.3;
controller.c3.Ti_v = controller.c3.kp_v/controller.c3.ki_v;
% Notch-filter

Nfp1 = ...
    ((controller.c3.wn_p1-0.5)^2/(controller.c3.wn_p1+0.5)^2)*...
    (s^2+2*controller.c3.psi_p1*(controller.c3.wn_p1+0.5)*s+(controller.c3.wn_p1+0.5)^2)/...
    (s^2+2*controller.c3.psi_nf1*(controller.c3.wn_p1-0.5)*s+(controller.c3.wn_p1-0.5)^2);
Nfp2 = ...
    ((controller.c3.wn_p2-0.5)^2/(controller.c3.wn_p2+0.5)^2)*...
    (s^2+2*controller.c3.psi_p2*(controller.c3.wn_p2+0.5)*s+(controller.c3.wn_p2+0.5)^2)/...
    (s^2+2*controller.c3.psi_nf2*(controller.c3.wn_p2-0.5)*s+(controller.c3.wn_p2-0.5)^2);
controller.c3.Nf = Nfp1*Nfp2;


%% C4
% controller.active_technique = 4;
controller.c4.kp_p=2.2;
controller.c4.wc_v=3;
controller.c4.wn_p1=24.5;
controller.c4.psi_p1=1.36e-01;
controller.c4.wn_p2=61.9;
controller.c4.psi_p2=2.52e-02;
controller.c4.psi_nf1=0.72;
controller.c4.psi_nf2=0.9;
controller.c4.Pf=1;
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

%% 1dof PID + notch speed
% controller.active_technique = 5;

controller.c5.Kp = -0.656;
controller.c5.Ki = -2.71;
controller.c5.Kd = -0.0397;

controller.c5.wn = 41.8;
controller.c5.wn_numNf= controller.c5.wn+0.5;
controller.c5.wn_denNf= controller.c5.wn-0.5;
controller.c5.psi1=8.3e-2;
controller.c5.psi2=0.72;
controller.c5.Pf=1/(s/10+1);

controller.c5.Nf= (controller.c5.wn_denNf^2/controller.c5.wn_numNf^2)*...
    (s^2+2*controller.c5.psi1*controller.c5.wn_numNf*s+controller.c5.wn_numNf^2)/...
    (s^2+2*controller.c5.psi2*controller.c5.wn_denNf*s+controller.c5.wn_denNf^2);


%% 2 dof PID + notch speed + pre filter
% controller.active_technique = 6;

controller.c6.Kp = -0.656;
controller.c6.Ki = -2.71;
controller.c6.Kd = -0.0397;

controller.c6.wn_p1=24.5;
controller.c6.psi_p1=1.36e-01;
controller.c6.wn_p2=61.9;
controller.c6.psi_p2=2.52e-02;
controller.c6.psi_nf1=0.72;
controller.c6.psi_nf2=0.9;

Nfp1 = ...
    ((controller.c6.wn_p1-0.5)^2/(controller.c6.wn_p1+0.5)^2)*...
    (s^2+2*controller.c6.psi_p1*(controller.c6.wn_p1+0.5)*s+(controller.c6.wn_p1+0.5)^2)/...
    (s^2+2*controller.c6.psi_nf1*(controller.c6.wn_p1-0.5)*s+(controller.c6.wn_p1-0.5)^2);
Nfp2 = ...
    ((controller.c6.wn_p2-0.5)^2/(controller.c6.wn_p2+0.5)^2)*...
    (s^2+2*controller.c6.psi_p2*(controller.c6.wn_p2+0.5)*s+(controller.c6.wn_p2+0.5)^2)/...
    (s^2+2*controller.c6.psi_nf2*(controller.c6.wn_p2-0.5)*s+(controller.c6.wn_p2-0.5)^2);
controller.c6.Nf = Nfp1*Nfp2;

controller.c6.Pf=1;

%% 1DOF PID + notch speed + pre filter + position

controller.c7.Kp = -0.656;
controller.c7.Ki = -2.71;
controller.c7.Kd = -0.0397;

controller.c7.wn = 41.8;
controller.c7.wn_numNf= controller.c7.wn+0.5;
controller.c7.wn_denNf= controller.c5.wn-0.5;
controller.c7.psi1=8.3e-2;
controller.c7.psi2=0.72;
controller.c7.Pf=1;

controller.c7.Nf= (controller.c7.wn_denNf^2/controller.c7.wn_numNf^2)*...
    (s^2+2*controller.c7.psi1*controller.c7.wn_numNf*s+controller.c7.wn_numNf^2)/...
    (s^2+2*controller.c7.psi2*controller.c7.wn_denNf*s+controller.c7.wn_denNf^2);

controller.c7.kp_p = 6;

%% 2DOF PID + notch speed + pre filter + position 

% controller.active_technique = 8;

controller.c8.Kp = -0.656;
controller.c8.Ki = -2.71;
controller.c8.Kd = -0.0397;

controller.c8.wn_p1=24.5;
controller.c8.psi_p1=1.36e-01;
controller.c8.wn_p2=61.9;
controller.c8.psi_p2=2.52e-02;
controller.c8.psi_nf1=0.72;
controller.c8.psi_nf2=0.9;

Nfp1 = ...
    ((controller.c8.wn_p1-0.5)^2/(controller.c8.wn_p1+0.5)^2)*...
    (s^2+2*controller.c8.psi_p1*(controller.c8.wn_p1+0.5)*s+(controller.c8.wn_p1+0.5)^2)/...
    (s^2+2*controller.c8.psi_nf1*(controller.c8.wn_p1-0.5)*s+(controller.c8.wn_p1-0.5)^2);
Nfp2 = ...
    ((controller.c8.wn_p2-0.5)^2/(controller.c8.wn_p2+0.5)^2)*...
    (s^2+2*controller.c8.psi_p2*(controller.c8.wn_p2+0.5)*s+(controller.c8.wn_p2+0.5)^2)/...
    (s^2+2*controller.c8.psi_nf2*(controller.c8.wn_p2-0.5)*s+(controller.c8.wn_p2-0.5)^2);
controller.c8.Nf = Nfp1*Nfp2;

controller.c8.Pf=1;
controller.c8.kp_p = 2.2;

controllers_ss;

%% to avoid misunderstandings delete support variables
clear Nfp1 Nfp2