%% Greybox estimation: 1-dof

%% Dati con filtro a 25 Hz

titoli = { 'voltage_step_1dof_-10V.mat', 'voltage_step_1dof_-8V.mat', 'voltage_step_1dof_-6V.mat', ...
    'voltage_step_1dof_-4V.mat', 'voltage_step_1dof_-2V.mat', 'voltage_step_1dof_2V.mat', ...
    'voltage_step_1dof_4V.mat', 'voltage_step_1dof_6V.mat', 'voltage_step_1dof_8V.mat', ...
    'voltage_step_1dof_10V.mat' };

load( titoli{1}, 'data' );
inputs{1,1} = data.voltage';
outputs{1,1} = [int_potentiometer(data.motor_pos, data.time)', data.mass1_pos'] ;
for idx = 2:length( titoli )
    load( titoli{idx}, 'data' );
    inputs{1,idx} = data.voltage';
    outputs{1,idx} = [int_potentiometer(data.motor_pos, data.time)', data.mass1_pos'] ;
end

data_to_est = iddata( outputs, inputs, 0.002 );

opt = greyestOptions('EnforceStability',true, 'WeightingFilter', [0.1,100] );
opt.SearchOptions.MaxIterations = 600;
greybox_id_1dof = greyest( data_to_est, nominal_sys_1dof, opt );
greybox_id_1dof.Notes = "Dati con filtro a 25 Hz";
greybox_id_1dof.Name = "greybox id 1dof";

% figure
% bode( ss(greybox_id_1dof.A,greybox_id_1dof.B,greybox_id_1dof.C(2,:),greybox_id_1dof.D(2,:)),{1,100} )
% hold on; bode( blackbox_id_1dof )

%% Dati con filtro a 25 Hz (dati filterok)

% titoli = { 'voltage_step_1dof_-10V_filterok.mat', 'voltage_step_1dof_-6V_filterok.mat', 'voltage_step_1dof_2V_filterok.mat' };
% 
% load( titoli{1}, 'data' );
% inputs{1,1} = data.voltage';
% outputs{1,1} = [data.mass1_pos', data.mass1_vel'] ;
% for idx = 2:length( titoli )
%     load( titoli{idx}, 'data' );
%     inputs{1,idx} = data.voltage';
%     outputs{1,idx} = [data.mass1_pos', data.mass1_vel'] ;
% end
% 
% data_to_est = iddata( outputs, inputs, 0.002 );
% 
% opt = greyestOptions('EnforceStability',true, 'WeightingFilter', [0.01,70] );
% opt.SearchOptions.MaxIterations = 60;
% greybox_id_1dof_filterok = greyest( data_to_est, nominal_sys_1dof, opt );
% greybox_id_1dof_filterok.Notes = "Dati con filtro a 25Hz";
% greybox_id_1dof_filterok.Name = "greybox id 1dof filterOk";
% 
% bode( greybox_id_1dof_filterok, {0.1,100} )

%% Greybox estimation: 2-dof

%% Dati con filtro a 25 Hz

titoli = { 'voltage_step_2dof_-10V.mat', 'voltage_step_2dof_-8V.mat', 'voltage_step_2dof_-6V.mat', ...
    'voltage_step_2dof_-4V.mat', 'voltage_step_2dof_-2V.mat', 'voltage_step_2dof_2V.mat', ...
    'voltage_step_2dof_4V.mat', 'voltage_step_2dof_6V.mat', 'voltage_step_2dof_8V.mat', ...
    'voltage_step_2dof_10V.mat' };

load( titoli{1}, 'data' );
inputs{1,1} = data.voltage';
outputs{1,1} = [data.mass1_pos', data.mass1_vel', data.mass2_pos', data.mass2_vel'] ;
for idx = 2:length( titoli )
    load( titoli{idx}, 'data' );
    inputs{1,idx} = data.voltage';
    outputs{1,idx} = [data.mass1_pos', data.mass1_vel', data.mass2_pos', data.mass2_vel'] ;
end

data_to_est = iddata( outputs, inputs, 0.002 );

opt = greyestOptions('EnforceStability',true, 'WeightingFilter', [0.1,150] );
opt.SearchOptions.MaxIterations = 600;
greybox_id_2dof = greyest( data_to_est, nominal_sys_2dof, opt );
greybox_id_2dof.Notes = "Dati con filtro a 25 Hz";
greybox_id_2dof.Name = "greybox id 2dof";

figure
bode( greybox_id_2dof, {1,150} ); hold on; legend

%% Dati con filtro a 25 Hz (dati filterok)

% titoli = { 'voltage_step_2dof_-4V_filterok.mat', 'voltage_step_2dof_2V_filterok.mat' };
% 
% load( titoli{1}, 'data' );
% inputs{1,1} = data.voltage';
% outputs{1,1} = [data.mass1_pos', data.mass1_vel', data.mass2_pos', data.mass2_vel'] ;
% for idx = 2:length( titoli )
%     load( titoli{idx}, 'data' );
%     inputs{1,idx} = data.voltage';
%     outputs{1,idx} = [data.mass1_pos', data.mass1_vel', data.mass2_pos', data.mass2_vel'] ;
% end
% 
% data_to_est = iddata( outputs, inputs, 0.002 );
% 
% opt = greyestOptions('EnforceStability',true, 'WeightingFilter', [0.01,100] );
% opt.SearchOptions.MaxIterations = 20;
% greybox_id_2dof_filterok = greyest( data_to_est, nominal_sys_2dof, opt );
% greybox_id_2dof_filterok.Notes = "Dati con filtro a 25Hz";
% greybox_id_2dof_filterok.Name = "greybox id 2dof filterOk";
% 
% bode( greybox_id_2dof_filterok, {0.1,100} )
