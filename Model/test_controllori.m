%% %% %% Experiment: 
dataset_struct = e_h.dataset_structs{3}; 
% da controllare e decidere eventualmente si fa una nuvoa struttura in base
% ai dati che voglaimo taccogliere
%% %% 1-DOF:Speed Loop
controller.active_technique = 1;
%called c1

%%  ORE: (facoltativi)
    title = "";
    experiment = e_h.load_experiment; % da decidere quale/ quali
    controller.c1.wc_v = 4;
    controller.c1.wn_numNf= 40;
    controller.c1.wn_denNf= 41;
    controller.c1.psi1=5.22e-2; %5.18e-2;
    controller.c1.psi2=0.72;
    controller.c1.Pf=1;
%%  ORE:
    title = "";
    experiment = e_h.load_experiment; % da decidere quale/ quali
    controller.c1.wc_v = 5;
    controller.c1.wn_numNf= 40;
    controller.c1.wn_denNf= 41;
    controller.c1.psi1=5.22e-2; %5.18e-2;
    controller.c1.psi2=0.72;
    controller.c1.Pf=1;
%%  ORE:
    controller.c1.wc_v = 5.5; %% The one chose by us
    controller.c1.wn_numNf= 40;
    controller.c1.wn_denNf= 41;
    controller.c1.psi1=5.22e-2; %5.18e-2;
    controller.c1.psi2=0.72;
    controller.c1.Pf=1;
%%  ORE:
    controller.c1.wc_v = 6;
    controller.c1.wn_numNf= 40;
    controller.c1.wn_denNf= 41;
    controller.c1.psi1=5.22e-2; %5.18e-2;
    controller.c1.psi2=0.72;
    controller.c1.Pf=1;
%%  ORE:
    controller.c1.wc_v = 7;
    controller.c1.wn_numNf= 40;
    controller.c1.wn_denNf= 41;
    controller.c1.psi1=5.22e-2; %5.18e-2;
    controller.c1.psi2=0.72;
    controller.c1.Pf=1;
%%  ORE: (facoltativo)
    controller.c1.wc_v = 5;
    controller.c1.wn_numNf= 40;
    controller.c1.wn_denNf= 41;
    controller.c1.psi1=5.22e-2; %5.18e-2;
    controller.c1.psi2=0.95;
    controller.c1.Pf=1;
%%  ORE: (facoltativo)
    controller.c1.wc_v = 6;
    controller.c1.wn_numNf= 40;
    controller.c1.wn_denNf= 41;
    controller.c1.psi1=5.22e-2; %5.18e-2;
    controller.c1.psi2=0.95;
    controller.c1.Pf=1;
%%  ORE: (facoltativo)
    controller.c1.wc_v = 7;
    controller.c1.wn_numNf= 40;
    controller.c1.wn_denNf= 41;
    controller.c1.psi1=5.22e-2; %5.18e-2;
    controller.c1.psi2=0.95; 
    controller.c1.Pf=1;   
    
    %% PI-structure    
    controller.c1.ki_v = controller.c1.wc_v;
    controller.c1.kp_v = controller.c1.wc_v/32.6;
    controller.c1.Ti_v = controller.c1.kp_v/controller.c1.ki_v;
    %% Notch-filter
    controller.c1.Nf= (controller.c1.wn_denNf^2/controller.c1.wn_numNf^2)*...
        (s^2+2*controller.c1.psi1*controller.c1.wn_numNf*s+controller.c1.wn_numNf^2)/...
        (s^2+2*controller.c1.psi2*controller.c1.wn_denNf*s+controller.c1.wn_denNf^2);

    
    
%% %% 1-DOF:Speed Loop + Position Loop
controller.active_technique = 2;
%called c2


