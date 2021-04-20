%% %% %% Experiment: 
dataset_struct = e_h.dataset_structs{3}; 
% da controllare e decidere eventualmente si fa una nuvoa struttura in base
% ai dati che voglaimo taccogliere
%% %% 1-DOF:Speed Loop
controller.active_technique = 1;
%called c1

%%  ORE: 2.36
    title = "test_1";
   % experiment = e_h.load_experiment; % da decidere quale/ quali
    controller.c1.wc_v = 4;
    controller.c1.wn_numNf= 40;
    controller.c1.wn_denNf= 41;
    controller.c1.psi1=5.22e-2; %5.18e-2;
    controller.c1.psi2=0.72;
    controller.c1.Pf=1;
%%  ORE:14.52
    title = "test_2";
    experiment = e_h.load_experiment; % da decidere quale/ quali
    controller.c1.wc_v = 5;
    controller.c1.wn_numNf= 40;
    controller.c1.wn_denNf= 41;
    controller.c1.psi1=5.22e-2; %5.18e-2;
    controller.c1.psi2=0.72;
    controller.c1.Pf=1;
%%  ORE:15.03
    title = "test_3";
    controller.c1.wc_v = 5; %% The one chose by us
    controller.c1.wn_numNf= 41;
    controller.c1.wn_denNf= 42;
    controller.c1.psi1=5.22e-2; %5.18e-2;
    controller.c1.psi2=0.72;
    controller.c1.Pf=1;
%%  ORE: 15.05
title = "test_4";
    controller.c1.wc_v = 3;
    controller.c1.wn_numNf= 41;
    controller.c1.wn_denNf= 42;
    controller.c1.psi1=5.22e-2; %5.18e-2;
    controller.c1.psi2=0.72;
    controller.c1.Pf=1;
%%  ORE: 15.08
title = "test_5";
    controller.c1.wc_v = 3.5;
    controller.c1.wn_numNf= 41;
    controller.c1.wn_denNf= 42;
    controller.c1.psi1=5.22e-2; %5.18e-2;
    controller.c1.psi2=0.72;
    controller.c1.Pf=1;
%%  ORE: 15.12
title = "test_6";
    controller.c1.wc_v = 3.5;
    controller.c1.wn_numNf= 41;
    controller.c1.wn_denNf= 42;
    controller.c1.psi1=8.3e-2; %5.18e-2;
    controller.c1.psi2=0.72;
    controller.c1.Pf=1;
%%  ORE: 15.15
title = "test_7";
    controller.c1.wc_v = 5;
    controller.c1.wn_numNf= 41;
    controller.c1.wn_denNf= 42;
    controller.c1.psi1=8.3e-2; %5.18e-2;
    controller.c1.psi2=0.72;
    controller.c1.Pf=1;
%%  ORE: 3.18
title = "test_8";
    controller.c1.wc_v = 5;
    controller.c1.wn_numNf= 41;
    controller.c1.wn_denNf= 42;
    controller.c1.psi1=8.3e-2; %5.18e-2;
    controller.c1.psi2=0.95; 
    controller.c1.Pf=1;   
    %%  ORE: 3.20
    title = "test_9";
    controller.c1.wc_v = 4;
    controller.c1.wn_numNf= 41;
    controller.c1.wn_denNf= 42;
    controller.c1.psi1=8.3e-2; %5.18e-2;
    controller.c1.psi2=0.72; 
    controller.c1.Pf=1;   
    %%  ORE: 3.26
    %con polo a 33.4 prima era 32.6
    title = "test_10";
    controller.c1.wc_v = 4;
    controller.c1.wn_numNf= 41;
    controller.c1.wn_denNf= 42;
    controller.c1.psi1=8.3e-2; %5.18e-2;
    controller.c1.psi2=0.72; 
    controller.c1.Pf=1;   
    %% PI-structure    
    controller.c1.ki_v = controller.c1.wc_v;
    controller.c1.kp_v = controller.c1.wc_v/33.4;%32.6
    controller.c1.Ti_v = controller.c1.kp_v/controller.c1.ki_v;
    %% Notch-filter
    controller.c1.Nf= (controller.c1.wn_denNf^2/controller.c1.wn_numNf^2)*...
        (s^2+2*controller.c1.psi1*controller.c1.wn_numNf*s+controller.c1.wn_numNf^2)/...
        (s^2+2*controller.c1.psi2*controller.c1.wn_denNf*s+controller.c1.wn_denNf^2);

    
    
%% %% 1-DOF:Speed Loop + Position Loop
controller.active_technique = 2;
%called c2


