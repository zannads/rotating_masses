function data = data_loader()
%DATA_LOADER 
% new loading
load data_handler.mat data_handler;
data = [];

% get date from number of lab
date = input( 'Numero del laboratorio ? ', 's' );
date = str2double( date);
while isnan( date ) |  (date <= 0) | (date > size( data_handler.date, 1 )+1 ) %#ok<OR2>
    disp( 'Numero sbagliato');
    date = input( 'Numero del laboratorio ? ', 's' );
    date = str2double( date);
end
% create new one
if date == size( data_handler.date, 1 )+1
    %nuova data
    data_handler.date(end+1, 1) = convertCharsToStrings( input( 'Data in formato Simulink? ', 's') );
    if ~exist( strcat( "lab_", num2str( date ) ), 'dir' )
        mkdir( strcat( "lab_", num2str( date ) ) );
    end
    save data_handler;
end

% ask for time
hour = input( 'Ora della prova ? ', 's' );
hour = strrep( hour, ' ', '-');
hour = hour(1:8);

% build the name
name = strcat( "data_", data_handler.date( date ), "_", hour, ".mat" );
% substitute - con _
name_ = strrep( name, '-', '_');

% if it exists we have already created it
if exist( name_, 'file' ) == 2
    % load the file .mat the variable will be named data
    load( name_, 'data' );
    
    % if this time is not present in the structure search for it
elseif exist( name, 'file' ) ==  2
    data_ = load( name );
    
    %remove .mat
    [~, name_, ~] = fileparts( name_ );
    data_ = data_.(name_);
    
    data.title = input( "Vuoi dare un titolo alla prova? ", 's' );
    
    % ask for the structure
    str = input( 'Usare la stessa struttura del precedente esperimento? ', 's');
    
    % if previous
    if strcmp( str, 'y' )
        
        % get name of previous
        folder_name = strcat( "lab_", num2str( date ) );
        listing = dir( folder_name );
        % The ones with underscores are the lasts, thus I can take
        % the last one
        latest = listing(end).name;
        
        % if there are enough underscores it is a struct
        if sum ( latest == '_' ) > 3
            % load previous
            data_prev = load( latest );
            data_prev = data_prev.data;
            
            %otherwise take the last of the previous lab
        elseif date > 1
            % get name of previous
            folder_name = strcat( "lab_", num2str( date-1 ) );
            listing = dir( folder_name );
            % The ones with underscores are the lasts, thus I can take
            % the last one
            latest = listing(end).name;
            % load previous
            data_prev = load( latest );
            data_prev = data_prev.data;
        else
            return;
        end
        
        
        % substitutes data
        n_signals = size(data_, 1);
        fields = fieldnames( data_prev );
        % remove title, num signal and time steps
        n_fields = numel( fields )-3;
        disp( strcat("You have ", num2str(n_signals), " signals and ", num2str(n_fields), " fields.") );
        for idx = 1:n_fields
            % plus one to jump over title, num signal and time steps are
            % always at the end
            data.(fields{idx+1}) = data_(idx, :);
        end
        % add new ones
        if n_signals-n_fields > 0
            disp( strcat("You have ", num2str(n_signals-n_fields), " signals to assign.") );
            for idx = (n_fields+1):n_signals
                request = strcat( "Signal ", num2str(idx), ". Insert name: ");
                str = input( request , 's');
                if ~strcmp( str, 'discard')
                    data.(str) = data_(idx, :);
                end
            end
        end
        
        % if new
    else
        % ask for the number of signals their names(rows)
        
        n_signals = size(data_, 1);
        disp( strcat("You have ", num2str(n_signals), " signals.") );
        for idx = 1:n_signals
            request = strcat( "Signal ", num2str(idx), ". Insert name: ");
            str = input( request , 's');
            if ~strcmp( str, 'discard')
                data.(str) = data_(idx, :);
            end
        end
     
    end
    % save all
        data.n_signal = numel( fieldnames(data) )-1;
        data.time_steps = size( data_, 2);
        save( strcat("lab_", num2str( date ), "/", name_, '.mat' ), 'data' );
else
    disp( 'Non presente.' );
end


end
