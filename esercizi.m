clear all;

%numero valutazioni
n=1000000;
%tempo
t=linspace(0,10,n);
dt=t(1,2)-t(1,1);
%funzione u(t)
%u=1/dt;
%u(1,n)=0;
u(1,1:n)=1;
u=[0 u];
%coefficienti
a=[1 1 2 1];
b=[1 0 1];
%cac
y0=[0 0 0];
%risoluzione numerica
[y,A,F]=eq_dif(t,a,b,u,y0);
disp('fine calcolo');
%soluzione analitica
%ya=(1/36).*(30.*t.*exp(-5.*t)+exp(t)-exp(-5.*t));
%ya=0.5.*(exp(t)-exp(-t));

plot(t,y);
set(gcf, 'Renderer','OpenGL'); 