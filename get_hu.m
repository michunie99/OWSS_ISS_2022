function hu=get_hu(t,p,x,u)
%funkcja przelaczajaca,
%pochodna hamiltonianu wzgledem sterowania
k = -4.3434;
K = 529.798;
hu = p(2)*k + p(3)*K;