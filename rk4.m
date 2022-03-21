function [t,x]=rk4(x0,u,tf,MDNS)
x0=x0(:);u=u(:);n=length(x0);
nt=1+floor(tf*MDNS);h=tf/nt;
x=zeros(nt+1,n);t=zeros(nt+1,1);
x(1,:)=x0';
tmp=zeros(n,1);xtmp=x0;tt=0;
dx1=zeros(n,1);dx2=zeros(n,1);
dx3=zeros(n,1);dx4=zeros(n,1);
h_2=h/2;h_6=h/6;h_26=2*h_6;
for i=1:nt
    dx1=rhs(tt,xtmp,u);tmp=xtmp+h_2*dx1;tt=tt+h_2;
    dx2=rhs(tt,tmp,u);tmp=xtmp+h_2*dx2;
    dx3=rhs(tt,tmp,u);tmp=xtmp+h*dx3;tt=tt+h_2;
    dx4=rhs(tt,tmp,u);
    xtmp=xtmp+h_6*(dx1+dx4)+h_26*(dx2+dx3);
    x(i+1,:)=xtmp';t(i+1)=tt;
end