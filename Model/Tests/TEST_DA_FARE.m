%MARTEDì IN LAB

% 1 massa
% step 2V da - 10 a 10 

% acquisire :
%DATA:
% titolo : dof1 step x V 
% time: 
% voltage : 
% motor_pos :
% motor_vel :
% mass1_pos :
% mass1_vel :
% mass2_pos :
% mass2_vel :
% w_filter : [Hz] 

e_h = experiment_handler( 'experiment_handler' );
%%
 % I should have the same number of titles and experiments,
            % while dataset_struct is just one!
            titoli = ["voltage_step_1dof_-10V_filterok";
               
                "voltage_step_1dof_-6V_filterok";
                
                "voltage_step_1dof_2V_filterok";
                
                "voltage_step_1dof_10V_filterok"];
            
            experiments = e_h.load_experiment('from_to', [11, 20]);
            dts_struct = e_h.dataset_structs{2};
            
idx = 10
                
        experiment = experiments{idx};
        
        pause;
        
        % we run simulink
        
        % stop the pause pressing enter on command window
        
        e_h = e_h.create_data( titoli(4), dts_struct, {experiment} );

%%
% sweptsine da 10^-2, 10^1
% acquisire uguale 
experiment = e_h.load_experiment( 'from_to', [22, 22] );

pause;

% we run simulink

% stop the pause pressing enter on command window

e_h = e_h.create_data( "voltage_sinesweep_1dof_5_8Hz", dts_struct, experiment );

%%
% creare tf dagli esperimenti

% ci estriamo l'errore sul gain 

% test sui regolatori 
% acquisire :
% titolo : dof1 step x V 
% time: 
% voltage : 
% motor_pos :
% motor_vel :
% mass1_pos :
% mass1_vel :
% mass2_pos :
% mass2_vel :
% w_filter : [Hz] 
% vel1_ref :
% vel1_err :

%%
% 1massa  con controllore
% uguale identico

titoli = ["mass1vel_step_15_test6";
                "mass1vel_step_-8_test2";
                "mass1vel_step_17";
                "mass1vel_ramp_0_15";
                "mass1vel_ramp_-17_17";
                "mass1pos_step_45"];
            
            experiments = e_h.load_experiment('from_to', [23, 28]);
            dts_struct = e_h.dataset_structs{3};
            
idx = 6
                
        experiment = experiments{idx};
        
       % pause;
        
        % we run simulink
        
        % stop the pause pressing enter on command window
        
        %e_h = e_h.create_data( titoli(idx), dts_struct, {experiment} );


%%

%%
% 2massa 
% uguale identico

titoli = ["voltage_step_2dof_-10V_filterok";
                "voltage_step_2dof_-8V_filterok";
                "voltage_step_2dof_-6V";
                "voltage_step_2dof_-4V_filterok";
                "voltage_step_2dof_-2V";
                "voltage_step_2dof_2V_filterok";
                "voltage_step_2dof_4V";
                "voltage_step_2dof_6V";
                "voltage_step_2dof_8V_filterok";
                "voltage_step_2dof_10V"];
            
            experiments = e_h.load_experiment('from_to', [11, 20]);
            dts_struct = e_h.dataset_structs{2};
            
 idx = 6
                
        experiment = experiments{idx};
        
        pause;
        
        % we run simulink
        
        % stop the pause pressing enter on command window
        
        e_h = e_h.create_data( titoli(idx), dts_struct, {experiment} );


%% IN SETTIMANA
% DENNIS - GIACOMO
% creare la tf in simulazione con i valori nominali e con i nostri.
% così si vede l'ordine di grandezza dell'errore sul gain

% sistemare data_loader e prepare l'acquisizione automatizzata per martedì 

% FRANCESCO-LUCA
% regolatori PI per le due tf (nominale e nostra )
% regolatore ad hoc sulla tf 

%BONUS
% controllore di posizione - proporzionale
%                          - feed-forward

% ragionare su posizione incrementale o assoluta

%% obbietivi a lungo termine


% PRIMA DI PASQUA 
% su 1 dof evitare oscillazioni e velocizzare risposta!
% certezza sui dati e i modelli

% A PASQUA 
% report su prima parte:
% Risultati attesi e obiettivi. 
% signal preprocessing ( blocco encoder ecc blocco potenziometro )
% model identification 
% controllo di velocità 1dof
% ~~ controllo di posizione 1dof

% su 2 dof evitare oscillazioni di entrambe le masse

