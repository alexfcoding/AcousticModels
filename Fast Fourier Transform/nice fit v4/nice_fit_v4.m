clear all % Clear memory
clc
h = 0.001;
p0 = 7800;
E = 200*10^9;
d = 0.06;
J = pi*d^3*h/8;
L = 2.37; %  Object length
A1 = 0.0001; % High frequency damping coefficient
A2 = 40; % Low frequency damping coefficient
A3 = 0; % Rise frequency value
M = pi * (d-h) * p0 * h * 2;
ZZ = 0;
N = 1; % Impulse count
Position = L - 0.28;

for I = 1:N % Select N > 1 if impulse sequence needed
    %x1 = x1 - 0.01;
    VV = 1; % Generator speed
    Y = 0; % Model signal function
    YY = 0; % Concatenation array 
    t = 0; % Discretized time intervals
    i = 9:2:509; % Harmonics number
    Fd = 44100; % Sampling frequency, Hz
    Time = 2; % Signal duration, s
    Tb = 0.00004; % Contact time
    t = 0; % Time interval variable
    
    Cn = pi/2 * (i + 1); % Object fixing equation
    delta = sqrt(1./2.*(A1.*Cn.^4.*pi.^4./(L.^4)+A2)); % Frequency shift
    W = A3 + sqrt(E.*J / M / (L.^4) .* Cn.^4); % Frequency values
    Oi = sqrt(W.^2 - delta.^2); % Frequency shift

    % Signal
    % calculation-------------------------------------------------------------------------------------
    for HHH = 1:1:(Time*Fd-1) 
        Y =sum( (-1).^((i-1)./2).*exp(-delta.*t).*sin(i.*pi.*Position./L)./ ...
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

YYYY = YY./max(YY).* 0.7; % Amplitude normalization
ZZ = [ZZ YYYY];

Y=0;
t=0;
I
end

T = 0:1/Fd:Time-1/Fd;
plot (T,YY); % Drawing signal

audiowrite('CalculatedSignal.wav',ZZ,Fd); %Saving signal to file

FFTSize = length(YY); % FFT window size
F=0:Fd/FFTSize:Fd/2-1/FFTSize; % Frequencies
FftS = fft((ZZ),FFTSize); % FFT amplitudes

figure
plot(F, 10*log(abs(FftS(1:length(F / 2))))); %Spectrum drawing

%figure
%plot(t,ifft(FftS,length(t)));% ����

ready