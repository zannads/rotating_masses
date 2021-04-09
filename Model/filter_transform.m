function out = filter_transform( time, mass_vel )

elimina_filtro = tf( [1 25], 25 );              % elimina filtro a 25 rad/s
filtro_corretto = tf( 25*2*pi, [1 25*2*pi] );   % aggiunge filtro a 25 Hz
trasforma = elimina_filtro * filtro_corretto;

out = lsim( mass_vel, trasforma, time );

end
