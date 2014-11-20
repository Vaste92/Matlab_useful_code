function [mag,phase]=bode_oct(num,den,w)

w_im=w.*1i;
n=polyval(num,w_im);
d=polyval(den,w_im);
Wjw=n./d;
modW=abs(Wjw);
mag=20.*log10(modW);
Re_W=real(Wjw);
Im_W=imag(Wjw);
phase=(atan(Im_W./Re_W).*180)./pi;
for i=1:length(phase)
    if Re_W(i)<0
        if Im_W(i)<0
            phase(i)=phase(i)-180;
        else
            phase(i)=phase(i)+180;
        end;
    end;
end;
end