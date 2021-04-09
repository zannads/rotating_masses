%% Greybox estimation: 1-dof

%% Dati con filtro a 25rad/s, con filtro spostato a 25Hz

titoli = { 'voltage_step_1dof_-10V.mat', 'voltage_step_1dof_-8V.mat', 'voltage_step_1dof_-6V.mat', ...
    'voltage_step_1dof_-4V.mat', 'voltage_step_1dof_-2V.mat', 'voltage_step_1dof_2V.mat', ...
    'voltage_step_1dof_4V.mat', 'voltage_step_1dof_6V.mat', 'voltage_step_1dof_8V.mat', ...
    'voltage_step_1dof_10V.mat' };

load( titoli{1}, 'data' );
inputs{1,1} = data.voltage';
outputs{1,1} = data.mass1_vel';
for idx = 2:length( titoli )
    load( titoli{idx}, 'data' );
    inputs{1,idx} = data.voltage';
    outputs{1,idx} = data.mass1_vel';
end

data_to_est = iddata( outputs, inputs, 0.002 );

opt = greyestOptions('EnforceStability',true, 'WeightingFilter', [0.01,70] );
opt.SearchOptions.MaxIterations = 40;
greybox_id_1dof = greyest( data_to_est, nominal_sys_1dof, opt );

figure
bode( greybox_id_1dof, {0.1,100} ); hold on; legend

%% Dati con filtro a 25Hz

titoli = { 'voltage_step_1dof_-10V_filterok.mat', 'voltage_step_1dof_-6V_filterok.mat', 'voltage_step_1dof_2V_filterok.mat' };

load( titoli{1}, 'data' );
inputs{1,1} = data.voltage';
outputs{1,1} = data.mass1_vel';
for idx = 2:length( titoli )
    load( titoli{idx}, 'data' );
    inputs{1,idx} = data.voltage';
    outputs{1,idx} = data.mass1_vel';
end

data_to_est = iddata( outputs, inputs, 0.002 );

opt = greyestOptions('EnforceStability',true, 'WeightingFilter', [0.01,70] );
opt.SearchOptions.MaxIterations = 40;
greybox_id_1dof_filterok = greyest( data_to_est, nominal_sys_1dof, opt );

bode( greybox_id_1dof_filterok, {0.1,100} )

%% Greybox estimation: 2-dof

%% Dati con filtro a 25rad/s, con filtro spostato a 25Hz

titoli = { 'voltage_step_2dof_-10V.mat', 'voltage_step_2dof_-8V.mat', 'voltage_step_2dof_-6V.mat', ...
    'voltage_step_2dof_-4V.mat', 'voltage_step_2dof_-2V.mat', 'voltage_step_2dof_2V.mat', ...
    'voltage_step_2dof_4V.mat', 'voltage_step_2dof_6V.mat', 'voltage_step_2dof_8V.mat', ...
    'voltage_step_2dof_10V.mat' };

load( titoli{1}, 'data' );
inputs{1,1} = data.voltage';
outputs{1,1} = data.mass2_vel';
for idx = 2:length( titoli )
    load( titoli{idx}, 'data' );
    inputs{1,idx} = data.voltage';
    outputs{1,idx} = data.mass2_vel';
end

data_to_est = iddata( outputs, inputs, 0.002 );

opt = greyestOptions('EnforceStability',true, 'WeightingFilter', [0.01,70] );
opt.SearchOptions.MaxIterations = 60;
greybox_id_2dof = greyest( data_to_est, nominal_sys_2dof, opt );

figure
bode( greybox_id_2dof, {0.1,100} ); hold on; legend

%% Dati con filtro a 25Hz

titoli = { 'voltage_step_2dof_-4V_filterok.mat', 'voltage_step_2dof_2V_filterok.mat' };

load( titoli{1}, 'data' );
inputs{1,1} = data.voltage';
outputs{1,1} = data.mass2_vel';
for idx = 2:length( titoli )
    load( titoli{idx}, 'data' );
    inputs{1,idx} = data.voltage';
    outputs{1,idx} = data.mass2_vel';
end

data_to_est = iddata( outputs, inputs, 0.002 );

opt = greyestOptions('EnforceStability',true, 'WeightingFilter', [0.01,70] );
opt.SearchOptions.MaxIterations = 60;
greybox_id_2dof_filterok = greyest( data_to_est, nominal_sys_2dof, opt );

bode( greybox_id_2dof_filterok, {0.1,100} )
