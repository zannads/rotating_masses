%% 1-dof
grey_1dof_vel = ss( greybox_id_1dof.A, greybox_id_1dof.B, ...
    greybox_id_1dof.C(2,:), greybox_id_1dof.D(2,:) );
bode( minreal( grey_1dof_vel ) ); hold on
bode( blackbox_id_1dof )

%% 2-dof
grey_2dof_vel = ss( greybox_id_2dof.A, greybox_id_2dof.B, ...
    greybox_id_2dof.C(4,:), greybox_id_2dof.D(4,:) );
bode( minreal( grey_2dof_vel ) ); hold on
bode( blackbox_id_2dof )