%% ORE = 3.22
 title = "test_11"; title = "test_12";
    controller.c2.wc_v = 5;
    controller.c2.kp_p= 2;
    controller.c2.wn_numNf= 41;
    controller.c2. wn_denNf= 42;
    controller.c2.psi1=8.3e-2; 
    controller.c2.psi2=0.72; 
    controller.c2.Pf=1;
    %% ORE = 3.54
     title = "test_13";
    controller.c2.wc_v = 5;
    controller.c2.kp_p = 4;
    controller.c2.wn_numNf= 41;
    controller.c2. wn_denNf= 42;
    controller.c2.psi1=8.3e-2; 
    controller.c2.psi2=0.72; 
    controller.c2.Pf=1;
     %% ORE = 4.00
     title = "test_14";
    controller.c2.wc_v = 5;
    controller.c2.kp_p = 6;
    controller.c2.wn_numNf= 41;
    controller.c2. wn_denNf= 42;
    controller.c2.psi1=8.3e-2; 
    controller.c2.psi2=0.72; 
    controller.c2.Pf=1;
    
    %% ORE = 4.12
    title = "test_15";
    controller.c2.wc_v = 7;
    controller.c2.kp_p = 6;
    controller.c2.wn_numNf= 41;
    controller.c2. wn_denNf= 42;
    controller.c2.psi1=8.3e-2; 
    controller.c2.psi2=0.72; 
    controller.c2.Pf=1;
    
    %% ORE = 4.20
    title = "test_16";
    controller.c2.wc_v = 5;
    controller.c2.kp_p= 4;
    controller.c2.wn_numNf= 41;
    controller.c2.wn_denNf= 42;
    controller.c2.psi1= 8.3e-2; 
    controller.c2.psi2=0.72; % Se gli esperimenti prima è meglio 0.95 cambiarlo
    controller.c2.Pf=(s/controller.c2.kp_p+1)/(s/8+1);  
    %% ORE = 4.27
    title = "test_17";
    controller.c2.wc_v = 5;
    controller.c2.kp_p= 4;
    controller.c2.wn_numNf= 41;
    controller.c2.wn_denNf= 42;
    controller.c2.psi1= 8.3e-2; 
    controller.c2.psi2=0.72; % Se gli esperimenti prima è meglio 0.95 cambiarlo
    controller.c2.Pf=(s/controller.c2.kp_p+1)/(s/6+1);  
   %% PI-structure    
    controller.c2.ki_v = controller.c2.wc_v;
    controller.c2.kp_v = controller.c2.wc_v/33.4;
    controller.c2.Ti_v = controller.c2.kp_v/controller.c2.ki_v;
    %% Notch-filter
    controller.c2.Nf= (controller.c2.wn_denNf^2/controller.c2.wn_numNf^2)*...
        (s^2+2*controller.c2.psi1*controller.c2.wn_numNf*s+controller.c2.wn_numNf^2)/...
        (s^2+2*controller.c2.psi2*controller.c2.wn_denNf*s+controller.c2.wn_denNf^2);

    
    
%% %% 2-DOF:Speed Loop 
controller.active_technique = 3;
%called c3

%% ORE = 16.59
    title = "test_18";
    controller.c3.wc_v=2;
    controller.c3.wn_p1=24.5;         
    controller.c3.psi_p1=1.36e-01;        
    controller.c3.wn_p2=61.9;             
    controller.c3.psi_p2=2.52e-02;
    controller.c3.psi_nf1=0.72;
    controller.c3.psi_nf2=0.72;
    controller.c3.Pf=1;

%% ORE = 17.10
    title = "test_19";
    controller.c3.wc_v=2;
    controller.c3.wn_p1=24.5;         
    controller.c3.psi_p1=1.36e-01;        
    controller.c3.wn_p2=61.9;             
    controller.c3.psi_p2=2.52e-02;
    controller.c3.psi_nf1=0.72;
    controller.c3.psi_nf2=0.9;
    controller.c3.Pf=1;
    %% ORE = 17.40
    title = "test_20";
    controller.c3.wc_v=5;
    controller.c3.wn_p1=24.5;         
    controller.c3.psi_p1=1.36e-01;        
    controller.c3.wn_p2=61.9;             
    controller.c3.psi_p2=2.52e-02;
    controller.c3.psi_nf1=0.72;
    controller.c3.psi_nf2=0.9;
    controller.c3.Pf=1;
%% ORE = 18.00
% cambiato polo cancellato da 33.3 a 25
    title = "test_21";
    controller.c3.wc_v=5;
    controller.c3.wn_p1=24.5;         
    controller.c3.psi_p1=1.36e-01;        
    controller.c3.wn_p2=61.9;             
    controller.c3.psi_p2=2.52e-02;
    controller.c3.psi_nf1=0.72;
    controller.c3.psi_nf2=0.9;
    controller.c3.Pf=1;
    %% ORE = 18.15
