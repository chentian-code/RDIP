load('matrix.mat')
A=Ae(x1, I1, x1_dot, x2, I2, x2_dot, x3, I3, x3_dot,L1, L2, L3, m1, m2, m3, 0, g, C1, C2, C3);
B=Be(x1, I1, x1_dot, x2, I2, x2_dot, x3, I3, x3_dot,L1, L2, L3, m1, m2, m3, 0, g, C1, C2, C3);
A = double(A);
B = double(B);
C = [1,0,0,0,0,0];
D = 0;

y = ss(A,B,C,D);

w1 = makeweight(500,[0.05,0.001],0.0001);
w2 = 0.0003;
w3 = 0;

P = augw(G,w1,w2,w3);

nmeas=1;
ncont=1;
[K,CL,gamma] = hinfsyn(P,nmeas,ncont);

A_c = K.A;
B_c = K.B;
C_c = K.C;
D_c = K.D;
save controler A_c B_c C_c D_c
