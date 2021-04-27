%% TEST antiresonance
%  ORE 14 33
controller.active_technique = 0;
experiment = e_h.experiments{end};
title = "antiresonance test";
dataset_struct = e_h.dataset_structs{2};

%% TEST PID, riferimento: mass2_vel
dataset_struct = e_h.dataset_structs{3};
controller.active_technique = 6;

%% ORE 14 35
title = "test PID1 mass 2 speed 14 35";

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

%% ORE 14 45
title = "test PID2 mass 2 speed 14 45";
controller.active_technique = 6;

controller.c6.Kp = -0.914;
controller.c6.Ki = -3.93;
controller.c6.Kd = -0.0532;

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

controller.c6.Pf=1/(s/4+1);

%% ORE 15 01
title = "test PI+anticipatore mass 2 speed 15 01";

%% ORE 15 50
title = "test PI+anticipatore mass 2 speed 15 50";
controller.active_technique = 6;

controller.c6.Kp = -0.914;
controller.c6.Ki = -3.93;
controller.c6.Kd = -0.0532;

controller.c6.wn_p1=24.5;         
controller.c6.psi_p1=1.36e-01;
controller.c6.wn_p2=61.9;
controller.c6.psi_p2=2.52e-02;
controller.c6.psi_nf1=0.72;
controller.c6.psi_nf2=0.9;

controller.c6.anticipatore = 1*(s/10+1)/(s/60+1);

Nfp1 = ...
        ((controller.c6.wn_p1-0.5)^2/(controller.c6.wn_p1+0.5)^2)*...
        (s^2+2*controller.c6.psi_p1*(controller.c6.wn_p1+0.5)*s+(controller.c6.wn_p1+0.5)^2)/...
        (s^2+2*controller.c6.psi_nf1*(controller.c6.wn_p1-0.5)*s+(controller.c6.wn_p1-0.5)^2);
    Nfp2 = ...
        ((controller.c6.wn_p2-0.5)^2/(controller.c6.wn_p2+0.5)^2)*...
        (s^2+2*controller.c6.psi_p2*(controller.c6.wn_p2+0.5)*s+(controller.c6.wn_p2+0.5)^2)/...
        (s^2+2*controller.c6.psi_nf2*(controller.c6.wn_p2-0.5)*s+(controller.c6.wn_p2-0.5)^2);
    controller.c6.Nf = Nfp1*Nfp2*controller.c6.anticipatore;

controller.c6.Pf=1/(s/4+1);

%% TEST PID + P, riferimento: mass2_pos
%  NON ESEGUITO

title = "test PID+P mass 2 pos";
controller.active_technique = 8;

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

%% plot funzione d'anello e sensitività

PI = -controller.c3.wc_v * (s/33.3+1)/s;
Nf = controller.c3.Nf;
G = ss( greybox_id_2dof.A, greybox_id_2dof.B, ...
    greybox_id_2dof.C(4,:), greybox_id_2dof.D(4,:) );
zero = (s/0.05+1)^2/(s/1+1)^2;
L =  Nfp1 * Nfp2 * G * R;

figure(1)
margin( minreal( L ) )

figure(2)
margin( 1/(1+L) )
figure(3)
bode( R * Nf ), grid on

%% TEST PI + notch cancellazione poli
% ORE = 16.30 & 16.35 (step 2rad/s)
controller.active_technique = 3;
experiment = e_h.load_ezperiment(25)
title = "test cancellazione poli 16 35";
controller.c3.wc_v=8;
controller.c3.wn_p1=24.5;
controller.c3.psi_p1=1.37e-01;
controller.c3.wn_p2=61.9;
controller.c3.psi_p2=2.38e-02;
controller.c3.psi_nf1=0.72;
controller.c3.psi_nf2=0.9;
controller.c3.Pf=1;
controller.c3.wn_p3=100;

controller.c3.ki_v = controller.c3.wc_v;
controller.c3.kp_v = controller.c3.wc_v/33.3; %33.3
controller.c3.Ti_v = controller.c3.kp_v/controller.c3.ki_v;
R = -controller.c3.wc_v*(s/33.3+1)/s;

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



%% ORE = 17.00
controller.active_technique = 3;

title = "test cancellazione poli 17 00";
controller.c3.wc_v=6;
controller.c3.wn_p1=24.5;
controller.c3.psi_p1=1.37e-01;
controller.c3.wn_p2=61.9;
controller.c3.psi_p2=2.38e-02;
controller.c3.psi_nf1=0.72;
controller.c3.psi_nf2=0.9;
controller.c3.Pf=1;
controller.c3.wn_p3=100;

controller.c3.ki_v = controller.c3.wc_v;
controller.c3.kp_v = controller.c3.wc_v/33.3; %33.3
controller.c3.Ti_v = controller.c3.kp_v/controller.c3.ki_v;
R = -controller.c3.wc_v*(s/33.3+1)/s;

%% ORE = 17.12
controller.active_technique = 3;

title = "test cancellazione poli 17 08";
controller.c3.wc_v=8;
controller.c3.wn_p1=24.5;
controller.c3.psi_p1=1.37e-01;
controller.c3.wn_p2=61.9;
controller.c3.psi_p2=2.38e-02;
controller.c3.psi_nf1=0.72;
controller.c3.psi_nf2=0.9;
controller.c3.Pf=1;
controller.c3.wn_p3=100;

