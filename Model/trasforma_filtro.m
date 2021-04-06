elimina_filtro = tf( [1 25], 25 );
filtro_corretto = tf( 25*2*pi, [1 25*2*pi] );
trasforma = elimina_filtro * filtro_corretto;

figure
plot( data2.data.time, data2.data.mass1_vel ); hold on
data1.data.mass1_vel = lsim( data1.data.mass1_vel, trasforma, data1.data.time );
plot( data1.data.time, data1.data.mass1_vel );