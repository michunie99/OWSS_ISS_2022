function [q,g]=cost_fun(tau,u,x0,xf,W,MDNS)
% xf - stan docelowy, W=W^T>0 - macierz wag
%calkowanie rownania stanu
[~,x]=get_tx(tau,u,x0,MDNS);
% roznica pomiedzy stanem koncowym i docelowym
dxend=x(end,:)'-xf;
% funkcja celu
q=tau(end)+0.5*dxend'*W*dxend;
if nargout>1
    %opcjonalne obliczenie gradientu
    g=get_grad(tau,u,x0,xf,W,MDNS);
end