%% ORE = 
    controller.c2.wc_v = 9;
    controller.c2.kp_p= 2;
    controller.c2.wn_numNf= 40;
    controller.c2. wn_denNf= 41;
    controller.c2.psi1=5.22e-2; 
    controller.c2.psi2=0.72; % Se gli esperimenti prima è meglio 0.95 cambiarlo
    controller.c2.Pf=1;
    %% ORE = 
    controller.c2.wc_v = 9;
    controller.c2.kp_p= 3;
    controller.c2.wn_numNf= 40;
    controller.c2.wn_denNf= 41;
    controller.c2.psi1=5.22e-2; 
    controller.c2.psi2=0.72; % Se gli esperimenti prima è meglio 0.95 cambiarlo
    controller.c2.Pf=1;
    %% ORE = 
    controller.c2.wc_v = 9;
    controller.c2.kp_p= 4;
    controller.c2.wn_numNf= 40;
    controller.c2.wn_denNf= 41;
    controller.c2.psi1=5.22e-2; 
    controller.c2.psi2=0.72; % Se gli esperimenti prima è meglio 0.95 cambiarlo
    controller.c2.Pf=1;
    %% ORE = 
    controller.c2.wc_v = 9;
    controller.c2.kp_p= 5;
    controller.c2.wn_numNf= 40;
    controller.c2.wn_denNf= 41;
    controller.c2.psi1=5.22e-2; 
    controller.c2.psi2=0.72; % Se gli esperimenti prima è meglio 0.95 cambiarlo
    controller.c2.Pf=1;
    %% ORE = 
    controller.c2.wc_v = 10;
    controller.c2.kp_p= 4;
    controller.c2.wn_numNf= 40;
    controller.c2.wn_denNf= 41;
    controller.c2.psi1=5.22e-2; 
    controller.c2.psi2=0.72; % Se gli esperimenti prima è meglio 0.95 cambiarlo
    controller.c2.Pf=1;
    
    %% ORE = 
    controller.c2.wc_v = 10;
    controller.c2.kp_p= 5;
    controller.c2.wn_numNf= 40;
    controller.c2.wn_denNf= 41;
    controller.c2.psi1=5.22e-2; 
    controller.c2.psi2=0.72; % Se gli esperimenti prima è meglio 0.95 cambiarlo
    controller.c2.Pf=1;   
    %% ORE = 
    controller.c2.wc_v = 10;
    controller.c2.kp_p= 6;
    controller.c2.wn_numNf= 40;
    controller.c2.wn_denNf= 41;
    controller.c2.psi1=5.22e-2; 
    controller.c2.psi2=0.72; % Se gli esperimenti prima è meglio 0.95 cambiarlo
    controller.c2.Pf=1;
    %% ORE = 
    controller.c2.wc_v = 9;
    controller.c2.kp_p= 4;
    controller.c2.wn_numNf= 40;
    controller.c2.wn_denNf= 41;
    controller.c2.psi1=5.22e-2; 
    controller.c2.psi2=0.72; % Se gli esperimenti prima è meglio 0.95 cambiarlo
    controller.c2.Pf=(s/controller.c2.kp_p+1)/(s/8+1);
    %% ORE = 
    controller.c2.wc_v = 10;
    controller.c2.kp_p= 4;
    controller.c2.wn_numNf= 40;
    controller.c2.wn_denNf= 41;
    controller.c2.psi1=5.22e-2; 
    controller.c2.psi2=0.72; % Se gli esperimenti prima è meglio 0.95 cambiarlo
    controller.c2.Pf=(s/controller.c2.kp_p+1)/(s/8+1);
    %% ORE = 
    controller.c2.wc_v = 10;
    controller.c2.kp_p= 5;
    controller.c2.wn_numNf= 40;
    controller.c2.wn_denNf= 41;
    controller.c2.psi1=5.22e-2; 
    controller.c2.psi2=0.72; % Se gli esperimenti prima è meglio 0.95 cambiarlo
    controller.c2.Pf=(s/controller.c2.kp_p+1)/(s/8+1);    
    %% ORE = 
    controller.c2.wc_v = 10;
    controller.c2.kp_p= 6;
    controller.c2.wn_numNf= 40;
    controller.c2.wn_denNf= 41;
    controller.c2.psi1=5.22e-2; 
    controller.c2.psi2=0.72; % Se gli esperimenti prima è meglio 0.95 cambiarlo
    controller.c2.Pf=(s/controller.c2.kp_p+1)/(s/8+1);  
   %% PI-structure    
    controller.c2.ki_v = controller.c2.wc_v;
    controller.c2.kp_v = controller.c2.wc_v/32.6;
    controller.c2.Ti_v = controller.c2.kp_v/controller.c2.ki_v;
    %% Notch-filter
    controller.c2.Nf= (controller.c2.wn_denNf^2/controller.c2.wn_numNf^2)*...
        (s^2+2*controller.c2.psi1*controller.c2.wn_numNf*s+controller.c2.wn_numNf^2)/...
        (s^2+2*controller.c2.psi2*controller.c2.wn_denNf*s+controller.c2.wn_denNf^2);

    
    
%% %% 2-DOF:Speed Loop 
controller.active_technique = 3;
%called c3

%% ORE =
    controller.c3.wc_v=2;
    controller.c3.psi_nf=0.9;
    controller.c3.Pf=1;
%% ORE =
    controller.c3.wc_v=2.5;
    controller.c3.psi_nf=0.9;
    controller.c3.Pf=1;
