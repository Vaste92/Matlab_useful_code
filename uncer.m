function u_x=uncer(x,alpha,beta,x_fs,digit)

%x è il vettore dei dati, alpha e beta le incertezze (sulla misura e
%rispetto al fondo scala), x_fxs è il fondo scala. Porre digit=1 se
%l'incertezza beta è espressa in digit. Distribuzione uniforme.

if digit==1
    u_x=((alpha./100).*abs(x)+beta)./sqrt(3);
else
    u_x=((alpha./100).*abs(x)+(beta./100).*x_fs)./sqrt(3);
end;