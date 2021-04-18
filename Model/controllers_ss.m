[data,experiment,controller] = e_h.prepare_simulation;
% experiment = e_h.load_experiment;

A_sys = greybox_id_1dof.A;
B_sys = greybox_id_1dof.B;
C_sys = -greybox_id_1dof.C;         % in lab, con sensori togliere i "-"
D_sys = -greybox_id_1dof.D;

%% Observer 1-dof

L = place( A_sys', C_sys', -[400 400.1 300 1] )';
A_obs = A_sys-L*C_sys;
B_obs = [B_sys-L*D_sys, L];
C_obs = eye(4);
D_obs = zeros(4,3);

%% LQG 1-dof

% K = place( A_sys, B_sys, [-40+20i -40-20.1i -100 -0] );
K = place( A_sys, B_sys, [-1, -20+20i, -20-20i, -3.38e+01] );
A_placed = A_sys-B_sys*K;
damp( A_placed )
eigs( A_placed )
