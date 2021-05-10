%%int potentiometer
function out = int_potentiometer( motor_pos, time )
giri = 0;
eps = 0.02;
trasla_su = false;
trasla_giu = false;
out = zeros( size( motor_pos ) );
out(1) = motor_pos(1);
val_min = min(motor_pos);
val_max = max(motor_pos);
for idx = 2:length( motor_pos )
    
    % riconosci fine del giro
    if ( motor_pos(idx) > val_max-eps && motor_pos(idx-1) <= val_max-eps && trasla_su == false && trasla_giu == false )
        %if  ( motor_pos(idx) ) - motor_pos(idx-1) < -0.5
        trasla_su = true;
        trasla_giu = false;
        risalita = 0;
        % cercare last pos e new pos
        last_pos = idx-1;
%         motor_pos(1:idx);
%         last_pos_idx = last_pos > val_max-eps;
%         last_pos_over = find( last_pos_idx, 1, 'last' );
%         jdx = last_pos_over;
%         while last_pos_idx(jdx)
%             jdx = jdx-1;
%         end
%         last_pos_over = jdx;
%         
%         first_pos = motor_pos(idx:end);
%         first_pos_idx = first_pos < val_min+eps;
%         first_pos_over = find( first_pos_idx, 1, 'first');
%         
        
        out(last_pos) = motor_pos(last_pos) + giri*360/360*2*pi;
        giri = giri+1;
    elseif ( motor_pos(idx) ) < val_min+eps && motor_pos(idx-1) >= val_min+eps && trasla_giu == false && trasla_su == false
        trasla_giu = true;
        trasla_su = false;
        discesa = 0;
        last_pos = idx-1;
        out(last_pos) = motor_pos(last_pos) + giri*360/360*2*pi;
        giri = giri-1;
    end
    
    if trasla_su == true       % il giro è finito
        % elimina punti sopra soglia minima, sostituiscili con motor_pos(last_pos)
        if motor_pos(idx) > val_min+eps || risalita < 5
            out(idx) = motor_pos(last_pos) + (giri-1)*360/360*2*pi;
        end
        
        % riconosci quando almeno 5 punti consecutivi risalgono
        if motor_pos(idx) < -2 && motor_pos(idx) - motor_pos(idx-1) > 0
            risalita = risalita+1;
        end
        if risalita == 5
            out(idx) = motor_pos(idx) + giri*360/360*2*pi;
            trasla_su = false;     % è iniziato il giro nuovo
            
            % interpola punti nella zona morta
            pendenza = (out(idx) - out(last_pos)) / (time(idx)-time(last_pos));
            % mostra pendenze dove cambia giro
           % disp( strcat( 'idx: ', num2str(time(idx)), ' last_pos: ', num2str(time(last_pos)), ...
          %      ' pendenza: ', num2str(pendenza) ) );
            out(last_pos:idx-1) = out(last_pos) + ...
                pendenza * linspace( 0, idx-last_pos-1, idx-last_pos ) * 0.002;
        end
        
        
    elseif trasla_giu == true
        
         % elimina punti sopra soglia minima, sostituiscili con motor_pos(last_pos)
        if motor_pos(idx) < val_max-eps || discesa < 5
            out(idx) = motor_pos(last_pos) + (giri-1)*360/360*2*pi;
        end
        
        % riconosci quando almeno 5 punti consecutivi risalgono
        if motor_pos(idx) > 2 && motor_pos(idx) - motor_pos(idx-1) < 0
            discesa = discesa+1;
        end
        if discesa == 5
            out(idx) = motor_pos(idx) + giri*360/360*2*pi;
            trasla_giu = false;     % è iniziato il giro nuovo
            
            % interpola punti nella zona morta
            pendenza = (out(idx) - out(last_pos)) / (time(idx)-time(last_pos));
            % mostra pendenze dove cambia giro
          %  disp( strcat( 'idx: ', num2str(time(idx)), ' last_pos: ', num2str(time(last_pos)), ...
           %     ' pendenza: ', num2str(pendenza) ) );
            out(last_pos:idx-1) = out(last_pos) + ...
                pendenza * linspace( 0, idx-last_pos-1, idx-last_pos ) * 0.002;
        end
    else
        % else il motore si è fermato nella zona morta
        out(idx) = motor_pos(idx) + giri*360/360*2*pi;    % perché 352° e non 360° ?!
    end
    
end

end
