function [y,A,F]=eq_dif(t,a,b,fx_t,y0)

%t è il tempo, a il vettore dei coeff uscita (derivata grande-piccola), 
%b il vettore coeff ingresso (derivata grande-piccola),
%fx_t la funzione ingresso valutata in t, y0 le CAC da derivata più grande
%a quella più piccola.

[~, n]=size(t);
%differenziale
dt=t(1,2)-t(1,1);
%definizione dei gradi dei membri dell'equazione
[~, ga]=size(a);
[~, gb]=size(b);
%matrice di fx e sue derivate: prima riga -> derivata maggiore
F(gb,1:n)=fx_t(1,1:n);

for j=gb-1:-1:1
    f=gradient(F(j+1,:),dt);
    for i=1:n
        if abs(f(1,i))>1/dt %controllo sugli impulsi
            s=sign(f(1,i));
            f(1,i)=s*abs(F(j+1,i)/dt);
        end;
    end;
    F(j,2:n+1)=f(1,1:n);
end;

%matrice uscita e sue derivate: prima riga -> derivata maggiore
A(2:ga,1)=y0';
%calcolo primo elemento della derivata maggiore
for i=1:gb
    A(1,1)=A(1,1)+b(1,i)*F(i,1);
    imp=A(1,1);
end;
for i=2:ga
    A(1,1)=A(1,1)-a(1,i)*A(i,1);
end;
A(1,1)=A(1,1)/a(1,1);
if abs(A(1,1))>1/dt %controllo sugli impulsi
    s=sign(A(1,1));
    A(1,1)=s*abs(A(2,1)/(dt*a(1,1)));
    %A(1,i)=s/dt;
end;
A(ga,n)=0;
%calcolo finale matrice delle uscite
for i=2:n
    %integrazione prima derivata di ordine inferiore a rettangoli
    A(2,i)=A(2,i-1)+A(1,i-1)*dt;
    for j=3:ga
       %loop di integrazione a trapezi per derivate successive
       A(j,i)=A(j,i-1)+0.5*(A(j-1,i)+A(j-1,i-1))*dt;
    end;
    %loops di calcolo derivata maggiore
    for j=1:gb
        A(1,i)=A(1,i)+b(1,j)*F(j,i);
        imp=A(1,i);
    end;
    for j=2:ga
        A(1,i)=A(1,i)-a(1,j)*A(j,i);
    end;
    A(1,i)=A(1,i)/a(1,1);
    if abs(A(1,i))>1/dt %controllo sugli impulsi
       s=sign(A(1,i));
       A(1,i)=s*abs((A(2,i)-A(2,i-1))/(a(1,1)));
       %A(1,i)=s/dt;
    end;
end;
y=A(ga,1:n);