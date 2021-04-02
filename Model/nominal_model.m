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

%% Total model 1-dof

parameters = {'motor resistance', Rm;
              'motor inductance', Lm;
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
    'StateName', { 'current', 'shaft_pos', 'shaft_speed', 'mass1_pos', 'mass1_speed' }, ...
    'StateUnit', { 'A', 'rad', 'rad/s', 'rad', 'rad/s' }, ...
    'InputName', { 'voltage' }, ...
    'InputUnit', { 'V' }, ...
    'OutputName', { 'mass1_speed' }, ...
    'OutputUnit', { 'rad/s' }, ...
    'Name', 'RotatingMasses 1-dof' );

nominal_sys_1dof.Structure.Parameters(1).Minimum = Rm*0.88;
nominal_sys_1dof.Structure.Parameters(1).Maximum = Rm*1.12;
nominal_sys_1dof.Structure.Parameters(2).Free = false;
nominal_sys_1dof.Structure.Parameters(3).Minimum = k_m*0.88;
nominal_sys_1dof.Structure.Parameters(3).Maximum = k_m*1.12;
nominal_sys_1dof.Structure.Parameters(4).Minimum = k_t*0.88;
nominal_sys_1dof.Structure.Parameters(4).Maximum = k_t*1.12;
nominal_sys_1dof.Structure.Parameters(4).Free = true;
nominal_sys_1dof.Structure.Parameters(5).Minimum = eta_m*0.95;
nominal_sys_1dof.Structure.Parameters(5).Maximum = eta_m*1.05;
nominal_sys_1dof.Structure.Parameters(5).Free = true;
nominal_sys_1dof.Structure.Parameters(6).Minimum = eta_g*0.9;
nominal_sys_1dof.Structure.Parameters(6).Maximum = eta_g*1.1;
nominal_sys_1dof.Structure.Parameters(6).Free = true;
nominal_sys_1dof.Structure.Parameters(7).Free = false;
nominal_sys_1dof.Structure.Parameters(8).Minimum = J_eq*0.9;
nominal_sys_1dof.Structure.Parameters(8).Maximum = J_eq*1.1;
nominal_sys_1dof.Structure.Parameters(9).Minimum = B_eq*0.9;
nominal_sys_1dof.Structure.Parameters(9).Maximum = B_eq*1.1;
nominal_sys_1dof.Structure.Parameters(10).Minimum = K_s1*0.9;
nominal_sys_1dof.Structure.Parameters(10).Maximum = K_s1*1.1;
nominal_sys_1dof.Structure.Parameters(11).Minimum = J_1*0.9;
nominal_sys_1dof.Structure.Parameters(11).Maximum = J_1*1.1;
nominal_sys_1dof.Structure.Parameters(12).Minimum = B_1*0.9;
nominal_sys_1dof.Structure.Parameters(12).Maximum = B_1*1.1;
nominal_sys_1dof.Structure.Parameters(13).Minimum = 0.3;
nominal_sys_1dof.Structure.Parameters(13).Maximum = 1.7;
nominal_sys_1dof.Structure.Parameters(13).Free = false;

%% Total model 2-dof

parameters = {'motor resistance', Rm;
              'motor inductance', Lm;
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
    'StateName', { 'current', 'shaft_pos', 'shaft_speed', 'mass1_pos', 'mass1_speed', 'mass2_pos', 'mass2_speed' }, ...
    'StateUnit', { 'A', 'rad', 'rad/s', 'rad', 'rad/s', 'rad', 'rad/s' }, ...
    'InputName', { 'voltage' }, ...
    'InputUnit', { 'V' }, ...
    'OutputName', { 'mass2_speed' }, ...
    'OutputUnit', { 'rad/s' }, ...
    'Name', 'RotatingMasses 2-dof' );

