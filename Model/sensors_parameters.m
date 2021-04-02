% Potentiometer
volt_to_deg_potentiometer = 35.2; % [deg/V]
deg_to_rad = pi/180;

% Load encoder
pulse_per_rev_encoder = 4096;
pulse_to_rad = 2*pi/pulse_per_rev_encoder;

% Motor saturation
V_th = V_max*1;