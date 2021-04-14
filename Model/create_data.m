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

fname = listing(1).name;
raw_data = load( fname );
name_ = strrep( fname, '-', '_' );
%remove .mat
[~, name_, ~] = fileparts( name_ );
raw_data = raw_data.(name_);

% each field of the dataset is a row in data
fname = fieldnames( dataset_struct );
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
end

% save the new data object
save( strcat( 'lab_', num2str(e_h.today_lab), '/', title), 'data');

% add it to the memory
e_h.hours( e_h.today_lab ,end+1) = name_( (end-7):end );
e_h.titles( e_h.today_lab ,end+1) = title;

% save handler
e_h.save;

% delete raw data
delete (listing(1).name );