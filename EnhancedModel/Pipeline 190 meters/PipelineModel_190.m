clear all
clc
h = 0.02; 
p0 = 7800; 
p  = 1000;
E = 200*10^9;
d = 0.4; 
J = 3.14*d^3*h/8;
L = 800;
A1 = 0.05;
A2 = 50;
A3 = 120000000;
A = 0.038; 
M = p0 * pi * d * h + p * pi ./4 * d.^2; 
a4 = E.*J./M;
ZZ = 0;
N = 1;
x1 = L/4;
x2 = 0;

for I = 1:N
    VV = 1; 
    Y = 0; 
    YY = 0;
    t = 0; 
    i = 1:2:4000; 
    nnnn = 1:2:4000; 
    Cn = pi/2 * (2 * nnnn+1); 
    %W = E.*J/M/L.^4.*Cn.^4;
    Fd = 44100;
    Time = 0.5;
    Tb = 0.00004;
    t = 0.00004;

    delta = (1./2.*(A1.*i.^1.*pi.^4./(L.^4)+A2));

    W = sqrt(A3+a4.*i.^4.*pi.^4./(L.^4)); % 

    W_MAX = max(W);

    Oi = sqrt(W.^2 - delta.^2);

    % цикл построения сигнала-------------------------------------------------------------------------
    for HHH = 1:1:(Time*Fd-1) 
        Y = pi./(M.*L.*Tb).*sum( (-1).^((i-1)./2).*exp(-delta.*t).*sin(i.*pi.*x1./L)./ ...
        ( (W.^2-pi.^2./(Tb.^2)).^2 + 4.*pi.^2.*delta.^2./(Tb.^2))...
        .*((2.*exp(delta.*Tb).*delta.*pi./Tb.*cos(Oi.*Tb) - pi.*exp(delta.*Tb)./Tb./Oi.*...
        (2.*delta.^2-W.^2+pi.^2./Tb./Tb).*sin(Oi.*Tb)+2.*pi.*delta./Tb).*cos(Oi.*t) + ...
        (pi.*exp(delta.*Tb)./Tb./Oi.*(2.*delta.^2-W.^2+pi.^2./Tb./Tb).*cos(Oi.*Tb) + ...
        2.*exp(delta.*Tb).*delta.*pi./Tb.*sin(Oi.*Tb)+pi./Tb./Oi.*(2.*delta.^2-W.^2+pi.^2./Tb./Tb)).* ...
        sin(Oi.*t)));
        t = t + 1/Fd; 
        YY = [YY Y];
    end
    % ------------------------------------------------------------------------------------------------

    length_YY = length(YY);
    t = 0:1/Fd:Time-1/Fd;
    length_t = length(t);
    YYYY = YY./max(YY).*0.9;
    ZZ = [ZZ YYYY];
    plot (t,YY);
    GGG = 0:1/Fd:Time - 1/Fd;
end

t = 0:1/Fd:Time.*N;
t = 0:1/Fd:Time.*N-1/Fd;
plot (t,YY);
xlabel('Time, secs');
ylabel('Amplitude');
figure
spectrogram(YY,kaiser(256,15),203,1024,22050,'yaxis')
colormap jet    
view(113,64)

audiowrite('WaveModel_190.wav',ZZ,Fd);


