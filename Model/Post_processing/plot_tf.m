Gn_v_w1_1dof = minreal(nominal_sys_1dof.C(end,:)/(s*eye(4)-nominal_sys_1dof.A)*nominal_sys_1dof.B)
Gn_v_w1_2dof = minreal(nominal_sys_2dof.C(2,:)/(s*eye(6)-nominal_sys_2dof.A)*nominal_sys_2dof.B)
Gn_v_w2_2dof = minreal(nominal_sys_2dof.C(end,:)/(s*eye(6)-nominal_sys_2dof.A)*nominal_sys_2dof.B)

Gg_v_w1_1dof = minreal(greybox_id_1dof.C(end,:)/(s*eye(4)-greybox_id_1dof.A)*greybox_id_1dof.B)
Gg_v_w1_2dof = minreal(greybox_id_2dof.C(2,:)/(s*eye(6)-greybox_id_2dof.A)*greybox_id_2dof.B)
Gg_v_w2_2dof = minreal(greybox_id_2dof.C(end,:)/(s*eye(6)-greybox_id_2dof.A)*greybox_id_2dof.B)

figure;
hold on;
bode( Gn_v_w1_1dof ); 
bode( Gg_v_w1_1dof );
bode( blackbox_id_1dof ); 
legend( '$G^{nom}$ ', '$$G^{grey}$$', '$$G^{black}$$', 'Interpreter', 'latex' );
grid on;
title( '1-dof $G_{v,\dot \theta _1}$ comparison', 'Interpreter', 'latex');

figure;
hold on;
bode( Gn_v_w1_2dof ); 
bode( Gg_v_w1_2dof );
legend( '$G^{nom}$ ', '$$G^{grey}$$', 'Interpreter', 'latex' );
grid on;
title( '2-dof $G_{v,\dot \theta _1}$ comparison', 'Interpreter', 'latex');

figure;
hold on;
bode( Gn_v_w2_2dof ); 
bode( Gg_v_w2_2dof );
bode( blackbox_id_2dof ); 
legend( '$G^{nom}$ ',  '$$G^{grey}$$','$$G^{black}$$', 'Interpreter', 'latex' );
grid on;
title( '2-dof $G_{v,\dot \theta _2}$ comparison', 'Interpreter', 'latex');

%% disturbances 

B_d_1dof = [0,0,0,b_d_1/J_1]';
B_d_2dof = [0,0,0, 0, 0, 2/J_2]';

Gg_d_w1_1dof = minreal(greybox_id_1dof.C(end,:)/(s*eye(4)-greybox_id_1dof.A)*B_d_1dof)
Gg_d_w1_2dof = minreal(greybox_id_2dof.C(2,:)/(s*eye(6)-greybox_id_2dof.A)*B_d_2dof)
Gg_d_w2_2dof = minreal(greybox_id_2dof.C(end,:)/(s*eye(6)-greybox_id_2dof.A)*B_d_2dof)

figure;
hold on;
bode( Gg_d_w1_1dof );  
legend( '$G_{d,\dot \theta _1}$ ', 'Interpreter', 'latex' );
grid on;
title( '1-dof $G_{d,\dot \theta _1}$ comparison', 'Interpreter', 'latex');

figure;
hold on;
bode( Gg_d_w1_2dof ); 
bode( Gg_d_w2_2dof );
legend( '$G_1$ ', '$$G_2$$', 'Interpreter', 'latex' );
grid on;
title( '2-dof $G_{d,\dot \theta _1}$ $G_{d,\dot \theta _2}$ comparison', 'Interpreter', 'latex');

%%
R = -controller.c1.wc_v*(s/33.4+1)/s;
NF = controller.c1.Nf;
C = R*NF;
L = C*Gg_v_w1_1dof;
S = 1/(1+L);
F = L/(1+L);
Q = C/(1+L);

figure; 
hold on;
bode(L);
bode(S);
figure;
bode( S*Gg_d_w1_1dof );
figure;
bode(Q);

%%
R = -controller.c3.wc_v*(s/33.4+1)/s;
NF = controller.c3.Nf;
C = R*NF;
L = C*Gg_v_w2_2dof;
S = 1/(1+L);
F = L/(1+L);
Q = C/(1+L);

figure; 
hold on;
margin(L);
bode(S);
legend( '$L$ ', 'S', 'Interpreter', 'latex' );
grid on;
title( '2-dof L and S comparison', 'Interpreter', 'latex');

figure;
bode( S*Gg_d_w2_2dof );
hold on;
bode(F);
legend( '$Dist$', '$F$ ', 'Interpreter', 'latex' );
grid on;
title( 'Closed Loop TF', 'Interpreter', 'latex');

figure;
bode(Q);
grid on;
title( 'Control Sensitivity Loop TF', 'Interpreter', 'latex');

%%
close all;
C = -8.74/(s)*(s/34.9+1);
NF = ...
    (100^2/24.5/61.9)^2*...
    (s^2+2*0.137*(24.5)*s+(24.5)^2)*(s^2+2*0.0238*(61.9)*s+(61.9)^2)/...
    (s^2+2*100*s+100^2)^2;
L = C*NF*Gg_v_w2_2dof;
S = 1/(1+L);
F = L/(1+L);
Q = C/(1+L);

figure; 
%hold on;
bode(S);
margin(L);
%legend( '$S$ ', 'L', 'Interpreter', 'latex' );
grid on;
%title( '2-dof L and S comparison', 'Interpreter', 'latex');

figure;
bode( S*Gg_d_w2_2dof );
hold on;
bode(F);
legend( '$Dist$', '$F$ ', 'Interpreter', 'latex' );
grid on;
title( 'Closed Loop TF', 'Interpreter', 'latex');

figure;
bode(Q);
grid on;
title( 'Control Sensitivity Loop TF', 'Interpreter', 'latex');
