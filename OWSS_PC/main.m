clc;close all;
clear all;

nu=50;tf=1;umax=1;umin=-1;
tau=(tf/nu)*(1:nu)';uopt=zeros(nu,1);
x0=[0;0;0];xf=[pi/2;0];W=0*eye(2);MDNS=1e2;
steps = 10;
x_cale = [];
t_cale = [];
u_cale = [];
h_cale = [];

for i = 0:steps
    qh=@(uopt) cost_fun_s(uopt,tau,x0,xf,W,MDNS);
    nu=length(uopt);LB=ones(nu,1)*umin;UB=ones(nu,1)*umax; %ograniczenia
    options=optimoptions('fmincon');
    options.SpecifyObjectiveGradient=true;
    options.Display='iter';options.Algorithm='interior-point';
    uopt=fmincon(qh,uopt,[],[],[],[],LB,UB,[],options);
    [t,x,uk,nseg]=get_tx_s(tau,uopt,x0,MDNS);
    pf=[-W*(x(end,1:end-1)'-xf);0];
    p=rk4p_s(pf,t,x,uk);hmax=get_hmax(t,p,x,uk);
    x0 = x(end,:);
    x_cale = [x_cale; x];
    t_cale = [t_cale; (t + i*t(end))];
    u_cale = [u_cale; uk];
    h_cale = [h_cale; hmax];
    uopt = uk(1,:)*ones(nu,1);
end


subplot(211);h=plot(t_cale,[x_cale(:,1) x_cale(:,2)]);set(h,'linewidth',2);
legend('Kąt silnika','Prędkość silnika');
grid on
subplot(212);h=plot(t_cale,h_cale);set(h,'linewidth',2);
hold on;h=stairs(t_cale,u_cale);set(h,'linewidth',2);
legend("Predykcja", "Sterowanie" );
grid on
%axis([0 t(end) umin-0.1 umax+0.1]);
hold off