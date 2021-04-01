% clear all
% close all
% clc

%% TO UPLOAD TESTS
% in lab vanno messe nella stessa cartella del file:
% - le cartelle di cui ci interessano i risultati
% - file experiment_handler.mat
% l'importante è essere fuori dalle cartelle "lab_*" altrimenti non 
% a casa una volta aggiunto Matlabdrive al path del computer dovremmo
% essere a posto

% data.motor_pos_0 = 0;
% data = e_h.prepare_simulation;

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

%% Controller parameters

% Loop of current
% wc_I = Rm/Lm;
% kp_I = wc_I*Lm;
% ki_I = wc_I*Rm;
% Ti_I = kp_I/ki_I;
% 
I_th = I_max*1.6;
V_th = V_max*1;
% 
% Loop of speed
% wc_v = 2*pi*5.8;
% kp_v = wc_v*J_eq;
% ki_v = wc_v*B_eq;
% Ti_v = kp_v/ki_v;
% 
% Loop of position
% wc_p = wc_v/10;
% kp_p = wc_p;
% Ti_p = 10;
s=tf('s');
R= (30*70/45)*(s+45)/((s+30)*(s+70)); 

%% TF COMPARISON

%% TF nominal parameters
G_nom=(2.021e-07*s^2 + 1.414e-05*s + 1.129e05) / (s^3 + 43.02*s^2 + 2425*s + 7.52e04);

%% TF optimal medium parameters
G_opt= (2.694e-07*s^2 + 1.567e-05*s + 1.389e05) / ( s^3 + 46.56*s^2 + 2435*s + 8.169e04 );

%% TF optimal precise parameter 1V
G_opt1 = (2.365e-07*s^2 + 1.415e-05*s + 1.234e05) / (s^3 + 46.09*s^2 + 2433*s + 8.083e04);  

%% TF optimal precise parameter 4V
G_opt4 = (2.577e-07*s^2 + 1.59e-05*s + 1.362e05) / ( s^3 + 45.44*s^2 + 2432*s + 7.965e04 );

%% TF optimal precise parameter 10V
G_opt10 = (3.097e-07*s^2 + 1.57e-05*s + 1.516e05) / (s^3 + 49.04*s^2 + 2441*s + 8.625e04);

% %% TF sweep sine
% close all
% G_sine = ( 6.84*s^2 - 1058*s - 4.29e04) / (s^3 + 121*s^2 + 2266*s + 2.696e05)
figure(1)
bode(G_nom,G_opt, G_opt1,G_opt4, G_opt10, R)
legend 

%% transfer functions from voltage

s = tf( 's' );
G_motor = 1/(Rm + s*Lm);
G_mass1 = C * inv(s*eye(4)-A) * B + D;
G_tau_to_thetaLdot = G_mass1(2);
G_tau_to_theta1dot = G_mass1(4);
L_V_to_thetaLdot = G_motor * k_t * eta_m * eta_g * K_g * G_tau_to_thetaLdot;
F_V_to_thetaLdot = feedback( L_V_to_thetaLdot, k_m * K_g );

G_V_to_theta1dot = G_motor * k_t * eta_m * eta_g * K_g * G_tau_to_theta1dot / (1 + k_m * K_g * G_motor * k_t * eta_m * eta_g * K_g * G_tau_to_thetaLdot); %Giacomo
G_Luca = -K_s1/J_1 * F_V_to_thetaLdot / ( s^2 + B_1/J_1 * s+ K_s1/J_1 );

figure(1)
bode( G_opt ); hold on;
bode( G_V_to_theta1dot )
bode( G_Luca );

%% Notch Filter

% parametri fino alle 16.43 (experiment 37)
% wn=46.08;
% wn_numNf= 46.5;
% wn_denNf=45.5;
% psi1=0.0879;
% psi2=0.72;

% parametri fino alle 17.04 (experiment 37)
% wn=46.08;
% wn_numNf= 46.5;
% wn_denNf=20;
% psi1=0.0879;
% psi2=1;
% 
% % parametri fino alle 17.11 (experiment 37)
% wn=46.08;
% wn_numNf= 41;
% wn_denNf=39;
% psi1=0.0879;
% psi2=0.72;


% parametri fino alle 17.50 (experiment 37)
% wn=46.08;
%  wn_numNf= 46.5;
%  wn_denNf=45.5;
% psi1=0.0879;
% psi2=0.9;


% parametri fino alle 17.50 (experiment 37)
wn=46.08;
 wn_numNf= 46.5;
 wn_denNf=45.5;
psi1=0.0879;
psi2=0.72;


Nf= (wn_denNf^2/wn_numNf^2)*(s^2+2*psi1*wn_numNf*s+wn_numNf^2)/(s^2+2*psi2*wn_denNf*s+wn_denNf^2);
 G_tot=Nf*G_opt;
% figure(2)
% bode(G_tot)
% step(G_tot)
% pidTuner(G_tot)


%% Regulator PI (for speed)

% parametri fino alle 16.02 (experiment 35)
%wc_v = 7;
% parametri  dalle 16.05 (experiment 36)
%wc_v = 5;
% parametri fino alle 16.51 (experiment 35)
%wc_v = 7;
% parametri fino alle 17.51 (experiment 35)
wc_v = 5;
% parametri fino alle 18.00 (experiment 35)
wc_v = 9;
% parametri fino alle 18.05 (experiment 35)
wc_v = 7;
% parametri fino alle 16.51 (experiment 35)
wc_v = 5;
% parametri fino alle 16.51 (experiment 35)
wc_v = 6;



ki_v=wc_v;
kp_v=wc_v/38.4664;
Ti_v = kp_v/ki_v;
R1=kp_v+ki_v/s;
R=wc_v*(s/38.4664+1)/s;


L=R*G_tot;
F=L/(1+L);
margin(L)

%% Regulator P (for position)
kp_p=1.5; %prova delle 18.28
kp_p=3; %prova delle 18.30
kp_p=5; %prova delle 18.33