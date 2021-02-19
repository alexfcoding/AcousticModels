L = 5;
y2 = 0;
x2 = 0;
n = 1;

for k = 1:n    
    x1 = L/7.4;     
    x2 = L - L/2000; 
    h = 0.002;
    E = 200*10^9;
    d = 0.07;
    J = 3.14*d^3*h/8;
    p0 = 7800;
    M = pi/4*(d^2-(d-h)^2)*L*p0 ./1.4; 
    V = 1; 
    y = 0; 
    t = 0;     
    mod = 1:1:500; 
    Cn = pi/2*(2*mod+1); 
    %Cn = pi*mod;
    %Cn = pi*(mod+0.1); 
    w = sqrt(E.*J/M/(L.^4).*Cn.^4);    
    fd = 44100;
    time = 3;    
    damping = 0.0013;

    % Signal loop -------------------------------------------------------------
    for m = 1:1:(time*fd-1) 
        y = sum(2.*V./L.*(1./w.*sin(mod.*pi.*x2/L).*sin(mod.*pi.*x1./L).*sin(w.*t)).* ...
        exp(-t.*(w.*damping+1.1)) );
        t = t + 1/fd; 
        y2 = [y2 y];
    end
    % -------------------------------------------------------------------------------------
    
    t = 0:1/fd:time-1/fd; 
    plot (t,y2); 
    xlabel('Time, secs');
    ylabel('Amplitude');
    figure
    spectrogram(y2,kaiser(256,15),203,1024,22050,'yaxis')
    colormap jet    
    view(118,72)
    colorbar    
    L = L + 2.5;
end

y2 = y2./max(y2);
audiowrite('WaveModelSimple_5.wav',y2,fd);
