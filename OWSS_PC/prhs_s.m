function dp = prhs_s(t, x, u, p)
dp=zeros(3,1);
tau = 0.2;
k = 2;

dp(1)= 0;
dp(2)= -p(1) + p(2)/tau + x(1) - pi/2;
dp(3)= p(2)/tau - k*u;
