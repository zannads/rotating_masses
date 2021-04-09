%% Blackbox estimation: 1dof

data1 = load( 'voltage_step_1dof_-10V.mat', 'data');
data2 = load( 'voltage_step_1dof_-8V.mat', 'data');
data3 = load( 'voltage_step_1dof_-6V.mat', 'data');
data4 = load( 'voltage_step_1dof_-4V.mat', 'data');
data5 = load( 'voltage_step_1dof_-2V.mat', 'data');
data6 = load( 'voltage_step_1dof_2V.mat', 'data');
data7 = load( 'voltage_step_1dof_4V.mat', 'data');
data8 = load( 'voltage_step_1dof_6V.mat', 'data');
data9 = load( 'voltage_step_1dof_8V.mat', 'data');
data10 = load( 'voltage_step_1dof_10V.mat', 'data');

data1_filtered = load( 'voltage_step_1dof_-10V_filterok.mat', 'data');
data2_filtered = load( 'voltage_step_1dof_-6V_filterok.mat', 'data');
data3_filtered = load( 'voltage_step_1dof_2V_filterok.mat', 'data');

experiment1_filterok = iddata( -filter_transform( data1.data.time, data1.data.mass1_vel ), data1.data.voltage', 0.002 );
experiment2_filterok = iddata( -filter_transform( data2.data.time, data2.data.mass1_vel ), data2.data.voltage', 0.002 );
experiment3_filterok = iddata( -filter_transform( data3.data.time, data3.data.mass1_vel ), data3.data.voltage', 0.002 );
experiment4_filterok = iddata( -filter_transform( data4.data.time, data4.data.mass1_vel ), data4.data.voltage', 0.002 );
experiment5_filterok = iddata( -filter_transform( data5.data.time, data5.data.mass1_vel ), data5.data.voltage', 0.002 );
experiment6_filterok = iddata( -filter_transform( data6.data.time, data6.data.mass1_vel ), data6.data.voltage', 0.002 );
experiment7_filterok = iddata( -filter_transform( data7.data.time, data7.data.mass1_vel ), data7.data.voltage', 0.002 );
experiment8_filterok = iddata( -filter_transform( data8.data.time, data8.data.mass1_vel ), data8.data.voltage', 0.002 );
experiment9_filterok = iddata( -filter_transform( data9.data.time, data9.data.mass1_vel ), data9.data.voltage', 0.002 );
experiment10_filterok = iddata( -filter_transform( data10.data.time, data10.data.mass1_vel ), data10.data.voltage', 0.002 );

experiment1_filtered = iddata( -filter_transform( data1_filtered.data.time, data1_filtered.data.mass1_vel ), data1_filtered.data.voltage', 0.002 );
experiment2_filtered = iddata( -filter_transform( data2_filtered.data.time, data2_filtered.data.mass1_vel ), data2_filtered.data.voltage', 0.002 );
experiment3_filtered = iddata( -filter_transform( data3_filtered.data.time, data3_filtered.data.mass1_vel ), data3_filtered.data.voltage', 0.002 );

experiment1 = iddata( -data1.data.mass1_vel', data1.data.voltage', 0.002 );
experiment2 = iddata( -data2.data.mass1_vel', data2.data.voltage', 0.002 );
experiment3 = iddata( -data3.data.mass1_vel', data3.data.voltage', 0.002 );
experiment4 = iddata( -data4.data.mass1_vel', data4.data.voltage', 0.002 );
experiment5 = iddata( -data5.data.mass1_vel', data5.data.voltage', 0.002 );
experiment6 = iddata( -data6.data.mass1_vel', data6.data.voltage', 0.002 );
experiment7 = iddata( -data7.data.mass1_vel', data7.data.voltage', 0.002 );
experiment8 = iddata( -data8.data.mass1_vel', data8.data.voltage', 0.002 );
experiment9 = iddata( -data9.data.mass1_vel', data9.data.voltage', 0.002 );
experiment10 = iddata( -data10.data.mass1_vel', data10.data.voltage', 0.002 );

experiment_compare = iddata( -data_compare.mass1_vel(:,2), data_compare.voltage(:,2), 0.002 );

experiment = merge( experiment1, experiment2, experiment3, experiment4, experiment5, ...
   experiment6, experiment7, experiment8, experiment9, experiment10);

experiment_filterok = merge( experiment1_filterok, experiment2_filterok, experiment3_filterok, experiment4_filterok, ...
    experiment5_filterok, experiment6_filterok, experiment7_filterok, experiment8_filterok, experiment9_filterok, ...
    experiment10_filterok );

experiment_filtered = merge( experiment1_filtered, experiment2_filtered, experiment3_filtered );

%experiment = merge( experiment1, experiment3, experiment6 );
%data_to_fit = iddata( data1.mass1_vel', data1.voltage', 0.002 );

% data_to_fit = EXPERIMENT_HANDLER( TIME INZIIO, % NUMERO DI ESP/TIME FINE,
% INOUT, OUTPUT); 

blackbox_id_1dof = tfest( experiment, 5, 1 )
blackbox_id_1dof_filterok = tfest( experiment_filterok, 5, 1 )
blackbox_id_1dof_filtered = tfest( experiment_filtered, 5, 1 )

blackbox_compare = tfest( experiment_compare, 5, 1 )

% bode( blackbox_id_1dof );
% grid on;
% damp(blackbox_id_1dof)

%% Blackbox estimation: 2dof

data1 = load( 'voltage_step_2dof_-10V.mat', 'data');
data2 = load( 'voltage_step_2dof_-8V.mat', 'data');
data3 = load( 'voltage_step_2dof_-6V.mat', 'data');
data4 = load( 'voltage_step_2dof_-4V.mat', 'data');
data5 = load( 'voltage_step_2dof_-2V.mat', 'data');
data6 = load( 'voltage_step_2dof_2V.mat', 'data');
data7 = load( 'voltage_step_2dof_4V.mat', 'data');
data8 = load( 'voltage_step_2dof_6V.mat', 'data');
data9 = load( 'voltage_step_2dof_8V.mat', 'data');
data10 = load( 'voltage_step_2dof_10V.mat', 'data');

experiment1 = iddata( -data1.data.mass2_vel', data1.data.voltage', 0.002 );
experiment2 = iddata( -data2.data.mass2_vel', data2.data.voltage', 0.002 );
experiment3 = iddata( -data3.data.mass2_vel', data3.data.voltage', 0.002 );
experiment4 = iddata( -data4.data.mass2_vel', data4.data.voltage', 0.002 );
experiment5 = iddata( -data5.data.mass2_vel', data5.data.voltage', 0.002 );
experiment6 = iddata( -data6.data.mass2_vel', data6.data.voltage', 0.002 );
experiment7 = iddata( -data7.data.mass2_vel', data7.data.voltage', 0.002 );
experiment8 = iddata( -data8.data.mass2_vel', data8.data.voltage', 0.002 );
experiment9 = iddata( -data9.data.mass2_vel', data9.data.voltage', 0.002 );
experiment10 = iddata( -data10.data.mass2_vel', data10.data.voltage', 0.002 );

experiment = merge( experiment1, experiment2, experiment3, experiment4, experiment5, ...
   experiment6, experiment7, experiment8, experiment9, experiment10);
%experiment = merge( experiment1, experiment3, experiment6 );
%data_to_fit = iddata( data1.mass1_vel', data1.voltage', 0.002 );

% data_to_fit = EXPERIMENT_HANDLER( TIME INZIIO, % NUMERO DI ESP/TIME FINE,
% INOUT, OUTPUT); 

blackbox_id_2dof = tfest( experiment, 7 )

% bode( blackbox_id_1dof );
% grid on;
% damp(blackbox_id_1dof)

