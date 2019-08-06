clear all % Clear memory
clc
h = 0.001;
p0 = 7800;
E = 200*10^9;
d = 0.06;
J = pi*d^3*h/8;
L = 2.37; %  Object length
A1 = 0.000005; % High frequency damping coefficient
A2 = 1400; % Low frequency damping coefficient
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
    Time = 1; % Signal duration, s
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
%plot (T,YY); % Drawing signal

audiowrite('CalculatedSignal.wav',ZZ,Fd); %Saving signal to file

% figure
% plot (T,newBuffer); % Drawing signal
% 
% FFTSize = length(YY); % FFT window size
% F=0:Fd/FFTSize:Fd/2-1/FFTSize; % Frequencies
% FftS = fft((ZZ),FFTSize); % FFT amplitudes
% 
% figure
% plot(F, 10*log(abs(FftS(1:length(F / 2))))); %Spectrum drawing
% title('Normal signal spectrum')
% 
% %///////////
% FftS2 = fft((ZZ),FFTSize); % FFT amplitudes
% 
% figure
% plot(F, 10*log(abs(FftS2(1:length(F / 2))))); %Spectrum 2 drawing
% title('Shifted signal spectrum')
% %///////////

%ObjectOnTop loading===============================================================
%figure
audioin = 0;
[audioin,FFS] = audioread('G:\ObjectOnTop.wav');
AUDIO_IN = audioin;
aud = 1:1:length(audioin);
%plot (aud./FFS,audioin);

FFTSize = length(audioin); % FFT window size
F=0:FFS/FFTSize:FFS/2-1/FFTSize; % Frequencies
FftS = fft((audioin),FFTSize); % FFT amplitudes

%figure
%plot(F, 10*log10(abs(FftS(1:length(F / 2))))); %Spectrum drawing
%title('ObjectOnTop signal spectrum')
%WithoutObjectOnTop loading===============================================================
%figure

[audioin,FFS] = audioread('G:\WithoutObjectOnTop.wav');
AUDIO_IN = audioin;
aud = 1:1:length(audioin);
%plot (aud./FFS,audioin)

FFTSize = length(audioin); % FFT window size
F=0:FFS/FFTSize:FFS/2-1/FFTSize; % Frequencies
FftS2 = fft((audioin),FFTSize); % FFT amplitudes

%figure
%plot(F, 10*log10(abs(FftS2(1:length(F / 2))))); %Spectrum drawing
%title('WithoutObjectOnTop signal spectrum')

%FftS2(1:5000) = FftS2(1:5000);

% figure
% plot(F, 10*log(abs(FftS2(1:length(F / 2))))); %Spectrum drawing
% title('WithoutObjectOnTop filter')

%DIFF===============================================================
FF=0:FFS/FFTSize:FFS-1/FFTSize; % Frequencies
DIFF = FftS - FftS2;
c1 = smooth(FF,(FftS),0.00001,'loess');
c2 = smooth(FF,(FftS2),0.00001,'loess');
%c1 = abs(FftS);
%c2 = abs(FftS2);
c3 = c1-c2;

figure

plot(FF,c1);

hold on

plot(FF,c2);

plot(FF,c3);
title('Smooth c3');

%DIFF = DIFF .* 10;
%c1 = 10*log10(abs(FftS(1:length(F / 2))));
%c2 = 10*log10(abs(FftS2(1:length(F / 2))));
%figure
%plot(F,DIFF(1:length(F / 2)));

audioin = 0;
[audioin,FFS] = audioread('G:\CalculatedSignal3.wav');
AUDIO_IN = audioin;
aud = 1:1:length(audioin);
FftS3 = fft((audioin),FFTSize); % FFT amplitudes
M = importdata('G:\diffMatlab.txt')
M=M*1;
Mr = 10.^(M./10);
k=1;
buf = 0;

%FftS3(1:16384) = FftS3(1:16384).*Mr(1:16384);
%FftS3 = FftS3 .* DIFF ;
%FftS3 = DIFF ;
%FftS3(16385:32768) = FftS3(16385:32768) .* M ;

plot(FF,abs(FftS3));

FftS3 = FftS3 + c3 ;

plot(FF,abs(FftS3));

hold off

legend('c1','c2','c3','FftS3_stock', 'FftS3');
title('Final spec')
%reverseM = flip(Mr);
%FftS3(16385:32768) = FftS3(16385:32768).*reverseM(1:16384);

%yy1 = smooth(F,curve(1:length(F / 2)),0.05,'loess');
%smoothM = smooth(M,curve(1:length(F / 2)),0.05,'loess');
%figure
%plot(F,M);
%title('M')
%figure
ifftSignal = ifft(FftS3,32768);
%plot(T,ifftSignal);% ����
audiowrite('CalculatedDiffSignal.wav',ifftSignal,FFS); %Saving signal to file
%End DIFF===============================================================


% figure
% plot(T,ifft(FftS,length(T)));% ����

ready