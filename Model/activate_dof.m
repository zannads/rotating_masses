% activate_dof
% Script to activate the d.o.f. for the simulink simulation and also for
% upload the right parameters derived by the grey-box identification.
disp( 'How many active d.o.f. has the system? ');
disp( '[1]' );
disp( '[2]' );
active_dof = input( '' );

%get parameters from the respective greybox
if active_dof == 1
    Rm = greybox_id_1dof.Structure.Parameters(1).Value;
    k_m = greybox_id_1dof.Structure.Parameters(2).Value;
    k_t = greybox_id_1dof.Structure.Parameters(3).Value;
    eta_m = greybox_id_1dof.Structure.Parameters(4).Value;
    eta_g = greybox_id_1dof.Structure.Parameters(5).Value;
    K_g = greybox_id_1dof.Structure.Parameters(6).Value;
    J_eq = greybox_id_1dof.Structure.Parameters(7).Value;
    B_eq = greybox_id_1dof.Structure.Parameters(8).Value;
    K_s1 = greybox_id_1dof.Structure.Parameters(9).Value;
    J_1 = greybox_id_1dof.Structure.Parameters(10).Value;
    B_1 = greybox_id_1dof.Structure.Parameters(11).Value;
    K_s2 = 1;
    J_2 = 1;
    B_2 = 1;
else
%     active_dof == 2
    active_dof = 2;
    Rm = greybox_id_2dof.Structure.Parameters(1).Value;
    k_m = greybox_id_2dof.Structure.Parameters(2).Value;
    k_t = greybox_id_2dof.Structure.Parameters(3).Value;
    eta_m = greybox_id_2dof.Structure.Parameters(4).Value;
    eta_g = greybox_id_2dof.Structure.Parameters(5).Value;
    K_g = greybox_id_2dof.Structure.Parameters(6).Value;
    J_eq = greybox_id_2dof.Structure.Parameters(7).Value;
    B_eq = greybox_id_2dof.Structure.Parameters(8).Value;
    K_s1 = greybox_id_2dof.Structure.Parameters(9).Value;
    J_1 = greybox_id_2dof.Structure.Parameters(10).Value;
    B_1 = greybox_id_2dof.Structure.Parameters(11).Value;
    K_s2 = greybox_id_2dof.Structure.Parameters(12).Value;
    J_2 = greybox_id_2dof.Structure.Parameters(13).Value;
    B_2 = greybox_id_2dof.Structure.Parameters(14).Value;
end