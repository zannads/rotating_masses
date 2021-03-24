classdef experiment_handler
    %EXPERIMENT_HANDLER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % saving name
        name
        
        %lab names
        date
        
        % data hours
        hours
        
        % data titles
        titles
        
        %experiments
        experiments
    end
    
    methods
        function obj = experiment_handler( name )
            %EXPERIMENT_HANDLER Construct an instance of this class
            %   When the object specified by name already exist it loads
            %   it, when it doesn't it creates a new one empty.
            
            % check for robustness if there is the input
            if nargin == 0
                disp( 'You have not inserted the name of the object.');
                name = input( 'Insert it now: ', 's');
            end
            
            % it exist then it loads
            if exist( strcat(name, '.mat'), 'file' ) == 2
                % load the file .mat the variable will be named data
                load( name, 'obj' );
                
                % it doesn't exist create an empty one with that name
            else
                obj.name = name;
                obj.date = string.empty;
                obj.hours = string.empty;
                obj.titles = string.empty;
                obj.experiments = cell(0);
                
                obj.save;
            end
        end
        
        function save( obj )
            % save it
            save( strcat( obj.name, '.mat'), 'obj');
        end
        
        function obj = new_laboratory( obj )
            %NEW_LABORATORY Adds the date of the new laboratory and
            %preallocate the spaces for hours and titles.
            
            new_date = convertCharsToStrings( input( 'Data in formato Simulink? ', 's') );
            new_date = strrep( new_date, ' ', '-');
            
            obj.date(end+1, 1) = new_date;
            idx = size( obj.date, 1);
            
            if ~exist( strcat( "lab_", num2str( idx ) ), 'dir' )
                mkdir( strcat( "lab_", num2str( idx ) ) );
            end
            
            obj.save;
        end
        
        % load_data che è la stessa cosa dell'attuale data_handler
        function data = load_data( obj )
            % mostra i lab
            % acquisisci lab
            % mostra i titoli
            % acquisisci i titoli
            data = [];
            % se esiste caricalo
                % lo formatta come lo vuole simulink! 
                % data.voltage_ref
                % data.
            
            % se non esiste pace
        end
        % delete_data % cancella l'ogetto dell'esperimento
        function obj = delete_data( obj )
            
        end
        
        % do experiment :
        % chiedi quanti
        % chiedi quali
        % for each experiment
        % salva i dati dell'experiment sul workspace
        % pausa
        % noir unniamo simulink
        % % ci prendiamo il nuov oggetto
        % % lo trasformiamo usando data_create
        % eliminiamo il vecchio e lo salviamo in nuovo formato
        
        
        function obj = define_experiment( obj )
            experiment = struct( 'title', [], 'voltage', [], 'motor_pos', [], ...
                'motor_vel', [], 'mass1_pos', [], 'mass1_vel', [], ...
                'mass2_pos', [], 'mass2_vel', []);
            step = struct( 'init_time', 0, 'step_size', 0);
            ramp = struct( 'init_time', 0, 'ramp_pend', 0, 'init_value', 0, 'final_value', 0);
            sinesweep = struct( 'init_freq', 0.1, 'final_freq', 0.1, 'target_time', 0, 'mean_value', 0);
            
            
            experiment.title = input( 'Titolo dell''esperimento ? ', 's' );
            
            disp( 'Variabile di riferimento ?');
            disp( 'voltage, motor_pos, motor_vel, mass1_pos, mass1_vel, mass2_pos, mass2_vel, ' );
            refVariable = input( '', 's' );
            
            field_names = fieldnames( experiment );
            n_field = numel( field_names );
            for idx = 2:n_field
                experiment.(field_names{idx}).step = step;
                experiment.(field_names{idx}).ramp = ramp;
                experiment.(field_names{idx}).sinesweep = sinesweep;
            end
            
            disp( 'Tipo dell''esperimento?' );
            type = input( "step, ramp, sinesweep ", 's' );
            
            switch( type )
                case 'step'
                    experiment.(refVariable).(type).init_time = input( "Istante iniziale: " );
                    experiment.(refVariable).(type).step_size = input( "Ampiezza step: " );
                case 'ramp'
                    experiment.(refVariable).(type).init_time = input( "Istante iniziale: " );
                    experiment.(refVariable).(type).ramp_pend = input( strcat( 'Pendenza rampa [', ...
                        experiment.refVariable, "/s]: " ) );
                    experiment.(refVariable).(type).init_value = input( "Valore iniziale: " );
                    experiment.(refVariable).(type).final_value = input( "Valore finale: " );
                case 'sinesweep'
                    experiment.(refVariable).(type).init_freq = input( "Frequenza iniziale [Hz] (>0): " );
                    experiment.(refVariable).(type).final_freq = input( "Frequenza finale: " );
                    experiment.(refVariable).(type).target_time = input( "Tempo esperimento [Hz]: " );
            end
            
            experiment.w_filter = 25;
            % ask for filter in future
            
            experiment.refVariable = refVariable;
            experiment.type = type;
            
            obj.experiments{end+1} = experiment;
            obj.save;
        end
        
        % print experiment
        function print_experiment( obj )
            num_exp = length( obj.experiments );
            for idx = 1:num_exp
                disp( strcat( '[', num2str( idx ), "]  ", ...
                    obj.experiments{idx}.title, ...
                    " ; var di riferimento: ", obj.experiments{idx}.refVariable, ...
                    ", tipo di segnale: ", obj.experiments{idx}.type ) );
            end
            idx_exp = input( 'Quale esperimento vuoi visualizzare? ' );
            experiment = obj.experiments{idx_exp};
            disp(" ");
            
            disp( strcat( "Titolo: ", experiment.title ) );
            disp( strcat("Riferimento: ", experiment.refVariable) );
            disp( strcat("Tipo di segnale: ", experiment.type) );
            
            disp( "");
            disp( experiment.(experiment.refVariable).(experiment.type) );
        end
        
        % load experiment
        function experiment = load_experiment( obj )
            num_exp = length( obj.experiments );
            for idx = 1:num_exp
                disp( strcat( '[', num2str( idx ), "]  ", ...
                    obj.experiments{idx}.title, ...
                    " ; var di riferimento: ", obj.experiments{idx}.refVariable, ...
                    ", tipo di segnale: ", obj.experiments{idx}.type ) );
            end
            idx_exp = input( 'Quale esperimento vuoi caricare? ' );
            experiment = obj.experiments{idx_exp};
        end
        
        % delete experiment
        function obj = delete_experiment( obj )
            num_exp = length( obj.experiments );
            for idx = 1:num_exp
                disp( strcat( '[', num2str( idx ), "]  ", ...
                    obj.experiments{idx}.title, ...
                    " ; var di riferimento: ", obj.experiments{idx}.refVariable, ...
                    ", tipo di segnale: ", obj.experiments{idx}.type ) );
            end
            idx_exp = input( 'Quale esperimento vuoi cancellare? ' );
            confirm = input( strcat( 'Sei sicuro di cancellare l''esperimento n.', ...
                num2str( idx_exp) , '? [y/n] ' ), 's' );
            if strcmp( confirm, 'y' )
                obj.experiments{idx_exp} = [];
            end
            obj.save;
        end
        
    end
end

