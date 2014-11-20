function [p,d,control]=probability(x,a,b,molt)

%dato il vettore x degli eventi registrati el'intervallo [a,b] in cui
%questi eventi stanno, si calcola la distribuizione di probabilità p(x) e
%la densità di probabilità d(x)=dp/dx. Attenzione alla grandezza del
%vettore event, ricalibrare il moltiplicatore molt nel caso si abbia già tanti
%eventi in x: size(event)<=60000 circa.

[~, n]=size(x);
event=linspace(a,b,n*molt);
dp=event(1,2)-event(1,1);
p(1,n)=0;
%calcolo p(x), attenzione al doppio ciclo for!
for i=1:n*molt
    f=0;
    for j=1:n
        if x(1,j)<=event(1,i)
            f=f+1;
        end;
    end;
    p(1,i)=f/n;
end;
p1=p;
%calcolo d(x) come derivata, tremite rapporto incrementale
d(1,n)=0;
parfor i=1:n*molt-1
    d(1,i)=(p(1,i+1)-p1(1,i))/dp;
end;
%variabile di controllo, dovrebbe essere circa pari a 1.
control=sum(d)*dp;