% 1 dof Hinf 
% y = Cx = [theta_1_ref, theta_l; -theta_1];
% w = [theta_1_ref; noise(x_y)]
% z = [err; u; y];

A_sys = greybox_id_1dof.A;
B_sys = greybox_id_1dof.B;
C_sys = greybox_id_1dof.C;
C_control = [0,0,-1,0];         %meno del sensore che legge opposto
D_sys = greybox_id_1dof.D;

Q_tilde = eye(4)*1e-8;
R_tilde = diag( [potentiometer_var, encoder_var] );

nx = 4;
ny = 2;
n = nx+ny;

B_w = [sqrt( Q_tilde ),        zeros(nx, ny)];
D_w = [zeros(ny, nx),          sqrt( R_tilde ) ];

Dw_tilde_control = [zeros(1,4),        0,  sqrt( encoder_var ) ];
%%
% xe -> \dot x \dot e 
% A_ext = [A_sys,     zeros(4,1);
%          [0,0,1,0], 0];
% 
% % w -> \dot x \dot e
% B_ext1 = [zeros(4,1), B_w;
%           1,         -Dw_tilde_control];
%       
% % u -> 1dot x \dot e 
% B_ext2 = [B_sys;
%            0];
% %%
% % xe -> z
% C_ext1 = [zeros(1,4), 1];
% % xe -> y 
% C_ext2 = [zeros(1,4), 1;
%           C_sys,      zeros(2,1)];
% %%     
% % w -> z       
% D_ext11 = zeros( 1, 7);
% % u -> z
% D_ext12 = 0;
% % w -> y
% D_ext21 = [0,           zeros(1, 6);
%            zeros(2, 1), D_w];
% % u -> y
% D_ext22 = [ 0;
%             D_sys];
% %%
% B_ext = [B_ext1, B_ext2];
% C_ext = [C_ext1;
%          C_ext2];
%     
% D_ext = [D_ext11, D_ext12;
%          D_ext21, D_ext22];
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


controller.active_technique = 11;

er = sumblk( 'e = r-y1' );

Desired_E = 0.01*1e-5*tf([20, 1], [0.005, 1] )*tf([20, 1], [0.01, 1] );
W_e = 1/Desired_E;
W_e.InputName = 'e';
W_e.OutputName = 'e1';


W_u = 0.99*tf( [1, 1*2*pi], [1, 100*2*pi] ) ;
W_u.InputName = 'u';
W_u.OutputName = 'e2';


P = ss( A_ext, [B_ext1, B_ext2], C_ext, [D_ext1, D_ext2] );
P.InputName = {'r', 'n1', 'n2', 'n3', 'n4', 'n5', 'n6', 'u'};
P.OutputName = {'yl', 'y1' };

aug_input = {'r', 'n1', 'n2', 'n3', 'n4', 'n5', 'n6', 'u'};
aug_output = {'e1', 'e2', 'e', 'yl', 'y1'};

aug_P = connect( P, W_e, W_u, er, aug_input, aug_output );

[controller.c11, ~, gamma] = hinfsyn( aug_P, 3, 1 )
