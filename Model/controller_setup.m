s=tf('s');

%% C1
controller.active_technique = 0;

controller.c1.wc_v = 4;
controller.c1.wn_numNf= 40;
controller.c1.wn_denNf= 41;
controller.c1.psi1=5.22e-2; %5.18e-2;
controller.c1.psi2=0.72;
controller.c1.Pf=1;

%% PI-structure
controller.c1.ki_v = controller.c1.wc_v;
controller.c1.kp_v = controller.c1.wc_v/32.6;
controller.c1.Ti_v = controller.c1.kp_v/controller.c1.ki_v;
%% Notch-filter
controller.c1.Nf= (controller.c1.wn_denNf^2/controller.c1.wn_numNf^2)*...
    (s^2+2*controller.c1.psi1*controller.c1.wn_numNf*s+controller.c1.wn_numNf^2)/...
    (s^2+2*controller.c1.psi2*controller.c1.wn_denNf*s+controller.c1.wn_denNf^2);

%% C2
controller.c2.wc_v = 10;
controller.c2.kp_p= 6;
controller.c2.wn_numNf= 40;
controller.c2.wn_denNf= 41;
controller.c2.psi1=5.22e-2;
controller.c2.psi2=0.72; % Se gli esperimenti prima è meglio 0.95 cambiarlo
controller.c2.Pf=(s/controller.c2.kp_p+1)/(s/8+1);
%% PI-structure
controller.c2.ki_v = controller.c2.wc_v;
controller.c2.kp_v = controller.c2.wc_v/32.6;
controller.c2.Ti_v = controller.c2.kp_v/controller.c2.ki_v;
%% Notch-filter
controller.c2.Nf= (controller.c2.wn_denNf^2/controller.c2.wn_numNf^2)*...
    (s^2+2*controller.c2.psi1*controller.c2.wn_numNf*s+controller.c2.wn_numNf^2)/...
    (s^2+2*controller.c2.psi2*controller.c2.wn_denNf*s+controller.c2.wn_denNf^2);

%% C3
controller.c3.wc_v=4;
controller.c3.psi_nf=0.9;
controller.c3.Pf=1;

%% PI-structure
controller.c3.ki_v = controller.c3.wc_v;
controller.c3.kp_v = controller.c3.wc_v/31.6;
controller.c3.Ti_v = controller.c3.kp_v/controller.c3.ki_v;
%% Notch-filter
controller.c3.wn_p1=24.8;
controller.c3.psi_p1=9.38e-02;

controller.c3.wn_p2=62.3;
controller.c3.psi_p2=6.66e-03;

Nfp1 = ...
    ((controller.c3.wn_p1-0.5)^2/(controller.c3.wn_p1+0.5)^2)*...
    (s^2+2*controller.c3.psi_p1*(controller.c3.wn_p1+0.5)*s+(controller.c3.wn_p1+0.5)^2)/...
    (s^2+2*controller.c3.psi_nf*(controller.c3.wn_p1-0.5)*s+(controller.c3.wn_p1-0.5)^2);
Nfp2 = ...
    ((controller.c3.wn_p2-0.5)^2/(controller.c3.wn_p2+0.5)^2)*...
    (s^2+2*controller.c3.psi_p2*(controller.c3.wn_p2+0.5)*s+(controller.c3.wn_p2+0.5)^2)/...
    (s^2+2*controller.c3.psi_nf*(controller.c3.wn_p2-0.5)*s+(controller.c3.wn_p2-0.5)^2);
controller.c3.Nf = Nfp1*Nfp2;


%% C4
controller.c4.wc_v=3;
controller.c4.kp_p=2.4;
controller.c4.psi_nf=0.9;
controller.c4.Pf=1;
%% PI-structure
controller.c4.ki_v = controller.c4.wc_v;
controller.c4.kp_v = controller.c4.wc_v/31.6;
controller.c4.Ti_v = controller.c4.kp_v/controller.c4.ki_v;
%% Notch-filter
controller.c4.wn_p1=24.8;
controller.c4.psi_p1=9.38e-02;

controller.c4.wn_p2=62.3;
controller.c4.psi_p2=6.66e-03;

Nfp1 = ...
    ((controller.c4.wn_p1-0.5)^2/(controller.c4.wn_p1+0.5)^2)*...
    (s^2+2*controller.c4.psi_p1*(controller.c4.wn_p1+0.5)*s+(controller.c4.wn_p1+0.5)^2)/...
    (s^2+2*controller.c4.psi_nf*(controller.c4.wn_p1-0.5)*s+(controller.c4.wn_p1-0.5)^2);
Nfp2 = ...
    ((controller.c4.wn_p2-0.5)^2/(controller.c4.wn_p2+0.5)^2)*...
    (s^2+2*controller.c4.psi_p2*(controller.c4.wn_p2+0.5)*s+(controller.c4.wn_p2+0.5)^2)/...
    (s^2+2*controller.c4.psi_nf*(controller.c4.wn_p2-0.5)*s+(controller.c4.wn_p2-0.5)^2);
controller.c4.Nf = Nfp1*Nfp2;
