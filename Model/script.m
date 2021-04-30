%% SCRIPT

% load the nominal model and parameters.
nominal_model_reduced;
% load the parameters for operate simulink in lab
sensors_parameters;
% create the object controller, defined as in simulink. Default
% active_techinque = 0, thus openloop  voltage control.
controller_setup;
% load experiment handler to 
e_h = experiment_handler( 'experiment_handler' );

%% Loading parameters
active_dof = 1;     % 1 or 2 dof

if active_dof == 1
    Rm = greybox_id_1dof.Structure.Parameters(1).Value;
    k_m = greybox_id_1dof.Structure.Parameters(2).Value;
    k_t = greybox_id_1dof.Structure.Parameters(3).Value;
    eta_m = greybox_id_1dof.Structure.Parameters(4).Value;
    eta_g = greybox_id_1dof.Structure.Parameters(5).Value;
    K_g = greybox_id_1dof.Structure.Parameters(6).Value;
    J_eq = greybox_id_1dof.Structure.Parameters(7).Value;
    B_eq = greybox_id_1dof.Structure.Parameters(8).Value;
    K_s1 = greybox_id_1dof.Structure.Parameters(9).Value;
    J_1 = greybox_id_1dof.Structure.Parameters(10).Value;
    B_1 = greybox_id_1dof.Structure.Parameters(11).Value;
    K_s2 = 1;
    J_2 = 1;
    B_2 = 1;
else
%     active_dof == 2
    Rm = greybox_id_2dof.Structure.Parameters(1).Value;
    k_m = greybox_id_2dof.Structure.Parameters(2).Value;
    k_t = greybox_id_2dof.Structure.Parameters(3).Value;
    eta_m = greybox_id_2dof.Structure.Parameters(4).Value;
    eta_g = greybox_id_2dof.Structure.Parameters(5).Value;
    K_g = greybox_id_2dof.Structure.Parameters(6).Value;
    J_eq = greybox_id_2dof.Structure.Parameters(7).Value;
    B_eq = greybox_id_2dof.Structure.Parameters(8).Value;
    K_s1 = greybox_id_2dof.Structure.Parameters(9).Value;
    J_1 = greybox_id_2dof.Structure.Parameters(10).Value;
    B_1 = greybox_id_2dof.Structure.Parameters(11).Value;
    K_s2 = greybox_id_2dof.Structure.Parameters(12).Value;
    J_2 = greybox_id_2dof.Structure.Parameters(13).Value;
    B_2 = greybox_id_2dof.Structure.Parameters(14).Value;
end

%% PROCEDURE:
% run "script.m"
% simulations: open "scheme.slx"

    % to repeat a test: 
    % [data, experiment, controller] = e_h.prepare_simulation

    % to test a new controller:
    % [data, ~, ~] = e_h.prepare_simulation (loads data if you want to
    % compare between different controllers)
    % experiment = e_h.load_experiment
    % setup the desired controller with the values ( use
    % controller.active_technique to select it )
    
% lab tests: open "Template.slx"

    % everything is already loaded with default controller. (There is no
    % need to load data)
    % dataset_struct = e_h.dataset_structs{3}
    % experiment = e_h.load_experiment
    % run the experiment
    % immediately after the end, on command window: 
    % create_data 
    
% for matlab plots: 
    % data = e_h.load_data
    % plot( data.time, data.xxxxx )
    
    
% experiment takes care of generating the references. After an experiment
% in the lab, when create_data is called, the title of the current
% experiment is saved, thus we can automaticaly redo the same experiment in
% simulation at home.

% controller is a struct, where active techinque acts as a switch, each
% field of the struct is a controller. Each of this controller has its own
% parameters defined as in simulink. After an experiment in the lab, when
% create_data is called the paramteers of the active controller is saved,
% thus in simulation at home we can just simply upload the varaible from
% the disk.

% dataset_struct is an empty struct that defines which signal are saved
% from the simulink laboratory. 

% data can be of two types: for simulations, it has the variables used in
% simulink "scheme.slx".
% for matlab plot it is a struct where each field is one signal saved in
% the lab.