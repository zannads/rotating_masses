%% 1 dof Hinf 
% y = [err, theta_l; theta_1];
% w = [theta_1_ref; noise_x; noise_y]
% z = [err; u; y1];

sensors_parameters;

A_sys = greybox_id_1dof.A;
B_sys = greybox_id_1dof.B;
C_sys = greybox_id_1dof.C;
D_sys = greybox_id_1dof.D;

Q_tilde = diag( [0.3e-4, 1e-2, 1e-8, 1e-4] );
R_tilde = diag( [potentiometer_var, encoder_var] );

nx = 4;
ny = 2;
n = nx+ny;

B_w = [sqrt( Q_tilde ),        zeros(nx, ny)];
D_w = [zeros(ny, nx),          sqrt( R_tilde ) ];

%% 
% x -> \dot x
A_ext = A_sys;

% w -> \dot x 
B_ext1 = [zeros(nx,1), B_w];
      
% u -> \dot x
B_ext2 = B_sys;
%%
% x -> y 
C_ext = C_sys;
%%     
% w -> y
D_ext1 = [zeros( ny,1), D_w ];
% u -> y
D_ext2 = D_sys;

er = sumblk( 'e = r-y1' );

Desired_E = tf( [1, 0.01], [1, 30] );
W_e = 1/Desired_E;
W_e.InputName = 'e';
W_e.OutputName = 'e1';

W_u = tf( [1, 0.1], [1, 150] ) ;
W_u.InputName = 'u';
W_u.OutputName = 'e2';

Desired_T1 = 0.01*tf( [1, 200], [1, 10] );
W_t1 = 1/Desired_T1;
W_t1.InputName = 'y1';
W_t1.OutputName = 'e3';

P = ss( A_ext, [B_ext1, B_ext2], C_ext, [D_ext1, D_ext2] );
P.InputName = {'r', 'n1', 'n2', 'n3', 'n4', 'n5', 'n6', 'u'};
P.OutputName = {'yl', 'y1' };

aug_input = {'r', 'n1', 'n2', 'n3', 'n4', 'n5', 'n6', 'u'};
aug_output = {'e1', 'e2', 'e3', 'e', 'yl', 'y1'};

aug_P = connect( P, W_e, W_u, W_t1, er, aug_input, aug_output );

[controller.c11, ~, gamma] = hinfsyn( aug_P, 3, 1 );

%% 2 dof Hinf 
% y = [err, theta_l; theta_1; theta_2];
% w = [theta_2_ref; noise_x; noise_y]
% z = [err; u; y2];

A_sys = greybox_id_2dof.A;
B_sys = greybox_id_2dof.B;
C_sys = greybox_id_2dof.C;
D_sys = greybox_id_2dof.D;

Q_tilde = diag( [0.3e-4, 1e-2, 1e-8, 1e-4, 1e-8, 1e-4] );
R_tilde = diag( [potentiometer_var, encoder_var, encoder_var] );

nx = 6;
ny = 3;
n = nx+ny;

B_w = [sqrt( Q_tilde ),        zeros(nx, ny)];
D_w = [zeros(ny, nx),          sqrt( R_tilde ) ];

%% 
% x -> \dot x
A_ext = A_sys;

% w -> \dot x 
B_ext1 = [zeros(nx,1), B_w];
      
% u -> \dot x
B_ext2 = B_sys;
%%
% x -> y 
C_ext = C_sys;
%%     
% w -> y
D_ext1 = [zeros( ny,1), D_w ];
% u -> y
D_ext2 = D_sys;

er = sumblk( 'e = r-y2' );

Desired_E = 2*tf( [1, 0.01], [1, 30] );
W_e = 1/Desired_E;
W_e.InputName = 'e';
W_e.OutputName = 'e1';

Desired_u = 2 * tf( [1 30],[1 10] ) * tf( [1 50],[1 300] );

W_u = tf(0.9);
W_u.InputName = 'u';
W_u.OutputName = 'e2';

Desired_T1 = 0.01*tf( [1, 200], [1, 10] );
W_t1 = 1/Desired_T1;
W_t1.InputName = 'y1';
W_t1.OutputName = 'e3';

Desired_T2 = 0.01*tf( [1, 200], [1, 10] );
W_t2 = 1/Desired_T2;
W_t2.InputName = 'y2';
W_t2.OutputName = 'e4';

P = ss( A_ext, [B_ext1, B_ext2], C_ext, [D_ext1, D_ext2] );
P.InputName = {'r', 'n1', 'n2', 'n3', 'n4', 'n5', 'n6', 'n7', 'n8', 'n9', 'u'};
P.OutputName = {'yl', 'y1', 'y2' };

aug_input = {'r', 'n1', 'n2', 'n3', 'n4', 'n5', 'n6', 'n7', 'n8', 'n9', 'u'};
aug_output = {'e1', 'e2', 'e3','e4', 'e', 'yl', 'y1', 'y2'};

aug_P = connect( P, W_e, W_u, W_t1 ,W_t2, er, aug_input, aug_output );

[controller.c12, ~, gamma] = hinfsyn( aug_P, 4, 1 );
