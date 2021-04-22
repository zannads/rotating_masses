syms Rm k_m k_t eta_m eta_g K_g J_eq B_eq K_s1 J_1 B_1 K_s2 J_2 B_2 Lm s real;

%% 1 dof cpmpleto 
A = [ [-Rm/Lm,0,-k_m*K_g/Lm,0,0]; 
      [0, 0, 1, 0, 0];
      [k_t*eta_m*eta_g*K_g/J_eq,-K_s1/(J_eq),-B_eq/J_eq,K_s1/J_eq,0];
      [0, 0, 0, 0, 1];
      [0,K_s1/J_1,0,-K_s1/J_1,-B_1/J_1] ];
B = [1/Lm,0,0,0,0]';
C = zeros(2,5);
C(:,4:5) = -1*eye(2);

G = collect(inv(s*eye(5)-A)*B, s)

%% 1 dof ridotto
A = [0,1,0,0;
     -K_s1/J_eq,-(eta_m*eta_g*k_t*k_m*K_g^2/Rm+B_eq)/J_eq,K_s1/J_eq,0;
     0,0,0,1;
     K_s1/J_1,0,-K_s1/J_1,-B_1/J_1];
B = [0,eta_m*eta_g*k_t*K_g/(Rm*J_eq),0,0]';

G = collect(inv(s*eye(4)-A)*B, s)

%% 2 dof completo
A = zeros(7,7);
A(1,:) = [-Rm/Lm,0,-k_m*K_g/Lm,0,0,0,0];
A(2,3) = 1;
A(3,:) = [k_t*eta_m*eta_g*K_g/J_eq,-K_s1/(J_eq),-B_eq/J_eq,K_s1/J_eq,0,0,0];
A(4,5) = 1;
A(5,:) = [0,K_s1/J_1,0,-(K_s1+K_s2)/J_1,-B_1/J_1,K_s2/J_1,0];
A(6,7) = 1;
A(7,:) = [0,0,0,K_s2/J_2,0,-K_s2/J_2,-B_2/J_2];

B = [1/Lm,0,0,0,0,0,0]';
C = zeros(4,7);
C(:,4:7) = -1*eye(4);

G = collect(inv(s*eye(7)-A)*B, s)

%% 2 dof ridotto