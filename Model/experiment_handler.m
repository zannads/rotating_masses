classdef experiment_handler
    %EXPERIMENT_HANDLER Class to manage the experiment and the data
    %collected in the laboratory of automation and control engineering.
    %   This class saves some information about all the test we have done,
    %   like the time and the titles. It also allows to manage the
    %   experiments and to automatically collect the data in the right way.
    % Dataset data are collected during the experiment, formatted as defined in the
    % dataset_struct.
    
    properties 
        name                %Name of the object to be loaded or saved.
        
        date                %Dates of the laboratory linked to the number.
        
        hours               %Times of the data collected for each laboratory.
        
        titles      %Titles of the data collected.
        
        experiments     %Inputs for the lab experiment that has been defined.
        
        dataset_structs %Struct explaining how dataset data are collected.
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
        
        %% data
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
        
        function obj = delete_data( obj )
            %DELETE_DATA Erases the data from the class and from the
            %directory.
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
                %delete the file
                delete( strcat( requested, '.mat' ) );
            end
            
            obj.save;
        end
                
        function [data, experiment, controller] = prepare_simulation( obj )
            %PREPARE_SIMULATION Formats the data in the way that simulink
            %wants for the use of "from workspace".
            %   With this function we can create the data for the
            %   SIMULATIONS in simulink as we want.
            
            raw_data = obj.load_data;
            
            data.voltage = [raw_data.time', raw_data.voltage'];
            data.motor_pos = [raw_data.time', raw_data.motor_pos'];
            data.motor_pos_0 = raw_data.motor_pos(1);
            
            data.mass1_pos = [raw_data.time', raw_data.mass1_pos'];
            data.mass1_vel = [raw_data.time', raw_data.mass1_vel'];
            
            if isfield( raw_data, 'mass2_pos' )
                data.mass2_pos = [raw_data.time', raw_data.mass2_pos'];
                data.mass2_vel = [raw_data.time', raw_data.mass2_vel'];
            else 
                data.mass2_pos = [raw_data.time', zeros( size( raw_data.time' ) )];
                data.mass2_vel = [raw_data.time', zeros( size( raw_data.time' ) )];
            end
            
            experiment = obj.load_experiment( 'title', raw_data.exp_title );
            
            % variable controller is created
            controller_setup;
            if isfield( raw_data, 'controller' )
                
                if ~isempty(raw_data.controller) 
                   c = fieldnames( raw_data.controller );
                   c = c{1};
                   controller.(c) = raw_data.controller.(c);
                   controller.active_technique = str2double( c(2:end) );
                end
            end
        end
        
        %% experiments
        function obj = define_experiment( obj )
            experiment = struct( 'title', [], 'voltage', [], 'motor_pos', [], ...
                'motor_vel', [], 'mass1_pos', [], 'mass1_vel', [], ...
                'mass2_pos', [], 'mass2_vel', []);
            step = struct( 'init_time', 0, 'step_size', 0);
            ramp = struct( 'init_time', 0, 'ramp_pend', 0, 'init_value', 0, 'final_value', 0);
            sinesweep = struct( 'init_freq', 0.1, 'final_freq', 0.1, 'target_time', 0, 'mean_value', 0, 'v_max', 0);
            
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
                    experiment.(refVariable).(type).init_time = input( " Istante iniziale: " );
                    experiment.(refVariable).(type).step_size = input( " Ampiezza step: " );
                case 'ramp'
                    experiment.(refVariable).(type).init_time = input( " Istante iniziale: " );
                    experiment.(refVariable).(type).ramp_pend = input( " Pendenza rampa [units/s]: " );
                    experiment.(refVariable).(type).init_value = input( " Valore iniziale: " );
                    experiment.(refVariable).(type).final_value = input( " Valore finale: " );
                case 'sinesweep'
                    experiment.(refVariable).(type).init_freq = input( " Frequenza iniziale [Hz] (>0): " );
                    experiment.(refVariable).(type).final_freq = input( " Frequenza finale [Hz]: " );
                    experiment.(refVariable).(type).target_time = input( " Tempo esperimento [s]: " );
                    experiment.(refVariable).(type).mean_value = input( " Valore medio : " );
                    experiment.(refVariable).(type).v_max = input( " Valore massimo : " );
            end
            
            experiment.w_filter = inf;
            new_val = input( strcat( " w_filter: Inf --> " ) );
            if num2str( new_val ) ~= ""
                experiment.w_filter = new_val;
            end
            
            experiment.refVariable = refVariable;
            experiment.type = type;
            
            obj.experiments{end+1} = experiment;
            obj.save;
        end
        
        function obj = edit_experiment( obj )
            
            obj.print_experiments;
            idx_exp = input( 'Quale esperimento? ' );
            obj.valid_numexp( idx_exp );
            experiment = obj.experiments{idx_exp};
            
            type = experiment.type;
            refVariable = experiment.refVariable;
            disp( "Modifica i valori [Invio per confermare]" );
            
            new_title = input( strcat( " Titolo: ", experiment.title, " --> " ), 's' );
            if new_title ~= ""
                experiment.title = new_title;
            end
            
            new_val = input( strcat( " w_filter: ", num2str( experiment.w_filter ), " --> " ) );
            if num2str( new_val ) ~= ""
                experiment.w_filter = new_val;
            end
            
            switch( type )
                case 'step'
                    
                    new_val = input( strcat( " Istante iniziale: ", num2str( experiment.(refVariable).(type).init_time ), " --> " ) );
                    if num2str( new_val ) ~= ""
                        experiment.(refVariable).(type).init_time = new_val;
                    end
                    
                    new_val = input( strcat( " Ampiezza step: ", num2str( experiment.(refVariable).(type).step_size ), " --> " ) );
                    if num2str( new_val ) ~= ""
                        experiment.(refVariable).(type).step_size = new_val;
                    end
                    
                case 'ramp'
                    
                    new_val = input( strcat( " Istante iniziale: ", num2str( experiment.(refVariable).(type).init_time ), " --> " ) );
                    if num2str( new_val ) ~= ""
                        experiment.(refVariable).(type).init_time = new_val;
                    end
                    
                    new_val = input( strcat( " Pendenza rampa [units/s]: ", num2str( experiment.(refVariable).(type).ramp_pend ), " --> " ) );
                    if num2str( new_val ) ~= ""
                        experiment.(refVariable).(type).ramp_pend = new_val;
                    end
                    
                    new_val = input( strcat( " Valore iniziale: ", num2str( experiment.(refVariable).(type).init_value ), " --> " ) );
                    if num2str( new_val ) ~= ""
                        experiment.(refVariable).(type).init_value = new_val;
                    end
                    
                    new_val = input( strcat( " Valore finale: ", num2str( experiment.(refVariable).(type).final_value ), " --> " ) );
                    if num2str( new_val ) ~= ""
                        experiment.(refVariable).(type).final_value = new_val;
                    end
                    
                case 'sinesweep'
                    
                    new_val = input( strcat( " Frequenza iniziale [Hz] (>0): ", num2str( experiment.(refVariable).(type).init_freq ), " --> " ) );
                    if num2str( new_val ) ~= ""
                        experiment.(refVariable).(type).init_freq = new_val;
                    end
                    
                    new_val = input( strcat( " Frequenza finale [Hz]: ", num2str( experiment.(refVariable).(type).final_freq ), " --> " ) );
                    if num2str( new_val ) ~= ""
                        experiment.(refVariable).(type).final_freq = new_val;
                    end
                    
                    new_val = input( strcat( " Tempo esperimento [s]: ", num2str( experiment.(refVariable).(type).target_time ), " --> " ) );
                    if num2str( new_val ) ~= ""
                        experiment.(refVariable).(type).target_time = new_val;
                    end
                    
                    new_val = input( strcat( " Valore medio : ", num2str( experiment.(refVariable).(type).mean_value ), " --> " ) );
                    if num2str( new_val ) ~= ""
                        experiment.(refVariable).(type).mean_value = new_val;
                    end
                    
                    new_val = input( strcat( " Valore massimo : ", num2str( experiment.(refVariable).(type).v_max ), " --> " ) );
                    if num2str( new_val ) ~= ""
                        experiment.(refVariable).(type).v_max = new_val;
                    end
                    
            end
            
            obj.experiments{idx_exp} = experiment;
            obj.save;
            
        end
        
        function print_experiment( obj )
            
            experiment = obj.load_experiment;
            
            disp( strcat( " Titolo: ", experiment.title ) );
            disp( strcat( " Riferimento: ", experiment.refVariable) );
            disp( strcat( " w_filter: ", num2str( experiment.w_filter ) ) );
            disp( strcat( " Tipo di segnale: ", experiment.type) );
            disp( experiment.(experiment.refVariable).(experiment.type) );
            disp( "");
        end
        
        function experiment = load_experiment( obj, varargin )
            
            if nargin> 1 && strcmp( varargin{1}, 'from_to' )
                from = varargin{2};
                to = from(2);
                from = from(1);
                
                obj.valid_numexp( to );
                obj.valid_numexp( from );
                %return as cell is a set 
                experiment = obj.experiments(from:to);
            elseif nargin> 1 && strcmp( varargin{1}, 'title' )
                wtitle = varargin{2};
                
                idx_exp = obj.experiment_title_search( wtitle );
                
                % is a single object 
                experiment = obj.experiments{idx_exp};
            else
                obj.print_experiments;       
                
                idx_exp = input( 'Quale esperimento? ' );
                
                obj.valid_numexp( idx_exp );
                
                % is a single object 
                experiment = obj.experiments{idx_exp};
            end
        end
        
        function obj = delete_experiment( obj )
            obj.print_experiments;
            idx_exp = input( 'Quale esperimento vuoi cancellare? ' );
            confirm = input( strcat( 'Sei sicuro di cancellare l''esperimento n.', ...
                num2str( idx_exp) , "? [y/n] " ), 's' );
            if strcmp( confirm, 'y' )
                obj.experiments(idx_exp) = [];
            end
            obj.save;
        end
        
        %% datasets struct
        function obj = define_datasetstruct( obj )
            
            str = input( 'Insert the name of the field: ', 's');
            while ~isempty( str )
                dataset_struct.(str) = [];
                str = input( 'Insert the name of the field: ', 's');
            end
            
            obj.dataset_structs{end+1} = dataset_struct;
            
            obj.save;
        end
        
        function print_datasetstruct( obj)
            
            for idx = 1: length( obj.dataset_structs )
                disp( strcat( "[", num2str(idx), "] ") );
                disp(obj.dataset_structs{idx});
            end
            
        end
        
        function out = today_lab( obj, varargin )
            persistent todaylab;
            
            if isempty( todaylab ) 
                todaylab = num_labs(obj) ;
            end
            if nargin > 1   
                todaylab = varargin{1};
            end
            
            out = todaylab;
        end
        
    end
    
    %% 
    % "a little help from some old friend" .cit
    methods (Access=private)
        function out = num_labs( obj )
            %NUM_LABS Returns the number of available laboratories.
            out = size( obj.date, 1);
        end
        
        function valid_numlab( obj, number )
            %VALID_NUMLAB Does nothing if it is a valid number, otherwise
            %it throws an exception.
            % check validity
            if number <= 0 | number > obj.num_labs %#ok<OR2>
                msg =  "Incorrect number. Try again." ;
                
                if number == obj.num_labs+1
                    msg = strcat(msg, "\nConsider calling before the method 'new_laboratory'.");
                end
                error( msg );
            end
            
        end
        
        function print_labs( obj )
            %PRINT_LABS Prints to command window all the available labs.
            
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
            
            obj.valid_numlab( lab );
        end
        
        function out = num_datasets( obj, lab )
            %NUM_DATASETS Returns the number of dataset collected for the
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
            
            %validate 
            obj.valid_numdataset( lab, data_idx );
            
            title = obj.titles( lab, idx==data_idx );
        end
        
        function valid_numdataset( obj, lab, number )
            %VALID_NUMDATASET Checks if the number inserted is a valid
            %number for that date of the experiment, otherwise it throws an
            %error.
            % check validity
            if number <= 0 | number > obj.num_datasets( lab ) %#ok<OR2>
                msg = "Incorrect number. Try again.";
                error( msg );
            end
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
        
        function out = num_exp( obj )
            %NUM_EXP Returns the number of defined experiments.
            out = length( obj.experiments );
        end
        
        function valid_numexp( obj, number) 
            %VALID_NUMEXP Checks if the number is a valid number of
            %experiment. 
            if number <= 0 || number > obj.num_exp
                msg= 'Number of the experiment incorrect' ;
                error( msg );
            end
        end
        
        function out = get_todayfolder( obj )
            %GET_TODAYFOLDER Looks at today lab and build the corresponding
            %lab directory.
            
            out = strcat( 'lab_', num2str( obj.today_lab ), '/' );
        end
        
        function out = experiment_title_search( obj, reftitile) 
            
            for idx = 1:obj.num_exp
                if strcmp( obj.experiments{idx}.title, reftitile )
                    out = idx;
                    return;
                end
            end
            
            msg = "Experiment title not present";
            error(msg);
        end
        
    end
    
 
            
end

