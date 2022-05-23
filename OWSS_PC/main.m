clc;close all;

nu=50;tf=10;umax=5;umin=-5;
tau=(tf/nu)*[1:nu]';uopt=zeros(nu,1);
x0=[0;0;0];xf=[3*pi/2;0];W=0*eye(2);MDNS=1e3;


qh=@(uopt) cost_fun_s(uopt,tau,x0,xf,W,MDNS);
nu=length(uopt);LB=ones(nu,1)*umin;UB=ones(nu,1)*umax; %ograniczenia
options=optimoptions('fmincon');
options.SpecifyObjectiveGradient=true;
options.Display='iter';options.Algorithm='interior-point';
uopt=fmincon(qh,uopt,[],[],[],[],LB,UB,[],options);
[t,x,uk,nseg]=get_tx_s(tau,uopt,x0,MDNS);
pf=[-W*(x(end,1:end-1)'-xf);0];
p=rk4p_s(pf,t,x,uk);hmax=get_hmax(t,p,x,uk);
subplot(211);h=plot(t,[x(:,1) x(:,2)]);set(h,'linewidth',2);
legend('Kąt silnika','Prędkość silnika');
grid on
subplot(212);h=plot(t,hmax);set(h,'linewidth',2);
hold on;h=stairs(t,uk);set(h,'linewidth',2);
legend("Predykcja", "Sterowanie" );
grid on
%axis([0 t(end) umin-0.1 umax+0.1]);
hold off