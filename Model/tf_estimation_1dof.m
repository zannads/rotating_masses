data1 = data_loader;
% data2 = data_loader;
% 
% experiment1 = iddata( data1.mass1_vel', data1.voltage', 0.002 );
% experiment2 = iddata( data2.mass1_vel', data2.voltage', 0.002 );
% 
% experiment = merge( experiment1, experiment2 );

experiment = iddata( data1.mass1_vel', data1.voltage', 0.002 );
v_to_mass1_vel = tfest( experiment, 4)

bode( v_to_mass1_vel );
grid on;
