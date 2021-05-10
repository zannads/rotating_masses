%% Parameters

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

gain_var = 1;

Jm = 3.90e-7;
Jtach = 7.06e-8;
J_eq = 2.087e-3;    % high-gear
B_eq = 0.015;       % high-gear

f_max = 50;
I_max = 1;
w_max = 628.3;

% Load parameters
J = 0.000545;
B = 0.0015;

K_s = 1;

% Loads

% Mass 1:
J_1=J;
B_1=B;
% Mass 2:
J_2=J;
B_2=B;
% Spring 1:
K_s1=K_s;
% Spring 2:
K_s2=K_s;

% disturbances param
b_d_1 = 0.005;
b_d_2 = 0.005;


%% Total model 1-dof

parameters = {'motor resistance', Rm;
              'backEMF', k_m;
              'current_to_torque', k_t;
              'motor efficiency', eta_m;
              'gear efficiency', eta_g;
              'gear ratio', K_g;
              'motor inertia', J_eq;
              'motor friction', B_eq;
              'spring1 stiffness', K_s1;
              'mass1 inertia', J_1;
              'mass1 friction', B_1;
              'DC gain variation', gain_var;
              };

fcn_type = 'cd';
optional_args = {};
Ts = 0;

%state-space
nominal_sys_1dof = idgrey( @dynamics_1dof, parameters, fcn_type, optional_args, Ts, ...
    'StateName', { 'shaft_pos', 'shaft_speed', 'mass1_pos', 'mass1_speed' }, ...
    'StateUnit', { 'rad', 'rad/s', 'rad', 'rad/s' }, ...
    'InputName', { 'voltage' }, ...
    'InputUnit', { 'V' }, ...
    'OutputName', { 'motor_pos', 'mass1_pos' }, ...
    'OutputUnit', { 'rad', 'rad' }, ...
    'Name', 'RotatingMasses 1-dof, reduced' );

nominal_sys_1dof.Structure.Parameters(1).Minimum = Rm*0.88;
nominal_sys_1dof.Structure.Parameters(1).Maximum = Rm*1.12;
nominal_sys_1dof.Structure.Parameters(2).Minimum = k_m*0.88;
nominal_sys_1dof.Structure.Parameters(2).Maximum = k_m*1.12;
nominal_sys_1dof.Structure.Parameters(3).Minimum = k_t*0.88;
nominal_sys_1dof.Structure.Parameters(3).Maximum = k_t*1.12;
nominal_sys_1dof.Structure.Parameters(3).Free = true;
nominal_sys_1dof.Structure.Parameters(4).Minimum = eta_m*0.95;
nominal_sys_1dof.Structure.Parameters(4).Maximum = eta_m*1.05;
nominal_sys_1dof.Structure.Parameters(4).Free = true;
nominal_sys_1dof.Structure.Parameters(5).Minimum = eta_g*0.9;
nominal_sys_1dof.Structure.Parameters(5).Maximum = eta_g*1.1;
nominal_sys_1dof.Structure.Parameters(5).Free = true;
nominal_sys_1dof.Structure.Parameters(6).Free = false;
nominal_sys_1dof.Structure.Parameters(7).Minimum = J_eq*0.9;
nominal_sys_1dof.Structure.Parameters(7).Maximum = J_eq*1.1;
nominal_sys_1dof.Structure.Parameters(8).Minimum = B_eq*0.9;
nominal_sys_1dof.Structure.Parameters(8).Maximum = B_eq*1.1;
nominal_sys_1dof.Structure.Parameters(9).Minimum = K_s1*0.9;
nominal_sys_1dof.Structure.Parameters(9).Maximum = K_s1*1.1;
nominal_sys_1dof.Structure.Parameters(10).Minimum = J_1*0.9;
nominal_sys_1dof.Structure.Parameters(10).Maximum = J_1*1.1;
nominal_sys_1dof.Structure.Parameters(11).Minimum = B_1*0.8;
nominal_sys_1dof.Structure.Parameters(11).Maximum = B_1*1.1;
nominal_sys_1dof.Structure.Parameters(12).Minimum = 0.3;
nominal_sys_1dof.Structure.Parameters(12).Maximum = 1.7;
nominal_sys_1dof.Structure.Parameters(12).Free = false;

%% Total model 2-dof

parameters = {'motor resistance', Rm;
              'backEMF', k_m;
              'current_to_torque', k_t;
              'motor efficiency', eta_m;
              'gear efficiency', eta_g;
              'gear ratio', K_g;
              'motor inertia', J_eq;
              'motor friction', B_eq;
              'spring1 stiffness', K_s1;
              'mass1 inertia', J_1;
              'mass1 friction', B_1;
              'spring2 stiffness', K_s2;
              'mass2 inertia', J_2;
              'mass2 friction', B_2;
              'DC gain variation', gain_var;
              };

fcn_type = 'cd';
optional_args = {};
Ts = 0;

%state-space
nominal_sys_2dof = idgrey( @dynamics_2dof, parameters, fcn_type, optional_args, Ts, ...
    'StateName', { 'shaft_pos', 'shaft_speed', 'mass1_pos', 'mass1_speed', 'mass2_pos', 'mass2_speed' }, ...
    'StateUnit', { 'rad', 'rad/s', 'rad', 'rad/s', 'rad', 'rad/s' }, ...
    'InputName', { 'voltage' }, ...
    'InputUnit', { 'V' }, ...
    'OutputName', { 'motor_pos', 'mass1_pos', 'mass2_pos' }, ...
    'OutputUnit', { 'rad', 'rad', 'rad' }, ...
    'Name', 'RotatingMasses 2-dof, reduced' );