controller.c3.ki_v = controller.c3.wc_v;
controller.c3.kp_v = controller.c3.wc_v/33.3; %33.3
controller.c3.Ti_v = controller.c3.kp_v/controller.c3.ki_v;
R = -controller.c3.wc_v*(s/33.3+1)/s;

%% ORE = 17.15
controller.active_technique = 3;

title = "test cancellazione poli 17 15";
controller.c3.wc_v=10;
controller.c3.wn_p1=24.5;
controller.c3.psi_p1=1.37e-01;
controller.c3.wn_p2=61.9;
controller.c3.psi_p2=2.38e-02;
controller.c3.psi_nf1=0.72;
controller.c3.psi_nf2=0.9;
controller.c3.Pf=1/(s/8+1);
controller.c3.wn_p3=100;

controller.c3.ki_v = controller.c3.wc_v;
controller.c3.kp_v = controller.c3.wc_v/33.3; %33.3
controller.c3.Ti_v = controller.c3.kp_v/controller.c3.ki_v;
R = -controller.c3.wc_v*(s/33.3+1)/s;

%% ORE = 17.25 & 17.45
controller.active_technique = 3;

title = "test cancellazione poli 17 45";
controller.c3.wc_v=8;
controller.c3.wn_p1=24.5;
controller.c3.psi_p1=1.37e-01;
controller.c3.wn_p2=61.9;
controller.c3.psi_p2=2.38e-02;
controller.c3.psi_nf1=0.72;
controller.c3.psi_nf2=0.9;
controller.c3.Pf=1/(s/7+1);
controller.c3.wn_p3=100;

controller.c3.ki_v = controller.c3.wc_v;
controller.c3.kp_v = controller.c3.wc_v/33.3; %33.3
controller.c3.Ti_v = controller.c3.kp_v/controller.c3.ki_v;
R = -controller.c3.wc_v*(s/33.3+1)/s;

%% C4
% controller.active_technique = 4;

title = "test switch pos_err 18 05";

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

%% C4
% controller.active_technique = 4;

title = "test switch pos_err 18 18";

controller.c4.kp_p=2.2;
controller.c4.wc_v=8;
controller.c4.wn_p1=24.5;
controller.c4.psi_p1=1.37e-01;
controller.c4.wn_p2=61.9;
controller.c4.psi_p2=2.38e-02;
controller.c4.psi_nf1=0.72;
controller.c4.psi_nf2=0.9;
controller.c4.Pf=1;
controller.c4.wn_p3=100;

controller.c4.ki_v = controller.c4.wc_v;
controller.c4.kp_v = controller.c4.wc_v/33.3; %33.3
controller.c4.Ti_v = controller.c4.kp_v/controller.c4.ki_v;
% Notch-filter

Nfp1 = ...
    ((controller.c4.wn_p3)^2/(controller.c4.wn_p1)^2)*...
    (s^2+2*controller.c4.psi_p1*(controller.c4.wn_p1)*s+(controller.c4.wn_p1)^2)/...
    (s^2+2*controller.c4.psi_nf1*(controller.c4.wn_p3)*s+(controller.c4.wn_p3)^2);
Nfp2 = ...
    ((controller.c4.wn_p3)^2/(controller.c4.wn_p2)^2)*...
    (s^2+2*controller.c4.psi_p2*(controller.c4.wn_p2)*s+(controller.c4.wn_p2)^2)/...
    (s^2+2*controller.c4.psi_nf2*(controller.c4.wn_p3)*s+(controller.c4.wn_p3)^2);
controller.c4.Nf = Nfp1*Nfp2;

%% C4
controller.active_technique = 4;

title = "test switch pos_err 18 30";

controller.c4.kp_p=2.2;
controller.c4.wc_v=4;
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

%% ORE = 18 40
controller.active_technique = 3;

title = "sinesweep mass2_vel 18 50";
controller.c3.wc_v=8;
controller.c3.wn_p1=24.5;
controller.c3.psi_p1=1.37e-01;
controller.c3.wn_p2=61.9;
controller.c3.psi_p2=2.38e-02;
controller.c3.psi_nf1=0.72;
controller.c3.psi_nf2=0.9;
controller.c3.Pf=1/(s/7+1);
controller.c3.wn_p3=100;

controller.c3.ki_v = controller.c3.wc_v;
controller.c3.kp_v = controller.c3.wc_v/33.3; %33.3
controller.c3.Ti_v = controller.c3.kp_v/controller.c3.ki_v;
R = -controller.c3.wc_v*(s/33.3+1)/s;

%% C4
controller.active_technique = 4;

title = "sinesweep mass2_vel 18 55";

controller.c4.kp_p=2.2;
controller.c4.wc_v=4;
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

%% Notch-filter

Nfp1 = ...
    ((controller.c3.wn_p3)^2/(controller.c3.wn_p1)^2)*...
    (s^2+2*controller.c3.psi_p1*(controller.c3.wn_p1)*s+(controller.c3.wn_p1)^2)/...
    (s^2+2*controller.c3.psi_nf1*(controller.c3.wn_p3)*s+(controller.c3.wn_p3)^2);
Nfp2 = ...
    ((controller.c3.wn_p3)^2/(controller.c3.wn_p2)^2)*...
    (s^2+2*controller.c3.psi_p2*(controller.c3.wn_p2)*s+(controller.c3.wn_p2)^2)/...
    (s^2+2*controller.c3.psi_nf2*(controller.c3.wn_p3)*s+(controller.c3.wn_p3)^2);
controller.c3.Nf = Nfp1*Nfp2;

