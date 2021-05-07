% Potentiometer
Vmin_pot = -4.8924;
Vmax_pot = 4.6855;
volt_to_deg_potentiometer = 352/(Vmax_pot-Vmin_pot); % [deg/V]
deg_to_rad = pi/180;

% Load encoder
pulse_per_rev_encoder = 4096;
pulse_to_rad = 2*pi/pulse_per_rev_encoder;

% Motor saturation
V_th = V_max*1;

%% Noise variances

potentiometer_var = 1e-6;
encoder_var = 2e-8;