%test 
controller.active_technique = 6;
%% ORE:
controller.c6.Kp = -0.656;
controller.c6.Ki = -2.71;
controller.c6.Kd = -0.0397;

controller.c6.wn_p1=24.5;         
controller.c6.psi_p1=1.36e-01;
controller.c6.wn_p2=61.9;
controller.c6.psi_p2=2.52e-02;
controller.c6.psi_nf1=0.72;
controller.c6.psi_nf2=0.9;

Nfp1 = ...
        ((controller.c6.wn_p1-0.5)^2/(controller.c6.wn_p1+0.5)^2)*...
        (s^2+2*controller.c6.psi_p1*(controller.c6.wn_p1+0.5)*s+(controller.c6.wn_p1+0.5)^2)/...
        (s^2+2*controller.c6.psi_nf1*(controller.c6.wn_p1-0.5)*s+(controller.c6.wn_p1-0.5)^2);
    Nfp2 = ...
        ((controller.c6.wn_p2-0.5)^2/(controller.c6.wn_p2+0.5)^2)*...
        (s^2+2*controller.c6.psi_p2*(controller.c6.wn_p2+0.5)*s+(controller.c6.wn_p2+0.5)^2)/...
        (s^2+2*controller.c6.psi_nf2*(controller.c6.wn_p2-0.5)*s+(controller.c6.wn_p2-0.5)^2);
    controller.c6.Nf = Nfp1*Nfp2;

controller.c6.Pf=1;

%% ORE:
controller.active_technique = 6;

controller.c6.Kp = -0.914;
controller.c6.Ki = -3.93;
controller.c6.Kd = -0.0532;

controller.c6.wn_p1=24.5;         
controller.c6.psi_p1=1.36e-01;
controller.c6.wn_p2=61.9;
controller.c6.psi_p2=2.52e-02;
controller.c6.psi_nf1=0.72;
controller.c6.psi_nf2=0.9;

Nfp1 = ...
        ((controller.c6.wn_p1-0.5)^2/(controller.c6.wn_p1+0.5)^2)*...
        (s^2+2*controller.c6.psi_p1*(controller.c6.wn_p1+0.5)*s+(controller.c6.wn_p1+0.5)^2)/...
        (s^2+2*controller.c6.psi_nf1*(controller.c6.wn_p1-0.5)*s+(controller.c6.wn_p1-0.5)^2);
    Nfp2 = ...
        ((controller.c6.wn_p2-0.5)^2/(controller.c6.wn_p2+0.5)^2)*...
        (s^2+2*controller.c6.psi_p2*(controller.c6.wn_p2+0.5)*s+(controller.c6.wn_p2+0.5)^2)/...
        (s^2+2*controller.c6.psi_nf2*(controller.c6.wn_p2-0.5)*s+(controller.c6.wn_p2-0.5)^2);
    controller.c6.Nf = Nfp1*Nfp2;

controller.c6.Pf=1/(s/4+1);