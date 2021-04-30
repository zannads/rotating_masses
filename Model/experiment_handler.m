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
                delete( strcat( obj.get_todayfolder, requested, '.mat' ) );
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
            
            if isfield( raw_data, 'vel1_ref' )
                data.ref = [raw_data.time', raw_data.vel1_ref'];
                data.ref = [raw_data.time', raw_data.vel1_ref'];
            elseif isfield( raw_data, 'ref' )
                data.ref = [raw_data.time', raw_data.ref'];
                data.ref = [raw_data.time', raw_data.ref'];
            else
                data.ref = [raw_data.time', zeros( size( raw_data.time' ) )];
                data.ref = [raw_data.time', zeros( size( raw_data.time' ) )];
            end
            
            if isfield( raw_data, 'vel1_err' )
                data.err_ref = [raw_data.time', raw_data.vel1_err'];
                data.err_ref = [raw_data.time', raw_data.vel1_err'];
            elseif isfield( raw_data, 'err_ref' )
                data.err_ref = [raw_data.time', raw_data.err_ref'];
                data.err_ref = [raw_data.time', raw_data.err_ref'];
            else
                data.err_ref = [raw_data.time', zeros( size( raw_data.time' ) )];
                data.err_ref = [raw_data.time', zeros( size( raw_data.time' ) )];
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

            experiment.title = string().empty;
            experiment.step = struct( 'init_time', 0, 'step_size', 0);
            experiment.ramp = struct( 'init_time', 0, 'ramp_pend', 0, 'init_value', 0, 'final_value', 0);
            experiment.sinesweep = struct( 'init_freq', 0.1, 'final_freq', 0.1, 'target_time', 0, 'mean_value', 0, 'v_max', 0);
            
            experiment.refVariable = obj.ask_ref_variable();
            
            experiment.type = obj.ask_type();
            
            switch( experiment.type )
                case 'step'
                    idx = 1;
                    while idx 
                        i_t = input( " Istante iniziale: " );
                        s_a = input( " Ampiezza step: " );
                        
                        if num2str(i_t) == "" | num2str(s_a) == "" %#ok<OR2>
                            idx = 0;
                        else
                            experiment.step.init_time(1, idx) = i_t;
                            experiment.step.step_size(1, idx) = s_a;
                            idx = idx +1;
                        end
                    end
                case 'ramp'
                    experiment.ramp.init_time = input( " Istante iniziale: " );
                    experiment.ramp.ramp_pend = input( " Pendenza rampa [units/s]: " );
                    experiment.ramp.init_value = input( " Valore iniziale: " );
                    experiment.ramp.final_value = input( " Valore finale: " );
                case 'sinesweep'
                    experiment.sinesweep.init_freq = input( " Frequenza iniziale [Hz] (>0): " );
                    experiment.sinesweep.final_freq = input( " Frequenza finale [Hz]: " );
                    experiment.sinesweep.target_time = input( " Tempo esperimento [s]: " );
                    experiment.sinesweep.mean_value = input( " Valore medio : " );
                    experiment.sinesweep.v_max = input( " Valore massimo : " );
            end
            
            experiment.w_filter = inf;
            new_val = input( strcat( " w_filter [Hz]: Inf --> " ) );
            if num2str( new_val ) ~= ""
                experiment.w_filter = new_val;
            end
            
            experiment.stop_time = inf;
            new_val = input( strcat( " stop time : Inf --> " ) );
            if num2str( new_val ) ~= ""
                experiment.stop_time = new_val;
            end
            
            experiment.title = obj.experiment_title_build( experiment );
            disp( 'Titolo dell''esperimento ? ');
            new_name = string(input( ...
                strcat( '[', experiment.title, "] ", "--> "), ...
                's' ) );
            if ~strcmp( new_name, "")
                experiment.title = new_name;
            end
            
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
                       
            new_val = input( strcat( " w_filter: ", num2str( experiment.w_filter ), " --> " ) );
            if num2str( new_val ) ~= ""
                experiment.w_filter = new_val;
            end
            
            new_val = input( strcat( " stop time: ", num2str( experiment.stop_time ), " --> " ) );
            if num2str( new_val ) ~= ""
                experiment.stop_time = new_val;
            end
            
            switch( type )
                case 'step'
                    
                    idx = 1;
                    while idx
                        if idx <= length( experiment.(type).init_time(idx) )
                            new_val = input( strcat( " Istante iniziale: ", num2str( experiment.(type).init_time(idx) ), " --> " ) );
                            if num2str( new_val ) ~= ""
                                experiment.(type).init_time(idx) = new_val;
                            end
                            
                            new_val = input( strcat( " Ampiezza step: ", num2str( experiment.(type).step_size(idx) ), " --> " ) );
                            if num2str( new_val ) ~= ""
                                experiment.(type).step_size(idx) = new_val;
                            end
                            idx = idx + 1;
                        else
                            i_t = input( " Istante iniziale: " );
                            s_a = input( " Ampiezza step: " );
                            
                            if num2str(i_t) == "" | num2str(s_a) == "" %#ok<OR2>
                                idx = 0;
                            else
                                experiment.step.init_time(end+1) = i_t;
                                experiment.step.step_size(end+1) = s_a;
                                idx = idx +1;
                            end
                        end
                    
                    end
                    %
                case 'step'
                    idx = 1;
                    while idx
                        i_t = input( " Istante iniziale: " );
                        s_a = input( " Ampiezza step: " );
                        
                        if num2str(i_t) == "" | num2str(s_a) == "" %#ok<OR2>
                            idx = 0;
                        else
                            experiment.step.init_time(1, idx) = i_t;
                            experiment.step.step_size(1, idx) = s_a;
                            idx = idx +1;
                        end
                    end
                %
                case 'ramp'
                    
                    new_val = input( strcat( " Istante iniziale: ", num2str( experiment.(type).init_time ), " --> " ) );
                    if num2str( new_val ) ~= ""
                        experiment.(type).init_time = new_val;
                    end
                    
                    new_val = input( strcat( " Pendenza rampa [units/s]: ", num2str( experiment.(type).ramp_pend ), " --> " ) );
                    if num2str( new_val ) ~= ""
                        experiment.(type).ramp_pend = new_val;
                    end
                    
                    new_val = input( strcat( " Valore iniziale: ", num2str( experiment.(type).init_value ), " --> " ) );
                    if num2str( new_val ) ~= ""
                        experiment.(type).init_value = new_val;
                    end
                    
                    new_val = input( strcat( " Valore finale: ", num2str( experiment.(type).final_value ), " --> " ) );
                    if num2str( new_val ) ~= ""
                        experiment.(type).final_value = new_val;
                    end
                    
                case 'sinesweep'
                    
                    new_val = input( strcat( " Frequenza iniziale [Hz] (>0): ", num2str( experiment.(type).init_freq ), " --> " ) );
                    if num2str( new_val ) ~= ""
                        experiment.(type).init_freq = new_val;
                    end
                    
                    new_val = input( strcat( " Frequenza finale [Hz]: ", num2str( experiment.(type).final_freq ), " --> " ) );
                    if num2str( new_val ) ~= ""
                        experiment.(type).final_freq = new_val;
                    end
                    
                    new_val = input( strcat( " Tempo esperimento [s]: ", num2str( experiment.(type).target_time ), " --> " ) );
                    if num2str( new_val ) ~= ""
                        experiment.(type).target_time = new_val;
                    end
                    
                    new_val = input( strcat( " Valore medio : ", num2str( experiment.(type).mean_value ), " --> " ) );
                    if num2str( new_val ) ~= ""
                        experiment.(type).mean_value = new_val;
                    end
                    
                    new_val = input( strcat( " Valore massimo : ", num2str( experiment.(type).v_max ), " --> " ) );
                    if num2str( new_val ) ~= ""
                        experiment.(type).v_max = new_val;
                    end
                    
            end
            
            new_title = input( strcat( " Titolo: ", experiment.title, " --> " ), 's' );
            new_title = input( strcat( " Titolo: ", experiment.title, " --> ", obj.experiment_title_build() ), '' );
            if new_title ~= ""
                experiment.title = new_title;
            end
            
            obj.experiments{idx_exp} = experiment;
            obj.save;
            
        end
        
        function print_experiment( obj )
            
            experiment = obj.load_experiment;
            disp( " ");
            disp( strcat( " Titolo: ", experiment.title ) );
            disp( strcat( " Riferimento: ", experiment.refVariable) );
            disp( strcat( " w_filter: ", num2str( experiment.w_filter ) ) );
            disp( " ");
            disp( strcat( " Tipo di segnale: ", experiment.type) );
            disp( experiment.(experiment.type) );
            disp( strcat( " Stop time: ", num2str( experiment.stop_time ) ) );  
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
        
        %% title help
        function title  = get_new_title( obj )
            %TITLE Returns a new available name from old value
            
            % take last title
            try
                title = obj.get_datasets( obj.today_lab, obj.num_datasets( obj.today_lab ) );
            catch
                title = strcat( "test_", strrep( obj.date(end), '-', '-') );
                return;
            end
            
            title = obj.append_numeration( title );
        end
        
        function title = data_title_search( obj, title )
            %CHECK_TITLE Returns the title if the title is ok, otherwise it
            %reuturns the modified title.
            
            out = strcmpi( obj.titles, title);
            if ( sum( out, 'all' ) > 0 )
                warning( 'Name is already present.' );
                title = obj.append_numeration( obj.titles( out ) );
            end
            
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
        
        function idx = print_datasets( obj, lab, varargin )
            %PRINT_DATASETS Prints the available datasets for the
            %laboratory indicated by lab.
            
            if nargin > 2 && strcmp( varargin{1}, 'no_print' ) 
                pr = 0;
            else 
                % show available sets
                pr = 1;
                disp( "This are the available data sets:" );
            end
            
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
                    if pr
                        disp( strcat( "[", num2str(count), "] ", hrs(jdx), ...
                            ": ", tls(jdx) ) );
                    end
                    % populate
                    idx( jdx ) = count;
                    count = count +1;
                end
            end
            
        end
        %
        function title = get_datasets( obj, lab, varargin)
            %GET_DATASETS Returns the title of the request dataset from the
            %user.
            if nargin > 2
                data_idx = varargin{1};
                idx = obj.print_datasets( lab, 'no_print');
            else
                idx = obj.print_datasets( lab );
                disp( " ");
                data_idx = input( 'Which one do you want? ');
                
            end
            
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
        
        function title = append_numeration( ~, title )
            old_num = str2double( extractBefore( title.reverse, '_' ) );
            if isnumeric( old_num ) | isempty( old_num )
                old_num = 1;
            else
                title = reverse( extractAfter( title.reverse, '_' ) );
            end
            
            title = strcat( title, "_", num2str( old_num+1 ) );
            title = string( title );
        end
        
        function title = experiment_title_build( ~, experiment)
            custom_part = "";
            
            if strcmp( experiment.type, 'step' )
                for idx = 1:length(experiment.step.step_size)
                    custom_part = strcat( custom_part, "_", ...
                        num2str( experiment.step.step_size(idx) ) );
                end                
            elseif strcmp( experiment.type, 'ramp' )
                custom_part = strcat( custom_part, "_", ...
                    num2str( experiment.ramp.init_value ), "_to_", ...
                    num2str( experiment.ramp.final_value ) );
            else
                custom_part = strcat( "_", num2str( experiment.sinesweep.init_freq ), ...
                    "_to_", num2str( experiment.sinesweep.final_freq ), "Hz" );
            end
            
            switch( experiment.refVariable )
                case 'voltage'
                    unit = "V";
                case 'motor_pos'
                    unit = "rad";
                case 'motor_vel'
                    unit = "rad/s";
                case 'mass1_pos'
                    unit = "rad";
                case 'mass1_vel'
                    unit = "rad/s";
                case 'mass2_pos'
                    unit = "rad";
                case 'mass2_vel'
                    unit = "rad/s";
            end
            title = string( strcat( experiment.refVariable, '_', ...
                experiment.type, custom_part, '_', unit ) );
        end
        
        function refVariable = ask_ref_variable( ~ )
            disp( 'Variabile di riferimento ?');
            disp( '[1] voltage' );
            disp( '[2] motor_pos, [3] mass1_pos, [4] mass2_pos ' );
            disp( '[5] motor_vel, [6] mass1_vel, [7] mass2_vel ' );
            refVariable = input( '', 's' );
            
            %consistency check 
            if ~isnan( str2double( refVariable ) )
                switch str2double(refVariable)
                    case 1
                        refVariable = 'voltage';
                    case 2 
                        refVariable = 'motor_pos';
                    case 3 
                        refVariable = 'mass1_pos';
                    case 4 
                        refVariable = 'mass2_pos';
                    case 5
                        refVariable = 'motor_vel';
                    case 6 
                        refVariable = 'mass1_vel';
                    case 7
                        refVariable = 'mass2_vel';
                end
            end
        end
        
        function type = ask_type( ~ )
            disp( 'Tipo dell''esperimento?' );
            type = input( "[1] step, [2] ramp, [3] sinesweep : ", 's' );
            
            %consistency check 
            if ~isnan( str2double( type ) )
                switch str2double(type)
                    case 1
                        type = 'step';
                    case 2 
                        type = 'ramp';
                    case 3 
                        type = 'sinesweep';
                end
            end
        end
    end
    
    
    
end

