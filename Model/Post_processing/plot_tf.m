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