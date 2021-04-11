% data.motor_pos(:,2) = int_potentiometer( data.motor_pos(:,2) );
close all
figure(2)
plot( data.motor_pos(:,1), data.motor_pos(:,2), 'o' ); hold on
plot( data.motor_pos(:,1), int_potentiometer( data.motor_pos(:,2),data.motor_pos(:,1) ), 'o' )

%%
function out = int_potentiometer( motor_pos, time )
giri = 0;
trasla = false;
out = zeros( size( motor_pos ) );
out(1) = motor_pos(1);
for idx = 2:length( motor_pos )
    
    % riconosci fine del giro
    if ( motor_pos(idx) ) > 5.92 && motor_pos(idx-1) <= 5.92 && trasla == false
        trasla = true;
        risalita = 0;
        last_pos = idx-1;
        out(last_pos) = motor_pos(last_pos) + giri*352/360*2*pi;
        giri = giri+1;
    end
    
    if trasla == true       % il giro è finito
        % elimina punti sopra soglia minima, sostituiscili con motor_pos(last_pos)
        if motor_pos(idx) > 0.08 || risalita < 5
            out(idx) = motor_pos(last_pos) + (giri-1)*352/360*2*pi;
        end
        
        % riconosci quando almeno 5 punti consecutivi risalgono
        if motor_pos(idx) < 2 && motor_pos(idx) - motor_pos(idx-1) > 0
            risalita = risalita+1;
        end
        if risalita == 5
            out(idx) = motor_pos(idx) + giri*352/360*2*pi;
            trasla = false;     % è iniziato il giro nuovo
            
            % interpola punti nella zona morta
            pendenza = (out(idx) - out(last_pos)) / (time(idx)-time(last_pos));
            % mostra pendenze dove cambia giro
            disp( strcat( 'idx: ', num2str(time(idx)), ' last_pos: ', num2str(time(last_pos)), ...
                ' pendenza: ', num2str(pendenza) ) );
            out(last_pos:idx-1) = out(last_pos) + ...
                pendenza * linspace( 0, idx-last_pos, idx-last_pos ) * 0.002;
        end
        % else il motore si è fermato nella zona morta
        
    else
        out(idx) = motor_pos(idx) + giri*352/360*2*pi;    % perché 352° e non 360° ?!
    end
    
end

end
