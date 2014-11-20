function [x_re,x_im]=nyquist_oct(num,den,wmin,wmax)

w=linspace(wmin,wmax,1e5).*1i;
xs=(polyval(num,w))./(polyval(den,w));
x_re=real(xs);
x_im=imag(xs);
plot(x_re,x_im);
set(gcf,'Render','OpenGL');