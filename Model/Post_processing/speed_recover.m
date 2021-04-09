%RECOVER WRONG SPEED
titoli = { 'voltage_step_1dof_-10V.mat', 'voltage_step_1dof_-8V.mat', 'voltage_step_1dof_-6V.mat', ...
    'voltage_step_1dof_-4V.mat', 'voltage_step_1dof_-2V.mat', 'voltage_step_1dof_2V.mat', ...
    'voltage_step_1dof_4V.mat', 'voltage_step_1dof_6V.mat', 'voltage_step_1dof_8V.mat', ...
    'voltage_step_1dof_10V.mat', 'voltage_step_2dof_-10V.mat', 'voltage_step_2dof_-8V.mat', 'voltage_step_2dof_-6V.mat', ...
    'voltage_step_2dof_-4V.mat', 'voltage_step_2dof_-2V.mat', 'voltage_step_2dof_2V.mat', ...
    'voltage_step_2dof_4V.mat', 'voltage_step_2dof_6V.mat', 'voltage_step_2dof_8V.mat', ...
    'voltage_step_2dof_10V.mat'  };


for idx = 1:length(titoli)
    load( titoli{idx}, 'data' );
    posint = intpos( data.mass1_pos );
%     plot( data.time, [data.mass1_pos; posint])
    
    vel = diffvel( posint );
    vel = lsim( tf( 25*2*pi, [1, 25*2*pi] ), vel, data.time )';
%     hold on;
%     plot( data.time, [data.mass1_vel; vel])
    data.mass1_pos = posint;
    data.mass1_vel = vel;
    
    posint = intpos( data.mass2_pos );
%     plot( data.time, [data.mass2_pos; posint])
    
    vel = diffvel( posint );
    vel = lsim( tf( 25*2*pi, [1, 25*2*pi] ), vel, data.time )';
%     hold on; 
%     plot( data.time, [data.mass2_vel; vel]);
%     legend('pos','intpos', 'vel', 'diffvel new' , 'pos2', 'intpos2', 'vel2', 'diffvel new2' );
    data.mass2_pos = posint;
    data.mass2_vel = vel;
    
    names = fieldnames( data );
    for jdx = 1:numel(names)
        temp = data.(names{jdx});
        data.(names{jdx}) = temp(1:end-5);
    end
    
    save( titoli{idx}, 'data' );
end


%%
function out = intpos( mass_pos )
giri = 0;
out = zeros( size(mass_pos) );
out(1) = mass_pos(1);
for idx = 2:length( mass_pos )
    if ( mass_pos(idx) - mass_pos(idx-1) > 6 )%rad
        giri = giri-1;
    elseif ( mass_pos(idx) - mass_pos(idx-1) < - 6 )%rad
        giri = giri+1;
    end
    
    out(idx) = mass_pos(idx) + giri*2*pi;
end
end

function mass_vel = diffvel( mass_pos )
ts = 0.002;

mass_vel = (mass_pos- [0, mass_pos(1:end-1)] )/ts;
end