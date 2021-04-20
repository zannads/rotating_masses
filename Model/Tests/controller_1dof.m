s=tf('s');

%% Notch Filter

% parametri fino alle 16.43 (experiment 37)
% wn=46.08;
% wn_numNf= 46.5;
% wn_denNf=45.5;
% psi1=0.0879;
% psi2=0.72;

% parametri fino alle 17.04 (experiment 37)
% wn=46.08;
% wn_numNf= 46.5;
% wn_denNf=20;
% psi1=0.0879;
% psi2=1;
% 
% % parametri fino alle 17.11 (experiment 37)
% wn=46.08;
% wn_numNf= 41;
% wn_denNf=39;
% psi1=0.0879;
% psi2=0.72;

% parametri fino alle 17.50 (experiment 37)
% wn=46.08;
%  wn_numNf= 46.5;
%  wn_denNf=45.5;
% psi1=0.0879;
% psi2=0.9;

% parametri fino alle 17.50 (experiment 37)
wn=46.08;
 wn_numNf= 46.5;
 wn_denNf=45.5;
psi1=0.0879;
psi2=0.72;

Nf= (wn_denNf^2/wn_numNf^2)*(s^2+2*psi1*wn_numNf*s+wn_numNf^2)/(s^2+2*psi2*wn_denNf*s+wn_denNf^2);
% G_tot=Nf*G_opt;
% figure(2)
% bode(G_tot)
% step(G_tot)
% pidTuner(G_tot)


%% Regulator PI (for speed)

% parametri fino alle 16.02 (experiment 35)
%wc_v = 7;
% parametri  dalle 16.05 (experiment 36)
%wc_v = 5;
% parametri fino alle 16.51 (experiment 35)
%wc_v = 7;
% parametri fino alle 17.51 (experiment 35)
wc_v = 5;
% parametri fino alle 18.00 (experiment 35)
wc_v = 9;
% parametri fino alle 18.05 (experiment 35)
wc_v = 7;
% parametri fino alle 16.51 (experiment 35)
wc_v = 5;
% parametri fino alle 16.51 (experiment 35)
wc_v = 6;



ki_v=wc_v;
kp_v=wc_v/38.4664;
Ti_v = kp_v/ki_v;
R1=kp_v+ki_v/s;
R=wc_v*(s/38.4664+1)/s;


% L=R*G_tot;
% F=L/(1+L);
% margin(L)

%% Regulator P (for position)
kp_p=1.5; %prova delle 18.28
kp_p=3; %prova delle 18.30
kp_p=5; %prova delle 18.33