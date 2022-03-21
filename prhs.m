function dp=prhs(t,x,u,p)
%Adjoint equations
dp=zeros(3,1);
w0 = 2.36;
ksi = 0.03;
k = -4.3434;
K = 529.798;
H = 0.0022;

dp(1)= w0^2*cos(x(1))*p(2);
dp(2)= -p(1)+2*ksi*w0*p(2);
dp(3)= -k*p(2)*H - p(3)*K*H;