nominal_sys_2dof.Structure.Parameters(1).Minimum = Rm*0.88;
nominal_sys_2dof.Structure.Parameters(1).Maximum = Rm*1.12;
nominal_sys_2dof.Structure.Parameters(2).Minimum = k_m*0.88;
nominal_sys_2dof.Structure.Parameters(2).Maximum = k_m*1.12;
nominal_sys_2dof.Structure.Parameters(3).Minimum = k_t*0.88;
nominal_sys_2dof.Structure.Parameters(3).Maximum = k_t*1.12;
nominal_sys_2dof.Structure.Parameters(3).Free = true;
nominal_sys_2dof.Structure.Parameters(4).Minimum = eta_m*0.95;
nominal_sys_2dof.Structure.Parameters(4).Maximum = eta_m*1.05;
nominal_sys_2dof.Structure.Parameters(4).Free = true;
nominal_sys_2dof.Structure.Parameters(5).Minimum = eta_g*0.9;
nominal_sys_2dof.Structure.Parameters(5).Maximum = eta_g*1.1;
nominal_sys_2dof.Structure.Parameters(5).Free = true;
nominal_sys_2dof.Structure.Parameters(6).Free = false;
nominal_sys_2dof.Structure.Parameters(7).Minimum = J_eq*0.85;
nominal_sys_2dof.Structure.Parameters(7).Maximum = J_eq*1.15;
nominal_sys_2dof.Structure.Parameters(8).Minimum = B_eq*0.85;
nominal_sys_2dof.Structure.Parameters(8).Maximum = B_eq*1.15;
nominal_sys_2dof.Structure.Parameters(9).Minimum = K_s1*0.85;
nominal_sys_2dof.Structure.Parameters(9).Maximum = K_s1*1.15;
nominal_sys_2dof.Structure.Parameters(10).Minimum = J_1*0.85;
nominal_sys_2dof.Structure.Parameters(10).Maximum = J_1*1.15;
nominal_sys_2dof.Structure.Parameters(11).Minimum = B_1*0.85;
nominal_sys_2dof.Structure.Parameters(11).Maximum = B_1*1.15;
nominal_sys_2dof.Structure.Parameters(12).Minimum = K_s2*0.8;
nominal_sys_2dof.Structure.Parameters(12).Maximum = K_s2*1.05;
nominal_sys_2dof.Structure.Parameters(13).Minimum = J_2*0.8;
nominal_sys_2dof.Structure.Parameters(13).Maximum = J_2*1.2;
nominal_sys_2dof.Structure.Parameters(14).Minimum = B_2*0.8;
nominal_sys_2dof.Structure.Parameters(14).Maximum = B_2*1;
nominal_sys_2dof.Structure.Parameters(15).Minimum = 0.3;
nominal_sys_2dof.Structure.Parameters(15).Maximum = 1.7;
nominal_sys_2dof.Structure.Parameters(15).Free = false;


%% Total model 1-dof: state-space formulation

% ...
function [ A, B, C, D ] = dynamics_1dof( ...
    Rm, k_m, k_t, eta_m, eta_g, K_g, J_eq, B_eq, K_s1, J_1, B_1, gain_var, ts )

A = zeros(4,4);
A(1,2) = 1;
A(2,:) = [-K_s1/J_eq,-(eta_m*eta_g*k_t*k_m*K_g^2/Rm+B_eq)/J_eq,K_s1/J_eq,0];
A(3,4) = 1;
A(4,:) = [K_s1/J_1,0,-K_s1/J_1,-B_1/J_1];
B = [0,eta_m*eta_g*k_t*K_g/(Rm*J_eq),0,0]';
C = [1,0,0,0;
     0,0,-1,0];
D = zeros(2,1);

% V noise...to add
if ts > 0 % Sample the model with sample time Ts
   s = expm([[A B]*ts; zeros(1,5)]);
   A = s(1:4,1:4);
   B = s(1:4,5);
end
end

%% Total model 2-dof: state-space formulation

% ...
function [ A, B, C, D ] = dynamics_2dof( ...
    Rm, k_m, k_t, eta_m, eta_g, K_g, J_eq, B_eq, K_s1, J_1, B_1, K_s2, J_2, B_2, gain_var, ts )

A = zeros(6,6);
A(1,2) = 1;
A(2,:) = [-K_s1/J_eq,-(eta_m*eta_g*k_t*k_m*K_g^2/Rm+B_eq)/J_eq,K_s1/J_eq,0,0,0];
A(3,4) = 1;
A(4,:) = [K_s1/J_1,0,-(K_s1+K_s2)/J_1,-B_1/J_1,K_s2/J_1,0];
A(5,6) = 1;
A(6,:) = [0,0,K_s2/J_2,0,-K_s2/J_2,-B_2/J_2];
B = [0,eta_m*eta_g*k_t*K_g/(Rm*J_eq),0,0,0,0]';
C = [1,0,0,0,0,0;
     0,0,-1,0,0,0;
     0,0,0,0,-1,0];
D = zeros(3,1);

% V noise...to add
if ts > 0 % Sample the model with sample time Ts
   s = expm([[A B]*ts; zeros(1,7)]);
   A = s(1:6,1:6);
   B = s(1:6,7);
end
end