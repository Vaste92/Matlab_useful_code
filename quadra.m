function yy=quadra(x,y,xx,n,p)

%approssimazione ai minimi quadrati con polinomio di grado n
%p sta per peso!

[j,m]=size(x);
for i=1:m
    for j=1:n+1
        A(i,j)=(sqrt(p(1,i)))*((x(1,i))^(j-1));
    end;
    b(i,1)=(sqrt(p(1,i)))*(y(1,i));
end;
B=A';
A=B*A;
b=B*b;
A=inv(A);
a=A*b;
[N,m]=size(xx);
for i=1:N
    yy(i,1)=0;
    for j=0:n
        yy(i,1)=yy(i,1)+(a(j+1,1))*((xx(i,1))^j);
    end;
end;