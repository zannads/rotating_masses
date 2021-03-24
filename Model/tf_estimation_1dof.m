data1 = data_loader;
% data2 = data_loader;
% 
% experiment1 = iddata( data1.mass1_vel', data1.voltage', 0.002 );
% experiment2 = iddata( data2.mass1_vel', data2.voltage', 0.002 );
% 
% experiment = merge( experiment1, experiment2 );

data_to_fit = iddata( data1.mass1_vel', data1.voltage', 0.002 );

% data_to_fit = EXPERIMENT_HANDLER( TIME INZIIO, % NUMERO DI ESP/TIME FINE,
% INOUT, OUTPUT); 

v_to_mass1_vel = tfest( data_to_fit, 4)

bode( v_to_mass1_vel );
grid on;
