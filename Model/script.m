clear all
close all
clc

%% TO UPLOAD TESTS
%add the directory to the Matlabpath if it hasn't been done permanently.
% Get the name of the user who logged in to the computer.
userProfile = getenv('USERPROFILE');

directory = 'MatlabDrive/RotatingMasses';
addpath( fullfile( userProfile, 'Documents', directory ) );

%Load the desired test
% test = 'data_09-Mar-2021_15-37-13.mat';
%unfortunately the variable has _ instead of - 
test = 'data_09_Mar_2021_18_53_24';
data = load( test );
data = data.(test);
number_signal = size( data, 1);
time_steps = size( data, 2);

voltage_ref = [data(1,:)',data(3,:)'];
motor_pos_data = [data(1,:)',data(2,:)'];
motor_pos_0 = motor_pos_data(1,2);
mass_pos_data = [data(1,:)',data(4,:)'];
if number_signal>4
    mass_vel_data = [data(1,:)',data(5,:)'];
else
    mass_vel_data = [data(1,:)',zeros(time_steps,1)];
end

%% Factory parameters

% Motor/gear parameters
V_nom = 6;
V_max = 10;
Rm = 2.6;
Lm = 0.18e-3;
k_t = 7.68e-3;
k_m = 7.68e-3;

K_g = 70;           % high-gear total gear ratio
K_gi = 14;
K_ge = 5;
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
% J = 0.0022;         %resonance freq. wrong
% B = 0.015;          %resonance freq. wrong
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
wc_v = B_eq/J_eq;
kp_v = wc_v*J_eq;
ki_v = wc_v*B_eq;
Ti_v = kp_v/ki_v;

% Loop of position
wc_p = wc_v/10;
kp_p = wc_p;
Ti_p = 10;

%% State-space representation

% 2-DOF system, unique model
% ATTENZIONE! Controllare modello rispetto a Simulink

% A = zeros(6,6);
% A(1,2) = 1;
% A(2,:) = [-K_s1/(eta_m*eta_g*K_g^2*J_eq),-B_eq/J_eq,K_s1/(eta_m*eta_g*K_g*J_eq),0,0,0];
% A(3,4) = 1;
% A(4,:) = [K_s2/(K_g*J1),0,-2*K_s2/J1,-B1/J1,K_s2/J1,0];
% A(5,6) = 1;
% A(6,:) = [0,0,K_s2/J2,0,-K_s2/J2,-B2/J2];
% B = [0,1/J_eq,0,0,0,0]';     % u = tau_m
% C = [K_s1/(eta_g*K_g^2),0,-K_s1/(eta_g*K_g),0,0,0]; % y = tau_lm


% Motor model

% state: x1 = theta_m, x2 = theta_m_dot;
% input: u1 = tau_m, u2 = tau_lm;
% output: y1 = theta_m, y2 = theta_m_dot;
A_m = [0,1;
      0,-B_eq/J_eq];
B_m = [0,0;
       1/J_eq,-1/J_eq];
C_m = eye(2);
D_m = zeros(2);

%%
figure
plot( data(1, :),  [data(2:end-1, :);...
    1000*data(end, :)] ); grid on