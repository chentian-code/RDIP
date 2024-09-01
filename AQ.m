 clear
 L1 = 0.215;
 L2 = 0.1524;
 L3 = 0.4318;
 m1 = 0.2326;
 m2 = 0.04;
 m3 = 0.14;
 C1 = 0.05;
 C2 = 0.05;
 C3 = 0.05;
 I1=(m1/12)*L1*L1;
 I2=(m2/12)*L2*L2;
 I3=(m3/12)*L3*L3;

 g=9.8;
 x1 = 0;
 x2 = 0.002;
 x3 = 0;
 x1_dot = 0;
 x2_dot = 0;
 x3_dot = 0;

load('matrix.mat')

A=Ae(x1, I1, x1_dot, x2, I2, x2_dot, x3, I3, x3_dot,L1, L2, L3, m1, m2, m3, 0, g, C1, C2, C3);
B=Be(x1, I1, x1_dot, x2, I2, x2_dot, x3, I3, x3_dot,L1, L2, L3, m1, m2, m3, 0, g, C1, C2, C3);
A = double(A);
B = double(B);
C = [1,0,0,0,0,0];
D = 0;

Q = diag([10 10 10 1 1 1]);

R=0.01;

K=lqr(A,B,Q,R);


% Augmented A matrix
Aa = [A zeros(6,1);
      1 zeros(1,6)];
% Augmented B matrix
Ba = [B; 
      0];
% Augmented C matrix
Ca = [C 0];

% DESIGN OF AUGMENETED CONTROLLER Ka
Qa = diag([1 1 1 5 10 100 1000]); % --- Tune this
Ra = 0.001*diag([0.0001]); % --- Tune this

Ka = lqr(Aa, Ba, Qa, Ra);