% clear all
% clc

nominal_model;
sensors_parameters;
controller_1dof;

e_h = experiment_handler( 'experiment_handler' );

load( 'greybox_id_1dof.mat', 'greybox_id_1dof' );
load( 'blackbox_id_1dof.mat', 'blackbox_id_1dof' );

%% Loading parameters: 1-dof

Rm = greybox_id_1dof.Structure.Parameters(1).Value;
Lm = greybox_id_1dof.Structure.Parameters(2).Value;
k_m = greybox_id_1dof.Structure.Parameters(3).Value;
k_t = greybox_id_1dof.Structure.Parameters(4).Value;
eta_m = greybox_id_1dof.Structure.Parameters(5).Value;
eta_g = greybox_id_1dof.Structure.Parameters(6).Value;
K_g = greybox_id_1dof.Structure.Parameters(7).Value;
J_eq = greybox_id_1dof.Structure.Parameters(8).Value;
B_eq = greybox_id_1dof.Structure.Parameters(9).Value;
K_s1 = greybox_id_1dof.Structure.Parameters(10).Value;
J_1 = greybox_id_1dof.Structure.Parameters(11).Value;
B_1 = greybox_id_1dof.Structure.Parameters(12).Value;

%% Loading parameters: 2-dof

% Rm = greybox_id_2dof.Structure.Parameters(1).Value;
% Lm = greybox_id_2dof.Structure.Parameters(2).Value;
% k_m = greybox_id_2dof.Structure.Parameters(3).Value;
% k_t = greybox_id_2dof.Structure.Parameters(4).Value;
% eta_m = greybox_id_2dof.Structure.Parameters(5).Value;
% eta_g = greybox_id_2dof.Structure.Parameters(6).Value;
% K_g = greybox_id_2dof.Structure.Parameters(7).Value;
% J_eq = greybox_id_2dof.Structure.Parameters(8).Value;
% B_eq = greybox_id_2dof.Structure.Parameters(9).Value;
% K_s1 = greybox_id_2dof.Structure.Parameters(10).Value;
% J_1 = greybox_id_2dof.Structure.Parameters(11).Value;
% B_1 = greybox_id_2dof.Structure.Parameters(12).Value;
% K_s2 = greybox_id_2dof.Structure.Parameters(13).Value;
% J_2 = greybox_id_2dof.Structure.Parameters(14).Value;
% B_2 = greybox_id_2dof.Structure.Parameters(15).Value;
