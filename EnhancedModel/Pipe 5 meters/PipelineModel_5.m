h = 0.003;
p0 = 7800;
E = 200*10^9;
d = 0.038;
J = 3.14*d^3*h/8;
L = 5;
A1 = 7;
A2 = 1;
A3 = 1500000.*0.7;
A = 0.038;
%a4 = E.*J./p0./A;
%M = pi*(d/2-h).^2*p0;
M = p0 * pi * d * h;
a4 = E.*J./M;
z = 0;
n = 1;
x1 = L/9.4;
x2 = L/2;

for k = 1:n    
    y = 0;
    y2 = 0;    
    mod = 1:2:100;
    %mod = 1:2:100;
    %Cn = pi/2*(2*mod+1); 
    %w = E.*J/M/L.^4.*Cn.^4;
    fd = 44100; 
    time = 1;
    Tb = 0.00004;
    t = 0.00004;
    delta = (1./2.*(A1.*mod.^1.*pi.^4./(L.^4)+A2));
    w =  sqrt(A3+a4.*mod.^4.*pi.^4./(L.^4));   
    Oi = sqrt(w.^2 - delta.^2);

    % Signal loop -------------------------------------------------------------------------
    for m = 1:1:(time*fd-1) 
        y = pi./(M.*L.*Tb).*sum( (-1).^((mod-1)./2).*exp(-delta.*t).*sin(mod.*pi.*x1./L)./ ...
        ( (w.^2-pi.^2./(Tb.^2)).^2 + 4.*pi.^2.*delta.^2./(Tb.^2))...
        .*((2.*exp(delta.*Tb).*delta.*pi./Tb.*cos(Oi.*Tb) - pi.*exp(delta.*Tb)./Tb./Oi.*...
        (2.*delta.^2-w.^2+pi.^2./Tb./Tb).*sin(Oi.*Tb)+2.*pi.*delta./Tb).*cos(Oi.*t) + ...
        (pi.*exp(delta.*Tb)./Tb./Oi.*(2.*delta.^2-w.^2+pi.^2./Tb./Tb).*cos(Oi.*Tb) + ...
        2.*exp(delta.*Tb).*delta.*pi./Tb.*sin(Oi.*Tb)+pi./Tb./Oi.*(2.*delta.^2-w.^2+pi.^2./Tb./Tb)).* ...
        sin(Oi.*t)));
        t = t + 1/fd; 
        y2 = [y2 y];
    end
    % ------------------------------------------------------------------------------------------------
    
    t = 0:1/fd:time-1/fd;     
    y3 = y2./max(y2).*0.9;
    z = [z y3];
    plot(t,y2);
end

t = 0:1/fd:time*n-1/fd;
plot (t,y2); 
xlabel('Time, secs');
ylabel('Amplitude');
figure
spectrogram(y3,kaiser(256,15),203,1024,22050,'yaxis')
colormap jet    
view(113,64)
colorbar

audiowrite('WaveModel_5.wav',z,fd);
