clear all
close all
clc

%% Factory parameters

% Motor/gear parameters
V_nom = 6;
Rm = 2.6;
Lm = 0.18e-3;
k_t = 7.68e-3;
k_m = 7.68e-3;

K_g = 70;           % high-gear total gear ratio
eta_m = 0.69;
eta_g = 0.9;

Jm = 3.90e-7;
Jtach = 7.06e-8;
J_eq = 2.087e-3;    % high-gear
B_eq = 0.015;       % high-gear

f_max = 50;
I_max = 1;
w_max = 628.3;

% Load parameters
J = 0.0022;
B = 0.015;
K_s = 1;

%% Controller parameters

% Loop of current
wc_I = Rm/Lm;
kp_I = wc_I*Lm;
ki_I = wc_I*Rm;
Ti_I = kp_I/ki_I;

I_th=1.6*I_max;
V_th=1*V_nom;

% Loop of speed
wc_v = B_eq/J_eq;
kp_v = wc_v*J_eq;
ki_v = wc_v*B_eq;
Ti_v = kp_v/ki_v;

% Loop of position
wc_p = wc_v/10;
kp_p = wc_p;
Ti_p = 10;

%% State-space representation

A = zeros(6,6);
A(1,2) = 1;
A(2,:) = [-K_s/(eta_m*eta_g*K_g^2*J_eq),-B_eq/J_eq,K_s/(eta_m*eta_g*K_g*J_eq),0,0,0];
A(3,4) = 1;
A(4,:) = [K_s/K_g,0,-2*K_s/J,-B/J,K_s/J,0];
A(5,6) = 1;
A(6,:) = [0,0,K_s/J,0,-K_s/J,-B/J];

B = [0,1/J_eq,0,0,0,0]';     % u = tau_m

C = [K_s/(eta_g*K_g^2),0,-K_s/(eta_g*K_g),0,0,0];
