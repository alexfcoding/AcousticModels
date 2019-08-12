figure
subplot(3,1,1);
audioin1 = 0;
[audioin1,FFS] = audioread('ModelNormalGained.wav');
aud = 1:1:length(audioin1);
plot(aud(1:lengthSig), audioin1(1:lengthSig));

subplot(3,1,2);
audioin2 = 0;
[audioin2,FFS] = audioread('RealWithObjectGained.wav');
aud = 1:1:length(audioin2);
plot(aud(1:lengthSig), audioin2(1:lengthSig));

subplot(3,1,3);
audioin3 = 0;
[audioin3,FFS] = audioread('ModeledWithObjectGained.wav');
aud = 1:1:length(audioin3);
plot(aud(1:lengthSig), audioin3(1:lengthSig));

FFTSize = 2048;
F=0:44100/FFTSize:44100/2-1/FFTSize; % Массив частот вычисляемого спектра Фурье
fft1 = fft((audioin1),FFTSize); % Амплитуды преобразования Фурье сигнала

order = 2;
framelen = 21;
lx = 34;
sgf1 = sgolayfilt(mag2db(abs(fft1(1:length(F / 2))/FFTSize)),order,framelen);

figure
plot(F, sgf1);
hold on
%plot(F, mag2db(abs(fft1(1:length(F / 2))/32768)));

fft2 = fft((audioin2),FFTSize); % Амплитуды преобразования Фурье сигнала
sgf2 = sgolayfilt(mag2db(abs(fft2(1:length(F / 2))/FFTSize)),order,framelen);
plot(F, sgf2);
%plot(F, mag2db(abs(fft2(1:length(F / 2))/32768)));

fft3 = fft((audioin3),FFTSize); % Амплитуды преобразования Фурье сигнала
sgf3 = sgolayfilt(mag2db(abs(fft3(1:length(F / 2))/FFTSize)),order,framelen);
plot(F, sgf3);