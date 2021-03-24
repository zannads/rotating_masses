classdef experiment_handler
    %EXPERIMENT_HANDLER Class to manage the experiment and the data
    %collected in the laboratory of automation and control engineering.
    %   This class saves some information about all the test we have done,
    %   like the time and the titles. It also allows to manage the
    %   experiments and to automatically collect the data in the right way.
    
    properties
        name                %Name of the object to be loaded or saved
        
        date                %Dates of the laboratory linked to the number
        
        hours               %Times of the data collected for each laboratory.
        
        titles      %Titles of the experiment done.
        
        experiments     %Experiments that has been defined.
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
            %SAVE Saves the object in the current folder.
            % save it
            save( strcat( obj.name, '.mat'), 'obj');
        end
        
        function obj = new_laboratory( obj )
            %NEW_LABORATORY Adds the date of the new laboratory and
            %eventually creates the folder to save the experiments.
            
            % ask for the date
            new_date = convertCharsToStrings( input( 'Data in formato Simulink? ', 's') );
            new_date = strrep( new_date, ' ', '-');
            
            % add it in column
            obj.date(end+1, 1) = new_date;
            idx = size( obj.date, 1);
            
            % if folder doesn't exist, it creates a new one.
            if ~exist( strcat( "lab_", num2str( idx ) ), 'dir' )
                mkdir( strcat( "lab_", num2str( idx ) ) );
            end
            
            obj.save;
        end
        
        % load_data che � la stessa cosa dell'attuale data_handler
        function data = load_data( obj )
            %LOAD_DATA Takes an already saved object and set it up like it
            %is used in our simulink scripts.
            
            try 
                lab = obj.get_lab;
                requested = obj.get_datasets( lab );
            catch e
                rethrow(e);
            end
            
            % if we are at this point at least it exist in the class.
            if ~exist( strcat( requested, '.mat') , 'file')
                % ops
                msg = "Missing file.\nConsider running the method 'update_files'." ;
                error( msg );
            end
            
            % then it also exit in the hard disk. Load it!
            load( strcat( requested, '.mat'), 'data' );
            
            % the object will already been called data, thus it will be
            % returned in the correct way. 
        end
        
        % delete_data % cancella l'ogetto dell'esperimento
        function obj = delete_data( obj )
            
            try 
                lab = obj.get_lab;
                requested = obj.get_datasets( lab );
            catch e
                rethrow(e);
            end
            
            confirm = input( strcat( "Sei sicuro di cancellare il dataset ", ...
                requested , '? [y/n] ' ), 's' );
            if strcmp( confirm, 'y' )
                % get the idx of the requested title
                req_idx = strcmpi( obj.titles, requested );
                % set to missing ( like nan for numbers, but it is used in
                % arrays of strings )
                obj.titles( req_idx ) = missing;
                obj.hours( req_idx ) = missing;
            end
            obj.save;
        end
        
        function obj = create_data( obj )
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
        
        function show_experiment( obj )
            
            experiment = obj.load_experiment;
            
            disp( strcat( "Titolo: ", experiment.title ) );
            disp( strcat("Riferimento: ", experiment.refVariable) );
            disp( strcat("Tipo di segnale: ", experiment.type) );
            
            disp( "");
            disp( experiment.(experiment.refVariable).(experiment.type) );
        end
        
        function experiment = load_experiment( obj )
            obj.print_experiments;
            
            idx_exp = input( 'Quale esperimento? ' );
            experiment = obj.experiments{idx_exp};
        end
        
        function obj = delete_experiment( obj )
            obj.print_experiments;
            idx_exp = input( 'Quale esperimento vuoi cancellare? ' );
            confirm = input( strcat( 'Sei sicuro di cancellare l''esperimento n.', ...
                num2str( idx_exp) , '? [y/n] ' ), 's' );
            if strcmp( confirm, 'y' )
                obj.experiments{idx_exp} = [];
            end
            obj.save;
        end
        
    end
    
    
    %% 
    % "a little help from some old friend" .cit
    methods (Access=private)
        function out = num_labs( obj )
            %NUM_LABS Returns the number of available laboratories.
            out = size( obj.date, 1);
        end
        
        function print_labs( obj )
            %PRINT_LABS Prints to command window all the available labs.
            %And ask to choose one
            
            disp( "This are the available labs:" );
            % show available labs
            for idx = 1:obj.num_labs
                disp( strcat( "[", num2str(idx), "] ", obj.date(idx) ) );
            end
        end
        
        function lab = get_lab( obj )
            %GET_LAB Returns the index of the lab requested from the user.
            
            obj.print_labs;
            disp( " ");
            lab = input( 'Which one do you want? ');
            
            % check validity
            if lab <= 0 | lab > obj.num_labs %#ok<OR2>
                msg =  "Incorrect number. Try again." ;
                
                if lab == obj.num_labs+1
                    msg = strcat(msg, "\nConsider calling before the method 'new_laboratory'.");
                end
                error( msg );
            end
        end
        
        function out = num_datasets( obj, lab )
            %NUM_DATASETS Returns the number of dataset collected that
            %laboratory indicated by lab.
            out = sum( ~ismissing( obj.hours( lab, :) ) );
        end
        
        function idx = print_datasets( obj, lab )
            %PRINT_DATASETS Prints the available datasets for the
            %laboratory indicated by lab.
            
            disp( "This are the available data sets:" );
            % show available sets
            
            % take em now they are just vectors
            hrs = obj.hours(lab, :);
            tls = obj.titles(lab, :);
            
            % create the idx vector that maps from user input to the class
            % array.
            idx = zeros( size( hrs) );
            
            %print and populate idx
            count = 1;
            for jdx = 1:length( hrs )
                
                if ~ismissing( hrs(jdx) )
                    % print 
                    disp( strcat( "[", num2str(count), "] ", hrs(jdx), ...
                        ": ", tls(jdx) ) );
                    % populate
                    idx( jdx ) = count;
                    count = count +1;
                end
            end
            
        end
%         
        function title = get_datasets( obj, lab)
            %GET_DATASETS Returns the title of the request dataset from the
            %user. 
            idx = obj.print_datasets( lab );
            disp( " ");
            data_idx = input( 'Which one do you want? ');
            
            % check validity
            if data_idx <= 0 | data_idx > obj.num_datasets( lab ) %#ok<OR2>
                msg = "Incorrect number. Try again.";
                error( msg );
            end
            
            title = obj.titles( lab, idx==data_idx );
        end
        
        function print_experiments( obj )
            num_exp = length( obj.experiments );
            for idx = 1:num_exp
                disp( strcat( '[', num2str( idx ), "]  ", ...
                    obj.experiments{idx}.title, ...
                    " ; var di riferimento: ", obj.experiments{idx}.refVariable, ...
                    ", tipo di segnale: ", obj.experiments{idx}.type ) );
            end
        end
    end
end

