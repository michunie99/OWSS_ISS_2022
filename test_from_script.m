% clear;close all;tauopt=[0.1 0.20 0.40]';u=1.0*[1;-1;1];
% x0=[0;0;0];xf=[pi;0;0];
% 
% 
% %W=1000*eye(3);
% ro = 1000; % współczynnik kary
% w1 = 1; % współczynnik kąta wahadła
% w2 = 1; % współczynnik prędkości wahadła
% w3 = 0; % współczynnik kąta silnika
% W = ro*diag([w1,w2,w3]);

clear;close all;tauopt=[0.2 1 2]';u=1.0*[1;-1;1];
x0=[0;0;0];xf=[pi;0;0];

%W=1000*eye(3);
ro = 1000; % współczynnik kary
w1 = 1; % współczynnik kąta wahadła
w2 = 1; % współczynnik prędkości wahadła
w3 = 0; % współczynnik kąta silnika
W = ro*diag([w1,w2,w3]);


MDNS=300;
qh=@(tauopt) cost_fun(tauopt,u,x0,xf,W,MDNS);
nb=length(tauopt);b=0.0*ones(nb,1);A=-eye(nb);

for k=2:nb
    A(k,k-1)=1;
end %ograniczenia

options=optimoptions('fmincon');
options.SpecifyObjectiveGradient=true;
options.Display='iter';
options.Algorithm='interior-point';

tauopt=fmincon(qh,tauopt,A,b,[],[],[],[],[],options);
[t,x,uk,nseg]=get_tx(tauopt,u,x0,MDNS);pf=-W*(x(end,:)'-xf);
p=rk4p(pf,t,x,uk);nt=length(t);hu=zeros(nt,1);

for k=1:nt
    hu(k)=get_hu(t(k),p(k,:)',x(k,:)',uk(k,:)');
end

%% 
x(:,3) = x(:,3)/100;
hu=hu/max(abs(hu));
subplot(211);h=plot(t,x);set(h,'linewidth',2);
legend('Kąt wahadła','Prędkość wahadła', 'Prędkość koła');
subplot(212);h=stairs(t,uk/max(uk));set(h,'linewidth',2);
hold on;h=plot(t,hu);grid;set(h,'linewidth',2);
legend('Sterowanie','Gradient');
axis([0 t(end) -1.1 1.1]);hold off

%% Display animation
dT = t(end)/(2*length(t));
animate_pendelum(x,dT);