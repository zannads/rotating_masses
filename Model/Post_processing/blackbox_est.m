%% Blackbox estimation: 1dof

%% Dati con filtro a 25 Hz

titoli = { 'voltage_step_1dof_-10V.mat', 'voltage_step_1dof_-8V.mat', 'voltage_step_1dof_-6V.mat', ...
    'voltage_step_1dof_-4V.mat', 'voltage_step_1dof_-2V.mat', 'voltage_step_1dof_2V.mat', ...
    'voltage_step_1dof_4V.mat', 'voltage_step_1dof_6V.mat', 'voltage_step_1dof_8V.mat', ...
    'voltage_step_1dof_10V.mat' };

load( titoli{1}, 'data' );
experiment = iddata( data.mass1_vel', data.voltage', 0.002 );
for idx = 2:length( titoli )
    load( titoli{idx}, 'data' );
    experiment2 = iddata( data.mass1_vel', data.voltage', 0.002 );
    experiment = merge( experiment, experiment2 );
end

blackbox_id_1dof = tfest( experiment, 4, 0 );
blackbox_id_1dof.Notes = "Dati con filtro a 25 Hz";
blackbox_id_1dof.Name = "blackbox id 1dof";

figure
bode( blackbox_id_1dof, {1,150} ); hold on; legend

%% Blackbox estimation: 2dof

%% Dati con filtro a 25 Hz

titoli = { 'voltage_step_2dof_-10V.mat', 'voltage_step_2dof_-8V.mat', 'voltage_step_2dof_-6V.mat', ...
    'voltage_step_2dof_-4V.mat', 'voltage_step_2dof_-2V.mat', 'voltage_step_2dof_2V.mat', ...
    'voltage_step_2dof_4V.mat', 'voltage_step_2dof_6V.mat', 'voltage_step_2dof_8V.mat', ...
    'voltage_step_2dof_10V.mat' };

load( titoli{1}, 'data' );
experiment = iddata( data.mass2_vel', data.voltage', 0.002 );
for idx = 2:length( titoli )
    load( titoli{idx}, 'data' );
    experiment2 = iddata( data.mass2_vel', data.voltage', 0.002 );
    experiment = merge( experiment, experiment2 );
end

blackbox_id_2dof = tfest( experiment, 6, 0 );
blackbox_id_2dof.Notes = "Dati con filtro a 25 Hz";
blackbox_id_2dof.Name = "blackbox id 2dof";

figure
bode( blackbox_id_2dof, {1,150} ); hold on; legend

