clc
clear all

%Motor Parameter
Rm=2.6;
Kt=7.68e-3;
Km=7.68e-3;
Lm=0.18e-3;
Vnom=6;
Imax=1;
Wmax=628.3;
Ith=1.6*Imax;
Vth=1*Vnom;
eta_motor=0.69;
fmax=50;

Jm=3.90e-7;
Jtach=7.06e-8;
Jeq=2.087e-3;
Beq=0.015;
mb=0.038;


Wcv=Beq/Jeq;
Kp_v=Wcv*Jeq;
Ki_v=Wcv*Beq;
Ti_v=Kp_v/Ki_v;

Wci=Rm/Lm;
Kp_i=Wci*Lm;
Ki_i=Wci*Rm;
Ti_i=Kp_i/Ki_i;

Wcp=Wcv/10;
Kp_p=Wcp;

