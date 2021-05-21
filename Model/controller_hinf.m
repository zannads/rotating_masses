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

B_w = [sqrt( Q_tilde ),     zeros(4, 2)];
D_w = [zeros(2,4),          sqrt( R_tilde ) ];

D_enc = [zeros(1,4),        0,  sqrt( encoder_var ) ];

% w -> \dot x
B_ext1 = [B_sys, B_w];

% x -> z
C_ext1 = [-C_control;       %meno della retroazione
           zeros(1,4);
           C_sys];

% x -> y 
C_ext2 = [zeros(1,4);
          C_sys];
       
% w -> z       
D_ext11 = [eye(1), -D_enc; 
           zeros(3, 7)   ];
       % u -> z
D_ext12 = [zeros(1); 
           eye(1);
           D_sys];
       % w -> y
D_ext21 = [ eye(1),         zeros( 1, 6);
            zeros(2, 1),    D_w];
% u -> y
D_ext22 = [ 0;
            D_sys];

A_ext = A_sys;
B_ext = [B_ext1, B_sys];
C_ext = [C_ext1;
         C_ext2];
    
D_ext = [D_ext11, D_ext12;
         D_ext21, D_ext22];
    

wB1=10; % desired closed-loop bandwidth
AA1=1/10; % desired disturbance attenuation inside bandwidth
M1=2 ; % desired bound on hinfnorm(S) & hinfnorm(T)
W_S=(s/M1+wB1)/(s+wB1*AA1); % Sensitivity weight
W_K=(0.0001*s+1)/(0.001*s+1); % Control weight can't be empty (d12).ne.0)
W_T=(s+wB1/M1)/(AA1*s+wB1); % Complementary sensitivity weight
figure; 
bode( W_T );
hold on;
bode( W_S );
bode( W_K );
grid on;
     
P = ss( A_ext, B_ext, C_ext, D_ext );
% W_S = 1;
% W_T = 1;
% W_K = 0.01;
% 
% P = augw( P, blkdiag( W_S, W_S, W_S, W_S, W_S, W_S, W_S), ...
%     blkdiag( W_K, W_K, W_K, W_K, W_K, W_K, W_K, W_K), ...
%     blkdiag( W_T, W_T, W_T, W_T, W_T, W_T, W_T) );

[K, CL, gamma] = hinfsyn( P, 3, 1 )