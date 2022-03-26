clear all
clc

tau = [8;8.5;9;9.5;10];
u = [0;1;-1;1;-1];
x0 = [pi/4,0,0];
step = 100;
xf  = [pi;0;0];
[t,x,uk,nseg] = get_tx(tau,u,x0,step);

ro = 100; % współczynnik kary
w1 = 1; % współczynnik kąta wahadła
w2 = 1; % współczynnik prędkości wahadła
w3 = 0; % współczynnik kąta silnika
W = ro*diag([w1,w2,w3]);
[q, g] = cost_fun(tau,u,x0,xf,W,step);


hold on
% plot([t;t2+1],[x(:,1);x2(:,1)])
% plot([t;t2+1],[x(:,2);x2(:,2)])
% plot([t;t2+1],[0.1*x(:,3);0.1*x2(:,3)])
% plot([t;t2+1],[uk;uk2])
plot(t,x(:,1))
plot(t,x(:,2))
%plot(t,0.1*x(:,3))
plot(t,uk)
legend('kąt1','prędkość wahadła 1','sterowanie')
hold off

%% Display animation
dT = t(end)/length(t);
animate_pendelum(x,dT);
