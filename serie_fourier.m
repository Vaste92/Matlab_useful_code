function [ak,sdf]=serie_fourier(x,arm,w0,m,t)

%ak sono le ampiezze delle armoniche, sdf è il vettore numerico della
%ricostruita secondo la serie, x è il vettore della funzione in ingresso,
%arm il numero di armoniche da analizzare, w0 la pulsazione della funzione.

[~, n]=size(x);
%t=linspace(0,(2*pi)/w0,n);
%ejw=inline('cos(w0.*arm_n.*t)-1i.*sin(w0.*arm_n.*t)','w0','arm_n','t');
incr=t(1,2)-t(1,1);
%preallocazione
ak(1,1:arm)=0;
sdf(1,1:m)=0;
%calcolo ak, da -arm/2 a +arm/2
parfor i=1:arm
    p=i-arm/2; %trucco per avere l'intervallo di armoniche desiderato
    %ejw_t=feval(ejw,w0,p,t);
    ejw_t=cos(w0.*p.*t)-1i.*sin(w0.*p.*t);
    %loop di integrazione a trapezi
    for j=1:n-1
        prod=x(1,j)*ejw_t(1,j);
        prod1=x(1,j+1)*ejw_t(1,j+1);
        ak(1,i)=ak(1,i)+(prod+prod1)*incr*0.5;
    end;
    ak(1,i)=(w0*ak(1,i))/(2*pi);
end;
t1=linspace(t(1,1),t(1,n),m);
%ricostruzione segnale
for i=1:m
    %loop di somma
    for j=1:arm
        k=j-arm/2; %stesso trucco di prima
        sdf(1,i)=sdf(1,i)+ak(1,j)*(cos(w0*k*t1(1,i))+1i*sin(w0*k*t1(1,i)));
    end;
end;