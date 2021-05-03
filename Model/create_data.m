%create_data( obj, title, dataset_struct, exper )
%CREATE_DATA Creates the data object and saves it with its
%title, plus it deletes the set of data acqired.
% You require variables:
% title = "xxxx";
% dataset_struct = e_h.dataset_structs{idx};
% experiment = e_h.load_experiment();

% get the name of the datasets present in the folder.

listing = dir(  'data_*.mat' );
if isempty( listing )
    msg= 'No experiment is present in the current folder' ;
    error( msg );
end

num_avail = length( listing );
while num_avail
    fname = listing(1).name;
    raw_data = load( fname );
    name_ = strrep( fname, '-', '_' );
    %remove .mat
    [~, name_, ~] = fileparts( name_ );
    raw_data = raw_data.(name_);
    
    if isempty( raw_data )
        % if empty consume the object
        num_avail = num_avail -1;
        delete (listing(1).name );
        listing = listing( 2:end );
        warning( 'Data was empty. It has been deleted.' );
        
        % if we have emptied listing
        if ~num_avail
            msg = 'All experiment present in the current folder were empty' ;
            error( msg);
        end
    else
        num_avail = 0;
    end
end

% acquire title
% get last for default

title = e_h.data_title_search( title );
% title = e_h.get_new_title();

str = input( strcat( '[', title, "] ",'Title of the experiment: ' ), 's' );
if str ~= ""
    title = str;
end

% check title consistency
title = e_h.data_title_search( title );

% each field of the dataset is a row in data
fname = fieldnames( dataset_struct );
if numel(fname) > size( raw_data, 1 )
    msg =  'Dataset struct is not consistent with data acquired, less field are present' ;
    error( msg );
elseif numel(fname) < size( raw_data, 1 )
    msg = "Dataset struct is not consistent with data acquired, you are going to lose data.";
    error( msg );
end
for idx = 1: numel(fname)
    dataset_struct.(fname{idx}) = raw_data(idx, :);
end
% assign the remaining informations
data = dataset_struct;
data.title = title;
data.exp_title = experiment.title;
data.w_filter = experiment.w_filter;
data.n_signal = numel ( fieldnames( dataset_struct ) );
data.controller = [];
if controller.active_technique>0
    controller_string = strcat( 'c', num2str(controller.active_technique) );
    data.controller.(controller_string) = controller.(controller_string);
    
    if controller.active_technique > 8
        observer_string = "";
        switch controller.active_observer
            case 0
                observer_string = "obs_";
            case 1
                observer_string = "red_obs_";
        end
        observer_string = strcat( observer_string, num2str(active_dof), "dof");
        data.observer.(observer_string) = controller.(observer_string);
    end
end

disp( 'Do you want to insert some notes? ' );
data.notes = string(input( '', 's'));

% save the new data object
save( strcat( 'lab_', num2str(e_h.today_lab), '/', title), 'data');

% add it to the memory
e_h.hours( e_h.today_lab ,end+1) = name_( (end-7):end );
e_h.titles( e_h.today_lab ,end+1) = title;

% save handler
e_h.save;

% delete raw data
movefile( listing(1).name, 'processed_data' );