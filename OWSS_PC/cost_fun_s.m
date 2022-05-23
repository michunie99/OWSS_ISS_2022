function [q,g]=cost_fun_s(u,tau,x0,xf,W,MDNS)
% xf - stan docelowy, W=W^T>0 - macierz wag
%calkowanie rownania stanu
[~,x]=get_tx_s(tau,u,x0,MDNS);
% roznica pomiedzy stanem koncowym i docelowym
dxend=x(end,1:end-1)'-xf;
% funkcja celu
q=x(end,end)+0.5*dxend'*W*dxend;
if nargout>1
%opcjonalne obliczenie gradientu
g=get_grad_s(tau,u,x0,xf,W,MDNS);
end