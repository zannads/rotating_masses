%guided_script
%This is a simplified procedure for run the simulation on our Simulink.

% Create the variables and upload the desired d.o.f.
script

% create some dummies variable to make the scheme work. During the
% development phase this variables were the actual data uploaded in the
% laboratory.
time_ = [0:0.002:5]';
data.voltage = [time_, zeros( size(time_) )];
data.motor_pos = [time_, zeros( size(time_) )];
data.motor_vel = [time_, zeros( size(time_) )];
data.mass1_pos = [time_, zeros( size(time_) )];
data.mass1_vel = [time_, zeros( size(time_) )];
data.mass2_pos = [time_, zeros( size(time_) )];
data.mass2_vel = [time_, zeros( size(time_) )];

% load the desired experiment 
disp( 'Which of the classic experiment would you like to run ? ');
disp( '[1] multistep for position control' );
disp( '      pi/4 at 2 sec, -pi/2 at 7, 0 at the end' );
disp( '[2] multistep for speed control' );
disp( '      17 rad/s at 2 sec, -17 rad/s at 7, 10 at the end' );

active_exp = input( '' );
if active_exp == 1
    %its a position control 
    experiment = e_h.experiments{44}
    if active_dof == 1
        disp( 'Which of the control techinque would you like to run ? ');
        disp( '[1] cascade controller' );
        disp( '[2] LQG' );
        disp( '[3] H_infinity');
        
        req_c = input( '' );
        
        if req_c == 1
            % cascade 1 dof - > c2
            controller.active_technique = 2;
            disp( 'Cascade controller for position control in 1 d.o.f activated');
        elseif req_c == 2
            % LQG 1 dof - > c9 + kalman filter
            controller.active_technique = 9;
            controller.active_observer = 2;
            disp( 'LQG controller for position control in 1 d.o.f activated');
        else
            % Hinfty 1 dof -> c11
            controller.active_technique = 11;
            disp( 'H_infty controller for position control in 1 d.o.f activated');
        end
    else
        if req_c == 1
            % cascade 2 dof - > c4
            controller.active_technique = 4;
            disp( 'Cascade controller for position control in 2 d.o.f activated');
        elseif req_c == 2
            % LQG 2 dof - > c10 + kalman filter
            controller.active_technique = 10;
            controller.active_observer = 2;
            disp( 'LQG controller for position control in 2 d.o.f activated');
        else
            % Hinfty 2 dof -> c12
            controller.active_technique = 12;
            disp( 'H_infty controller for position control in 2 d.o.f activated');
        end
        
    end
    
else 
    experiment = e_h.experiments{40}
    %its a speed controller 
    if active_dof == 1
        % speed 1 dof -> c1
        disp( 'PI controller for speed control in 1 d.o.f has been activated ' );
        controller.active_technique = 1;
    else
        % speed 2 dof -> c3
        disp( 'PI controller for speed control in 2 d.o.f has been activated ' );
        controller.active_technique = 3;
    end
    
end

open( 'scheme.slx' );
sim( 'scheme' );
clc;
disp( 'Now you can open the data inspector and look at the data by selecting on the left' );