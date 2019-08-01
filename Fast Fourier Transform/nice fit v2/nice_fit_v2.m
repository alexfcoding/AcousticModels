clear all% ������� ������
clc
h = 0.005;
p0 = 7800;
E = 200*10^9;
d = 0.07;
J = pi*d^3*h/8;
L = 4 ; % ����� ������������
A1 = 0.03; % ����������  ��
A2 = 200; % ���������� ��� �������
A3 = 0;
A = 0.04; % ������� ������������
%a4 = E.*J./p0./A;
%M = pi*(d/2-h).^2*p0;
M = p0 * pi * d * h  * 1; % ����� ������������
M = pi/4*(d^2-(d-h)^2)*L*p0 / 6; 
a4 = E.*J./M;
ZZ = 0;
N = 1; % ����� ���������
x1 = L/1.28
x2 = L/1;

for I = 1:N
    VV = 1; % �������� �����
    Y = 0; % ������� ����� ������������
    YY = 0;
    t = 0; % ������������������ ������� �������
    i = 1:2:500; % ����� ����
    nnnn = 1:2:500; % ����� ���
    Cn = pi/2 * (nnnn + 1); 
    %W = E.*J/M/L.^4.*Cn.^4; % ����������� �������
    Fd = 44100   ; % ������� �������������, ��
    Time = 1; % ������������ �������, �
    Tb = 0.00004;
    t = 0.000022;

    delta = sqrt(1./2.*(A1.*i.^4.*pi.^4./(L.^4)+A2));

    %W = sqrt(A3+a4.*i.^4.*pi.^4./(L.^4)); % 
    %W = A3+Cn.^2.*pi.^2./(L.^2) * sqrt(E*J/M);
    W = A3 + sqrt(E.*J / M / (L.^4) .* Cn.^4);
    W_MAX = max(W);

    Oi = sqrt(W.^2 - delta.^2);

    % ���� ���������� �������-------------------------------------------------------------------------
    for HHH = 1:1:(Time*Fd-1) 
        Y =sum( (-1).^((i-1)./2).*exp(-delta.*t).*sin(i.*pi.*x1./L)./ ...
        ( (W.^2-pi.^2./(Tb.^2)).^2 + 4.*pi.^2.*delta.^2./(Tb.^2))...
        .*((2.*exp(delta.*Tb).*delta.*pi./Tb.*cos(Oi.*Tb) - pi.*exp(delta.*Tb)./Tb./Oi.*...
        (2.*delta.^2-W.^2+pi.^2./Tb./Tb).*sin(Oi.*Tb)+2.*pi.*delta./Tb).*cos(Oi.*t) + ...
        (pi.*exp(delta.*Tb)./Tb./Oi.*(2.*delta.^2-W.^2+pi.^2./Tb./Tb).*cos(Oi.*Tb) + ...
        2.*exp(delta.*Tb).*delta.*pi./Tb.*sin(Oi.*Tb)+pi./Tb./Oi.*(2.*delta.^2-W.^2+pi.^2./Tb./Tb)).* ...
        sin(Oi.*t)));
        t = t + 1/Fd; % ������� �������
        YY = [YY Y]; % ������������
        %pi./(M.*L.*Tb).*
    end
    % ------------------------------------------------------------------------------------------------

    length_YY = length(YY);
    t = 0:1/Fd:Time-1/Fd; % ������� ������� ��� ���������� �������
    length_t = length(t);
    YYYY = YY./max(YY).* 0.7; % ������������ ���������
    ZZ = [ZZ YYYY];
    plot (t,YY); % ������ �� �������
    GGG = 0:1/Fd:Time - 1/Fd;
end

t = 0:1/Fd:Time.*N-1/Fd;; % ������� ������� ��� ���������� �������
%plot (t,YY); % ������ �� �������
audiowrite('CalculatedSignal.wav',ZZ,Fd);

% ------------------------------------------------------------------------------------------------

FFTSize = length(YY); %length(YY); - ������ ���� ���
F=0:Fd/FFTSize:Fd/2-1/FFTSize; % ������ ������ ������������ ������� �����
FftS = fft((ZZ),FFTSize); % ��������� �������������� ����� �������

%figure
%plot(F, 10*log(abs(FftS(1:length(F / 2)))));

%figure
%plot(t,ifft(FftS,length(t)));% ����

f