function p=rk4p(pf,t,x,uk)
nt=length(t);np=length(pf);x=flipud(x);uk=flipud(uk);
t=t(end)-t;t=flipud(t);p=zeros(nt,np);p(1,:)=pf';
tmp=zeros(np,1);ptmp=pf;tt=0;
dp1=zeros(np,1);dp2=zeros(np,1);
dp3=zeros(np,1);dp4=zeros(np,1);
for k=1:nt-1
    h=t(k+1)-t(k);h_2=h/2;h_6=h/6;h_26=2*h_6;
    dp1=-prhs(tt,x(k,:)',uk(k+1,:)',ptmp);
    tmp=ptmp+h_2*dp1;tt=tt+h_2;
    x05=0.5*(x(k,:)+x(k+1,:))';
    dp2=-prhs(tt,x05,uk(k+1,:)',tmp);tmp=ptmp+h_2*dp2;
    dp3=-prhs(tt,x05,uk(k+1,:)',tmp);tmp=ptmp+h*dp3;tt=tt+h_2;
    dp4=-prhs(tt,x(k+1,:)',uk(k+1,:)',tmp);
    ptmp=ptmp+h_6*(dp1+dp4)+h_26*(dp2+dp3);
    p(k+1,:)=ptmp';
end
p=flipud(p);