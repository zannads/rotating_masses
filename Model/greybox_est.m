%% Greybox estimation

data1 = load( 'voltage_step_1dof_-10V_filterok.mat', 'data');
% data2 = load( 'voltage_step_1dof_-8V.mat', 'data');
data3 = load( 'voltage_step_1dof_-6V_filterok.mat', 'data');
% data4 = load( 'voltage_step_1dof_-4V.mat', 'data');
% data5 = load( 'voltage_step_1dof_-2V.mat', 'data');
data6 = load( 'voltage_step_1dof_2V_filterok.mat', 'data');
% data7 = load( 'voltage_step_1dof_4V.mat', 'data');
% data8 = load( 'voltage_step_1dof_6V.mat', 'data');
% data9 = load( 'voltage_step_1dof_8V.mat', 'data');
% data10 = load( 'voltage_step_1dof_10V.mat', 'data');
% dataX = load( 'sinesweep_1V_0_10Hz_ave5V.mat', 'data' );
% figure
% plot(dataX.data.time, dataX.data.mass1_vel); hold on
% w_filter = 2*pi*25;
% dataX.data.mass1_vel = lsim( tf(w_filter,[1 w_filter]), dataX.data.mass1_vel, (0:length(dataX.data.mass1_vel)-1)*0.002 )';
% plot(dataX.data.time, dataX.data.mass1_vel)

% experiment1 = iddata( data1.data.mass1_vel', data1.data.voltage', 0.002 );
% experiment2 = iddata( data2.data.mass1_vel', data2.data.voltage', 0.002 );
% experiment3 = iddata( data3.data.mass1_vel', data3.data.voltage', 0.002 );
% experiment4 = iddata( data4.data.mass1_vel', data4.data.voltage', 0.002 );
% experiment5 = iddata( data5.data.mass1_vel', data5.data.voltage', 0.002 );
% experiment6 = iddata( data6.data.mass1_vel', data6.data.voltage', 0.002 );
% experiment7 = iddata( data7.data.mass1_vel', data7.data.voltage', 0.002 );
% experiment8 = iddata( data8.data.mass1_vel', data8.data.voltage', 0.002 );
% experiment9 = iddata( data9.data.mass1_vel', data9.data.voltage', 0.002 );
% experiment10 = iddata( data10.data.mass1_vel', data10.data.voltage', 0.002 );

% experiment = { experiment1, experiment3, experiment6 };

% input = data.voltage';
% outputs = data.mass1_vel';

inputs = {data1.data.voltage', data3.data.voltage', data6.data.voltage'};
outputs = {-data1.data.mass1_vel', -data3.data.mass1_vel', -data6.data.mass1_vel'};

data_to_est = iddata( outputs, inputs, 0.002 );

opt = greyestOptions('EnforceStability',true, ...
    'WeightingFilter', [0.01,70] );
opt.SearchOptions.MaxIterations = 40;
sys_id = greyest( data_to_est, nominal_sys_1dof, opt );

figure
bode( ss( sys_id.A, sys_id.B, sys_id.C, sys_id.D ), {0.1,100} ); hold on
bode( G_opt )
bode( nominal_sys_1dof )