function [sigma,mu]=sqm(x,p)

%calcola la media mu e lo scarto quadratico medio sigma (dove sigma è la
%sqrt della varianza). In input deve avere tutti i possibili valori che una
%grandezza può assumere (x) e la sua densità di probabilità (p).

[~, n]=size(x);
%S=sum(p);
mu=0;
%dx=x(1,2)-x(1,1);
dx=(max(x)-min(x))/n;
integral=x.*p;
integral1=integral;
parfor i=1:n-1
    mu=mu+(integral(1,i)+integral1(1,i+1))*dx*0.5;
end;
%mu=mu/S;
sigma=0;
%Integrale a trapezi
integral=((x-mu).^2).*p;
integral1=integral;
parfor i=1:n-1
    sigma=sigma+(integral(1,i)+integral1(1,i+1))*dx*0.5;
end;
sigma=sqrt(sigma);