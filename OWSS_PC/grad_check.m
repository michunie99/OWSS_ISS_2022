clear;close all;tau=[.2 .3 .4 .5]';u=1.0*[1;-1;1;1];
x0=[0;0;0;0];xf=[pi;0;0];W=1000*eye(3);MDNS=1e3;
ep=1e-9;gnum=zeros(length(u),1);
[q,g]=cost_fun_s(u,tau,x0,xf,W,MDNS);
for k=1:length(tau)
ei=zeros(length(u),1);ei(k)=1;
up=u+ei*ep;um=u-ei*ep;
fp=cost_fun_s(up,tau,x0,xf,W,MDNS);
fm=cost_fun_s(um,tau,x0,xf,W,MDNS);
gnum(k)=(fp-fm)/(2*ep);
end
%porownanie g - r. sprz., gnum - rozn.
[g';gnum']