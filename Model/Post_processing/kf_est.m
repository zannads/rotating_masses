% KF1dof = ss( controller.KF_1dof.A, controller.KF_1dof.B, controller.KF_1dof.C, controller.KF_1dof.D );
% minKF1dof_enc1 = ss( controller.minKF_1dof_enc1.A, controller.minKF_1dof_enc1.B, controller.minKF_1dof_enc1.C, controller.minKF_1dof_enc1.D );
% minKF1dof_pot = ss( controller.minKF_1dof_pot.A, controller.minKF_1dof_pot.B, controller.minKF_1dof_pot.C, controller.minKF_1dof_pot.D );
% 
% x1dof = lsim( KF1dof, [data.voltage; data.motor_pos; data.mass1_pos], data.time );

A_sys = greybox_id_1dof.A;
B_sys = greybox_id_1dof.B;
% e-4 e-2 il top 
Q(:,:,1) = diag( [1e-4, 1e-2, 1e-4, 1e-2] );
Q(:,:,2) = diag( [0.3e-5, 1e-3, 1e-3, 1e-1] );
Q(:,:,3) = diag( [1e-4, 1e-2, 1e-4, 1e-3] );
Q(:,:,4) = diag( [1e-4, 1e-3, 1e-4, 1e-2] );
Q(:,:,5) = diag( [1e-4, 1e-1, 1e-4, 1e-2] );
Q(:,:,6) = diag( [1e-4, 1e-2, 1e-5, 1e-2] );
Q(:,:,7) = diag( [1e-3, 1e-1, 1e-3, 1e-1] );
Q(:,:,8) = diag( [1e-2, 1e-1, 1e-2, 1e-1] );
figure;
for idx = 2
    
    D_sys = zeros(2,1);
    C_sys = [0,0,-1,0];
    R = 2e-8;
    Q(:,:,idx)
    [~, L, ~, ~] = icare( A_sys', C_sys', Q(:,:,idx), R );
    L = L';
    minKF_1dof_enc1_p = ss(  A_sys-L*C_sys, [B_sys, L], eye(4), zeros(4,2) );
    x1dof_enc1_p = lsim( minKF_1dof_enc1_p, [data.voltage; data.mass1_pos], data.time );

    R = 1e-6;
    C_sys = [1, 0, 0, 0];
    
    [~, L, ~, ~] = icare( A_sys', C_sys', Q(:,:,idx), R );
    L = L';
    minKF_1dof_pot_p = ss(  A_sys-L*C_sys, [B_sys, L], eye(4), zeros(4,2) );
    x1dof_pot_p = lsim( minKF_1dof_pot_p, [data.voltage; data.motor_pos], data.time );
    
    R = [1e-6, 0;
          0, 2e-8];
    C_sys = [1,0,0,0;
        0,0,-1,0];
    
    [~, L, ~, ~] = icare( A_sys', C_sys', Q(:,:,idx), R );
    L = L';
    minKF_1dof_p = ss(  A_sys-L*C_sys, [B_sys, L], eye(4), zeros(4,3) );
    x1dof_p = lsim( minKF_1dof_p, [data.voltage; data.motor_pos; data.mass1_pos], data.time );
    
    
    subplot 221;
    title( num2str( idx) );
    hold on;
    plot( data.time, x1dof_p(:, 1), 'r');
    plot( data.time, x1dof_enc1_p(:, 1)', 'm' );
    plot( data.time, data.motor_pos, 'b' );
    plot( data.time, -data.mass1_pos, 'b' );
    plot( data.time, x1dof_pot_p(:, 1), 'k' );
    subplot 222;
    hold on;
    plot( data.time, x1dof_p(:, 2), 'r');
    plot( data.time, x1dof_enc1_p(:, 2)', 'm' );
    plot( data.time, data.motor_vel, 'b' );
    plot( data.time, x1dof_pot_p(:, 2), 'k' );
    subplot 223;
    hold on
    plot( data.time, x1dof_p(:, 3), 'r');
    plot( data.time, x1dof_enc1_p(:, 3)', 'm' );
    plot( data.time, -data.mass1_pos, 'b' );
    plot( data.time, x1dof_pot_p(:, 3), 'k' );
    subplot 224;
    title( num2str( idx) );
    hold on;
    plot( data.time, x1dof_p(:, 4), 'r');
    plot( data.time, x1dof_enc1_p(:, 4)', 'm' );
    plot( data.time, -data.mass1_vel, 'b' );
    plot( data.time, x1dof_pot_p(:, 4), 'k' );
    damp( minKF_1dof_enc1_p);
    damp( minKF_1dof_pot_p);
    damp( minKF_1dof_p )
end