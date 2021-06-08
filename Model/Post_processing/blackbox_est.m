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

blackbox_id_1dof_withZeros = tfest( experiment, 4, 2 );
blackbox_id_1dof_withZeros.Notes = "Dati con filtro a 25 Hz";
blackbox_id_1dof_withZeros.Name = "blackbox id 1dof with zeros";

blackbox_id_1dof = tfest( experiment, 4, 0 );
blackbox_id_1dof.Notes = "Dati con filtro a 25 Hz";
blackbox_id_1dof.Name = "blackbox id 1dof";

[magn1,phas1,w1] = bode(blackbox_id_1dof_withZeros);
[magn2,phas2,w2] = bode(blackbox_id_1dof);

figure
subplot(2,1,1)
plot(w1,20*log10(magn1(:)))
set(gca, 'XScale', 'log')
ylabel( 'Magnitude (dB)' )
grid on; hold on
plot(w2,20*log10(magn2(:)))
legend( '$G_{V,\dot{\theta}_1}$ with zeros', '$G_{V,\dot{\theta}_1}$ without zeros', ...
    'Interpreter', 'Latex' )
title( '2-dof $G_{V,\dot{\theta}_1}$ black-boxes', 'Interpreter', 'Latex' )
xlim( [10, 200] )

subplot(2,1,2)
plot(w1,phas1(:))
set(gca, 'XScale', 'log')
xlabel( 'Frequency (rad/s)' )
ylabel( 'Phase (deg)' )
grid on; hold on
plot(w2,phas2(:))
xlim( [10, 200] )
ylim( [-180,180] )

% bode( blackbox_id_1dof_withZeros, {10,200} );
% grid on; hold on; legend
% bode( blackbox_id_1dof, {10,200} );
% title( 'Bode diagram: $G_{v,\dot{\theta}_1}$', 'Interpreter', 'Latex' )

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

blackbox_id_2dof_withZeros = tfest( experiment, 6, 2 );
blackbox_id_2dof_withZeros.Notes = "Dati con filtro a 25 Hz";
blackbox_id_2dof_withZeros.Name = "blackbox id 2dof with zeros";

blackbox_id_2dof = tfest( experiment, 6, 0 );
blackbox_id_2dof.Notes = "Dati con filtro a 25 Hz";
blackbox_id_2dof.Name = "blackbox id 2dof";

[magn1,phas1,w1] = bode(blackbox_id_2dof_withZeros);
[magn2,phas2,w2] = bode(blackbox_id_2dof);

figure
subplot(2,1,1)
plot(w1,20*log10(magn1(:)))
set(gca, 'XScale', 'log')
ylabel( 'Magnitude (dB)' )
grid on; hold on
plot(w2,20*log10(magn2(:)))
legend( '$G_{V,\dot{\theta}_2}$ with zeros', '$G_{V,\dot{\theta}_2}$ without zeros', ...
    'Interpreter', 'Latex' )
title( '2-dof $G_{V,\dot{\theta}_1}$ black-boxes', 'Interpreter', 'Latex' )
xlim( [10, 200] )

subplot(2,1,2)
plot(w1,phas1(:))
set(gca, 'XScale', 'log')
xlabel( 'Frequency (rad/s)' )
ylabel( 'Phase (deg)' )
grid on; hold on
plot(w2,phas2(:))
xlim( [10, 200] )
ylim( [-360,180] )

% figure
% bode( blackbox_id_2dof, {1,150} ); hold on; legend

