function g=get_grad(tau,u,x0,xf,W,MDNS)
%solve state equation, forward
[t,x,uk,nseg]=get_tx(tau,u,x0,MDNS);
%final cond. psi
pf=-W*(x(end,:)'-xf);
%solve adjoint equation, backward
p=rk4p(pf,t,x,uk);
ng=length(tau);g=zeros(ng,1);
for k=1:ng-1
    hu=get_hu(tau(k),p(nseg(k),:)',x(nseg(k),:)',u(k+1,:)');
    %derrivative w.r.t. switching time
    g(k)=hu*(u(k+1)-u(k));
end
%derrivative w.r.t final time
g(end)=1-pf'*rhs(tau(end),x(end,:)',u(end,:)');