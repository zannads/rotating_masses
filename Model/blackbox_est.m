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

experiment = merge( experiment1, experiment2, experiment3, experiment4, experiment5, ...
   experiment6, experiment7, experiment8, experiment9, experiment10);
%experiment = merge( experiment1, experiment3, experiment6 );
%data_to_fit = iddata( data1.mass1_vel', data1.voltage', 0.002 );

% data_to_fit = EXPERIMENT_HANDLER( TIME INZIIO, % NUMERO DI ESP/TIME FINE,
% INOUT, OUTPUT); 

blackbox_id_1dof = tfest( experiment, 5)

% bode( blackbox_id_1dof );
% grid on;
% damp(blackbox_id_1dof)
