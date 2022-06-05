clc;close all;
clear all;

rho = 500;
nu=50;tf=10;umax=1;umin=-1;
tau=(tf/nu)*(1:nu)';uopt=zeros(nu,1);
x0=[0;0;0];xf=[pi/2;0];W=rho*eye(2);MDNS=1e2;
steps = 50;
x_cale = [];
xp_cale = [];
t_cale = [];
u_cale = [];
h_cale = [];
t_end = 0;

figure(1)
hold on
for i = 0:steps
    qh=@(uopt) cost_fun_s(uopt,tau,x0,xf,W,MDNS);
    nu=length(uopt);LB=ones(nu,1)*umin;UB=ones(nu,1)*umax; %ograniczenia
    options=optimoptions('fmincon');
    options.SpecifyObjectiveGradient=true;
    options.Display='iter';options.Algorithm='interior-point';
    uopt=fmincon(qh,uopt,[],[],[],[],LB,UB,[],options);
    [t,x,uk,nseg]=get_tx_s(tau,uopt,x0,MDNS);
    pf=[-W*(x(end,1:end-1)'-xf);0];
    p=rk4p_s(pf,t,x,uk);
    [t1,x1]=rk4_s(x0,uk(1),tf/nu,MDNS);
    hmax=get_hmax(t,p,x,uk);
    x0 = x1(end,:);
    x_cale = [x_cale; x1];
    xp_cale = [xp_cale; x(1:22,:)];
    t_cale = [t_cale; t1+t_end];
    u_cale = [u_cale; uk(1)*ones(length(t1))];
    h_cale = [h_cale; hmax];
    plot(t+t_end, uk)
    uopt = [uopt(2:nu); 0];
    hold on
    t_end = t_cale(end,:);
end

hold off

figure(2)
hold on
subplot(211);h=plot(t_cale,[x_cale(:,1) x_cale(:,2)]);%, xp_cale(:,1) xp_cale(:,2)]);
set(h,'linewidth',2);
legend('Kąt silnika','Prędkość silnika');%,'Kąt silnika - predykcja','Prędkość silnika - predykcja');
grid on
subplot(212);%h=plot(t_cale,h_cale);set(h,'linewidth',2);
hold on;h=stairs(t_cale, u_cale);set(h,'linewidth',2);
legend( "Sterowanie" );
grid on
%axis([0 t(end) umin-0.1 umax+0.1]);
hold off