nominal_sys_2dof.Structure.Parameters(1).Minimum = Rm*0.88;
nominal_sys_2dof.Structure.Parameters(1).Maximum = Rm*1.12;
nominal_sys_2dof.Structure.Parameters(2).Free = false;
nominal_sys_2dof.Structure.Parameters(3).Minimum = k_m*0.88;
nominal_sys_2dof.Structure.Parameters(3).Maximum = k_m*1.12;
nominal_sys_2dof.Structure.Parameters(4).Minimum = k_t*0.88;
nominal_sys_2dof.Structure.Parameters(4).Maximum = k_t*1.12;
nominal_sys_2dof.Structure.Parameters(4).Free = true;
nominal_sys_2dof.Structure.Parameters(5).Minimum = eta_m*0.95;
nominal_sys_2dof.Structure.Parameters(5).Maximum = eta_m*1.05;
nominal_sys_2dof.Structure.Parameters(5).Free = true;
nominal_sys_2dof.Structure.Parameters(6).Minimum = eta_g*0.9;
nominal_sys_2dof.Structure.Parameters(6).Maximum = eta_g*1.1;
nominal_sys_2dof.Structure.Parameters(6).Free = true;
nominal_sys_2dof.Structure.Parameters(7).Free = false;
nominal_sys_2dof.Structure.Parameters(8).Minimum = J_eq*0.85;
nominal_sys_2dof.Structure.Parameters(8).Maximum = J_eq*1.15;
nominal_sys_2dof.Structure.Parameters(9).Minimum = B_eq*0.85;
nominal_sys_2dof.Structure.Parameters(9).Maximum = B_eq*1.15;
nominal_sys_2dof.Structure.Parameters(10).Minimum = K_s1*0.85;
nominal_sys_2dof.Structure.Parameters(10).Maximum = K_s1*1.15;
nominal_sys_2dof.Structure.Parameters(11).Minimum = J_1*0.85;
nominal_sys_2dof.Structure.Parameters(11).Maximum = J_1*1.15;
nominal_sys_2dof.Structure.Parameters(12).Minimum = B_1*0.85;
nominal_sys_2dof.Structure.Parameters(12).Maximum = B_1*1.15;
nominal_sys_2dof.Structure.Parameters(13).Minimum = K_s2*0.85;
nominal_sys_2dof.Structure.Parameters(13).Maximum = K_s2*1.15;
nominal_sys_2dof.Structure.Parameters(14).Minimum = J_2*0.85;
nominal_sys_2dof.Structure.Parameters(14).Maximum = J_2*1.15;
nominal_sys_2dof.Structure.Parameters(15).Minimum = B_2*0.85;
nominal_sys_2dof.Structure.Parameters(15).Maximum = B_2*1.15;
nominal_sys_2dof.Structure.Parameters(16).Minimum = 0.3;
nominal_sys_2dof.Structure.Parameters(16).Maximum = 1.7;
nominal_sys_2dof.Structure.Parameters(16).Free = false;

%% Total model 1-dof: state-space formulation

% ...
function [ A, B, C, D ] = dynamics_1dof( ...
    Rm, Lm, k_m, k_t, eta_m, eta_g, K_g, J_eq, B_eq, K_s1, J_1, B_1, gain_var, ts )

A = zeros(5,5);
A(1,:) = [-Rm/Lm,0,-k_m*K_g/Lm,0,0];
A(2,3) = 1;
A(3,:) = [k_t*eta_m*eta_g*gain_var*K_g/J_eq,-K_s1/(J_eq),-B_eq/J_eq,K_s1/J_eq,0];
A(4,5) = 1;
A(5,:) = [0,K_s1/J_1,0,-K_s1/J_1,-B_1/J_1];
B = [1/Lm,0,0,0,0]';
C = zeros(1,5);
C(1,5) = 1;
D = zeros(1,1);

% V noise...to add
if ts > 0 % Sample the model with sample time Ts
   s = expm([[A B]*ts; zeros(1,6)]);
   A = s(1:5,1:5);
   B = s(1:5,6);
end
end

%% Total model 2-dof: state-space formulation

% ...
function [ A, B, C, D ] = dynamics_2dof( ...
    Rm, Lm, k_m, k_t, eta_m, eta_g, K_g, J_eq, B_eq, K_s1, J_1, B_1, K_s2, J_2, B_2, gain_var, ts )

A = zeros(7,7);
A(1,:) = [-Rm/Lm,0,-k_m*K_g/Lm,0,0,0,0];
A(2,3) = 1;
A(3,:) = [k_t*eta_m*eta_g*gain_var*K_g/J_eq,-K_s1/(J_eq),-B_eq/J_eq,K_s1/J_eq,0,0,0];
A(4,5) = 1;
A(5,:) = [0,K_s1/J_1,0,-(K_s1+K_s2)/J_1,-B_1/J_1,K_s2/J_1,0];
A(6,7) = 1;
A(7,:) = [0,0,0,K_s2/J_2,0,-K_s2/J_2,-B_2/J_2];

B = [1/Lm,0,0,0,0,0,0]';
C = zeros(1,7);
C(1,7) = 1;
D = zeros(1,1);

% V noise...to add
if ts > 0 % Sample the model with sample time Ts
   s = expm([[A B]*ts; zeros(1,8)]);
   A = s(1:7,1:7);
   B = s(1:7,8);
end
end