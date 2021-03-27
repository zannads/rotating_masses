clear all
close all
clc

%% TO UPLOAD TESTS
% in lab vanno messe nella stessa cartella del file:
% - le cartelle di cui ci interessano i risultati
% - file experiment_handler.mat
% l'importante è essere fuori dalle cartelle "lab_*" altrimenti non 
% a casa una volta aggiunto Matlabdrive al path del computer dovremmo
% essere a posto

data = e_h.prepare_simulation;


%% Factory parameters

% Motor/gear parameters
V_nom = 6;
V_max = 10;
% Rm = 2.6;
Rm = 2.6*0.948;
Lm = 0.18e-3;
k_t = 7.68e-3*1.045;
k_m = 7.68e-3*0.8995;

K_g = 70;           % high-gear total gear ratio
K_gi = 14;
K_ge = 5;
eta_m = 0.69*1.029;
eta_g = 0.9*1.085;

Jm = 3.90e-7;
Jtach = 7.06e-8;
% J_eq = 2.087e-3*1.22;    % high-gear
% B_eq = 0.015*0.253;       % high-gear
J_eq = 2.087e-3;    % high-gear
B_eq = 0.015;       % high-gear

f_max = 50;
I_max = 1;
w_max = 628.3;

% Load parameters
% J = 0.0022;         %resonance freq. wrong
% B = 0.015;          %resonance freq. wrong
% J = 0.000545*1.3;
% B = 0.0015*0.2;
J = 0.000545;
B = 0.0015;

K_s = 1;

% Separation:

% Load 1:
J_1=J;
B_1=B;
% Load 2:
J_2=J;
B_2=B;
% Spring 1:
K_s1=K_s;
% Spring 2:
K_s2=K_s;

%% Sensor parameters
volt_to_deg_potentiometer = 35.2; % [deg/V]
deg_to_rad = pi/180;
pulse_per_rev_encoder = 4096;
pulse_to_rad = 2*pi/pulse_per_rev_encoder;

%The low pass filter for speed measuring is now commented through, once we
%set this up we can uncomment it
%speed_sensor_flter = 1/s+w ????
wfilter=2*pi*25;

%% Controller parameters

% Loop of current
wc_I = Rm/Lm;
kp_I = wc_I*Lm;
ki_I = wc_I*Rm;
Ti_I = kp_I/ki_I;

I_th = I_max*1.6;
V_th = V_max*1;

% Loop of speed
wc_v = 2*pi*6;
kp_v = wc_v*J_eq;
ki_v = wc_v*B_eq;
Ti_v = kp_v/ki_v;

% Loop of position
wc_p = wc_v/10;
kp_p = wc_p;
Ti_p = 10;

%% block model
% Motor model

% state: x1 = theta_l, x2 = theta_l_dot;
% input: u1 = tau_ml, u2 = tau_l;
% output: y1 = theta_m, y2 = theta_m_dot;
% A_m = [0,1;
%     0,-B_eq/J_eq];
% B_m = [0,0;
%     1/J_eq,-1/J_eq];
% C_m = eye(2);
% D_m = zeros(2);

%% state space model
% for only 1 mass
A=zeros(4,4);
A(1,2) = 1;
A(2,:) = [-K_s1/(J_eq),-B_eq/J_eq,K_s1/J_eq,0];
A(3,4) = 1;
A(4,:) = [K_s1/J_1,0,-K_s1/J_1,-B_1/J_1];
B = [0,eta_m*eta_g*K_g/J_eq,0,0]';
C = eye(4);
D=zeros(4,1);

