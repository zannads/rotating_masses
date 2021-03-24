classdef experiment_handler
    %EXPERIMENT_HANDLER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        %lab names 
        date
        
        % experiment hours 
        
        % experiment titles 
    end
    
    methods
        function obj = experiment_handler( name )
            %EXPERIMENT_HANDLER Construct an instance of this class
            %   Detailed explanation goes here
            
            % se esiste il nome lo carica 
            
            % se non esiste lo crea vuoto 
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            % insert laboratorio 
        end
        
        % load_data che è la stessa cosa dell'attuale data_handler
        
            % se esiste caricalo 
            % se non esiste crea come adesso
            
        % delete_data % cancella l'ogetto dell'esperimento 
        
        % do experiment : carica l'esper pausa per interagire con simulink
        % load dell' ultimo risultato lo salva formattato come vogliamo noi
        % elimina file con i - . 
        
        % define experiment 
        % print experiment
        % load eperiment
        % delete experiment 
        % modify experiment 
        
        %EXPERIMENT: 
        % experiment . title = 
        %           . tipo == % scalino % swept sin % multiple steps 
        %           se scalino -> prende tempo iniziale e ampiezza
        % se swept sine valore medio freq inziale frequenza finale ecc
        %           se multipple - > array [data. time, data.voltage]
                % [1: 10 ] = 3; [11: 20] = m.*t +q]        
                
        
                
                
    end
end

