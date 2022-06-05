function dx=rhs_s(t,x,u)
dx = zeros(3,1);
tau = 0.2;
ro = 10;
k = 2;

dx(1)=x(2);
dx(2)=(k*u-x(2))/tau;
dx(3)=0.5*((x(1)-pi/2)^2 + ro * u^2);