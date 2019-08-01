clear all% Очистка памяти
clc
L=4; % длина стержня
YY = 0;
x2 = 0;
YYYY = 0;
abir = 2;
progress = 0;
numm  = 1;
for N = 1:numm % N - число импульсов для генерации
    progress = progress + 1;
    x1 = L/7.4; 
    abir = abir + 0.5;
    x2 = L - L/2000;
    h = 0.002;
    E = 200*10^9;
    d = 0.05;
    J=3.14*d^3*h/8;
    p0 = 7800;
    M = pi/4*(d^2-(d-h)^2)*L*p0 / 6 ; % масса стержня
    
    %M = M + N;
    
    VV = 1; % скорость удара
    Y = 0; % функция суммы произведения
    t = 0; % дискретизированные отсчеты времени
    iii = 1:1:500; % номер моды
    nnnn = 1:1:500; % число мод
    Cn = pi/2*(2*nnnn+1); 
    %Cn = pi*nnnn; % для свободно опертого стержня
    %Cn = pi*(nnnn+0.1); 
    W = sqrt(E.*J/M/(L.^4).*Cn.^4); % резонансные частоты
    W_MAX = max(W);
    Fd = 44100; % частота дискретизации, Гц
    Time = 0.5; % длительность сигнала, с
    hhh=1;
    damping = 0.0013;

    % цикл построения сигнала -------------------------------------------------------------
    for HHH = 1:1:(Time*Fd-1) 
        Y = sum(2.*VV./L.*(1./W.*sin(iii.*pi.*x2/L).*sin(iii.*pi.*x1./L).*sin(W.*t)).* ...
        exp(-t.*(W.*damping+1.1)) );
        t = t + 1/Fd; % отсчеты времени
        YY = [YY Y]; % конкатенация
    end
    % -------------------------------------------------------------------------------------

    %length_YY = length(YY);
    %t = 0:1/Fd:Time-1/Fd; % отсчеты времени для построения графика
    %length_t = length(t);
    %LENGTH_YYYY = length(YY);
    %plot (t,YY); % сигнал от времени
    %progress/numm*100
    %L = L + 2.5;
    %YY = YY./max(YY);
    
    Y=0;
    %YY=0;
    t=0;
    N
    M
end
FileName=[num2str(N),'.wav'];
%audiowrite(FileName,YY,Fd);
YY = YY./max(YY);
 audiowrite('ImpulseSeries.wav',YY,Fd);   
%xlabel('Длительность, с') ;
%ylabel('Амплитуда') ;
%YY = YY./max(YY);


f