% cambiato polo cancellato da 25 a 50
    title = "test_22";
    controller.c3.wc_v=3;
    controller.c3.wn_p1=24.5;         
    controller.c3.psi_p1=1.36e-01;        
    controller.c3.wn_p2=61.9;             
    controller.c3.psi_p2=2.52e-02;
    controller.c3.psi_nf1=0.72;
    controller.c3.psi_nf2=0.9;
    controller.c3.Pf=1;
    %% PI-structure    
    controller.c3.ki_v = controller.c3.wc_v;
    controller.c3.kp_v = controller.c3.wc_v/50; %33.3
    controller.c3.Ti_v = controller.c3.kp_v/controller.c3.ki_v;
    R = -controller.c3.wc_v*(s/50+1)/s;
%% Notch-filter
    
    Nfp1 = ...
        ((controller.c3.wn_p1-0.5)^2/(controller.c3.wn_p1+0.5)^2)*...
        (s^2+2*controller.c3.psi_p1*(controller.c3.wn_p1+0.5)*s+(controller.c3.wn_p1+0.5)^2)/...
        (s^2+2*controller.c3.psi_nf1*(controller.c3.wn_p1-0.5)*s+(controller.c3.wn_p1-0.5)^2);
    Nfp2 = ...
        ((controller.c3.wn_p2-0.5)^2/(controller.c3.wn_p2+0.5)^2)*...
        (s^2+2*controller.c3.psi_p2*(controller.c3.wn_p2+0.5)*s+(controller.c3.wn_p2+0.5)^2)/...
        (s^2+2*controller.c3.psi_nf2*(controller.c3.wn_p2-0.5)*s+(controller.c3.wn_p2-0.5)^2);
    controller.c3.Nf = Nfp1*Nfp2;
    
    
%% %% 2-DOF:Speed Loop + Position Loop
    controller.active_technique = 4;
    %called c4
    
%% ORE =18.28
    title = "test_23";
    controller.c4.kp_p=2.2;
    controller.c4.wc_v=3;
    controller.c4.wn_p1=24.5;         
    controller.c4.psi_p1=1.36e-01;        
    controller.c4.wn_p2=61.9;             
    controller.c4.psi_p2=2.52e-02;
    controller.c4.psi_nf1=0.72;
    controller.c4.psi_nf2=0.9;
    controller.c4.Pf=1;
    %% ORE =18.35
    title = "test_24";
    controller.c4.kp_p=2;
    controller.c4.wc_v=3;
    controller.c4.wn_p1=24.5;         
    controller.c4.psi_p1=1.36e-01;        
    controller.c4.wn_p2=61.9;             
    controller.c4.psi_p2=2.52e-02;
    controller.c4.psi_nf1=0.72;
    controller.c4.psi_nf2=0.9;
    controller.c4.Pf=1;
    
    %% ORE =18.45
    title = "test_25";
    controller.c4.kp_p=2;
    controller.c4.wc_v=3;
    controller.c4.wn_p1=24.5;         
    controller.c4.psi_p1=1.36e-01;        
    controller.c4.wn_p2=61.9;             
    controller.c4.psi_p2=2.52e-02;
    controller.c4.psi_nf1=0.72;
    controller.c4.psi_nf2=0.9;
    controller.c4.Pf=(s/2+1)/(s/4+1);
 %% PI-structure    
    controller.c4.ki_v = controller.c4.wc_v;
    controller.c4.kp_v = controller.c4.wc_v/33.3;
    controller.c4.Ti_v = controller.c4.kp_v/controller.c4.ki_v;
%% Notch-filter
    controller.c4.wn_p1=24.5;         
    controller.c4.psi_p1=1.36e-01;        

    controller.c4.wn_p2=61.9;             
    controller.c4.psi_p2=2.52e-02;

    Nfp1 = ...
        ((controller.c4.wn_p1-0.5)^2/(controller.c4.wn_p1+0.5)^2)*...
        (s^2+2*controller.c4.psi_p1*(controller.c4.wn_p1+0.5)*s+(controller.c4.wn_p1+0.5)^2)/...
        (s^2+2*controller.c4.psi_nf1*(controller.c4.wn_p1-0.5)*s+(controller.c4.wn_p1-0.5)^2);
    Nfp2 = ...
        ((controller.c4.wn_p2-0.5)^2/(controller.c4.wn_p2+0.5)^2)*...
        (s^2+2*controller.c4.psi_p2*(controller.c4.wn_p2+0.5)*s+(controller.c4.wn_p2+0.5)^2)/...
        (s^2+2*controller.c4.psi_nf2*(controller.c4.wn_p2-0.5)*s+(controller.c4.wn_p2-0.5)^2);
    controller.c4.Nf = Nfp1*Nfp2;
    


    