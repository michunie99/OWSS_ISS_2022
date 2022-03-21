function [t,x,uk,nseg]=get_tx(tau,u,x0,MDNS)
[ntau,nu]=size(u);n=length(x0);tau=[0;tau];
nt=1+sum(1+floor(MDNS*diff(tau)));
x=zeros(nt,n);
uk=zeros(nt,nu);
t=zeros(nt,1);nseg=zeros(ntau,1);kk=1;
for k=1:ntau
    [ttmp,xtmp]=rk4(x0,u(k,:)',tau(k+1)-tau(k),MDNS);% RK4
    x0=xtmp(end,:)';%warunek poczatkowy do nastepnego
    ni=1+floor(MDNS*(tau(k+1)-tau(k)));%liczba krokow
    x(kk:kk+ni-1,:)=xtmp(1:end-1,:);%zapis x
    t(kk:kk+ni-1)=tau(k)+ttmp(1:end-1,:);%zapis t
    uk(kk:kk+ni-1,:)=kron(u(k,:),ones(ni,1));%zapis uk
    kk=kk+ni;nseg(k)=kk;
end
x(end,:)=xtmp(end,:);% dodaje stan koncowy
uk(end,:)=u(end,:);% dodaje sterowanie na koncu
t(end)=tau(end);%dodaje czas koncowy
% t-wektor czasow [0, t1, ..., tn],