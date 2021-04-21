syms Rm k_m k_t eta_m eta_g K_g J_eq B_eq K_s1 J_1 B_1 s real;

A = [0,1,0,0;
     -K_s1/J_eq,-(eta_m*eta_g*k_t*k_m*K_g^2/Rm+B_eq)/J_eq,K_s1/J_eq,0;
     0,0,0,1;
     K_s1/J_1,0,-K_s1/J_1,-B_1/J_1];
B = [0,eta_m*eta_g*k_t*K_g/(Rm*J_eq),0,0]';

G = collect(inv(s*eye(4)-A)*B, s)