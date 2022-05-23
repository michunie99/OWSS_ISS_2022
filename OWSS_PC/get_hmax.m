function u=get_hmax(t,p,x,u)
%Hamiltonian maximizer
%the solution of H_u(t, p, x,u)=0
tau = 0.2;

u=p(:,2)/tau;