%% ORE =
    controller.c3.wc_v=3;
    controller.c3.psi_nf=0.9;
    controller.c3.Pf=1;
%% ORE =
    controller.c3.wc_v=3.5;
    controller.c3.psi_nf=0.9;
    controller.c3.Pf=1;
%% ORE = (facoltativo)
    controller.c3.wc_v=4;
    controller.c3.psi_nf=0.9;
    controller.c3.Pf=1;
    
    %% PI-structure    
    controller.c3.ki_v = controller.c3.wc_v;
    controller.c3.kp_v = controller.c3.wc_v/31.6;
    controller.c3.Ti_v = controller.c3.kp_v/controller.c3.ki_v;
%% Notch-filter
    controller.c3.wn_p1=24.8;         
    controller.c3.psi_p1=9.38e-02;        

    controller.c3.wn_p2=62.3;             
    controller.c3.psi_p2=6.66e-03;

    Nfp1 = ...
        ((controller.c3.wn_p1-0.5)^2/(controller.c3.wn_p1+0.5)^2)*...
        (s^2+2*controller.c3.psi_p1*(controller.c3.wn_p1+0.5)*s+(controller.c3.wn_p1+0.5)^2)/...
        (s^2+2*controller.c3.psi_nf*(controller.c3.wn_p1-0.5)*s+(controller.c3.wn_p1-0.5)^2);
    Nfp2 = ...
        ((controller.c3.wn_p2-0.5)^2/(controller.c3.wn_p2+0.5)^2)*...
        (s^2+2*controller.c3.psi_p2*(controller.c3.wn_p2+0.5)*s+(controller.c3.wn_p2+0.5)^2)/...
        (s^2+2*controller.c3.psi_nf*(controller.c3.wn_p2-0.5)*s+(controller.c3.wn_p2-0.5)^2);
    controller.c3.Nf = Nfp1*Nfp2;
    
    
%% %% 2-DOF:Speed Loop + Position Loop
    controller.active_technique = 4;
    %called c4
    
%% ORE =
    controller.c4.wc_v=3;
    controller.c4.kp_p=2;
    controller.c4.psi_nf=0.9;
    controller.c4.Pf=1;
%% ORE =
    controller.c4.wc_v=3;
    controller.c4.kp_p=2.2;
    controller.c4.psi_nf=0.9;
    controller.c4.Pf=1;
%% ORE =
    controller.c4.wc_v=3;
    controller.c4.kp_p=2.4;
    controller.c4.psi_nf=0.9;
    controller.c4.Pf=1;
%% ORE =
    controller.c4.wc_v=3.25;
    controller.c4.kp_p=2.2;
    controller.c4.psi_nf=0.9;
    controller.c4.Pf=1;
%% ORE =
    controller.c4.wc_v=3.25;
    controller.c4.kp_p=2.4;
    controller.c4.psi_nf=0.9;
    controller.c4.Pf=1;
%% ORE =
    controller.c4.wc_v=3;
    controller.c4.kp_p=2.4;
    controller.c4.psi_nf=0.9;
    controller.c4.Pf=1;
 %% PI-structure    
    controller.c4.ki_v = controller.c4.wc_v;
    controller.c4.kp_v = controller.c4.wc_v/31.6;
    controller.c4.Ti_v = controller.c4.kp_v/controller.c4.ki_v;
%% Notch-filter
    controller.c4.wn_p1=24.8;         
    controller.c4.psi_p1=9.38e-02;        

    controller.c4.wn_p2=62.3;             
    controller.c4.psi_p2=6.66e-03;

    Nfp1 = ...
        ((controller.c4.wn_p1-0.5)^2/(controller.c4.wn_p1+0.5)^2)*...
        (s^2+2*controller.c4.psi_p1*(controller.c4.wn_p1+0.5)*s+(controller.c4.wn_p1+0.5)^2)/...
        (s^2+2*controller.c4.psi_nf*(controller.c4.wn_p1-0.5)*s+(controller.c4.wn_p1-0.5)^2);
    Nfp2 = ...
        ((controller.c4.wn_p2-0.5)^2/(controller.c4.wn_p2+0.5)^2)*...
        (s^2+2*controller.c4.psi_p2*(controller.c4.wn_p2+0.5)*s+(controller.c4.wn_p2+0.5)^2)/...
        (s^2+2*controller.c4.psi_nf*(controller.c4.wn_p2-0.5)*s+(controller.c4.wn_p2-0.5)^2);
    controller.c4.Nf = Nfp1*Nfp2;
    


    