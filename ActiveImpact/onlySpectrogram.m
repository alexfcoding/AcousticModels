lengthSig = 3000;
figure
subplot(3,1,1);
audioin1 = 0;
[audioin1,FFS] = audioread('Only solenoid22.wav');
aud = 1:1:length(audioin1);
plot(aud(1:lengthSig), audioin1(1:lengthSig));
xlabel('Номер отсчета') 
ylabel('Амплитуда') 
zlabel('Амплитуда, дБ') 

subplot(3,1,2);
audioin2 = 0;
[audioin2,FFS] = audioread('Solenoid with welding22.wav');
aud = 1:1:length(audioin2);
plot(aud(1:lengthSig), audioin2(1:lengthSig));
xlabel('Номер отсчета') 
ylabel('Амплитуда') 
zlabel('Амплитуда, дБ') 

subplot(3,1,3);
audioin3 = 0;
[audioin3,FFS] = audioread('Solenoid with drilling2222.wav');
aud = 1:1:length(audioin3);
plot(aud(1:lengthSig), audioin3(1:lengthSig));
xlabel('Номер отсчета') 
ylabel('Амплитуда') 
zlabel('Амплитуда, дБ') 

size = 3000;
shift = 512;
kaiserLength = 512;
kaiserOverlap = 501;
spectogramAnglex = -140;
spectogramAngley = 45;

figure
subplot(3,1,1);
spectrogram(audioin1(1:size),kaiser(kaiserLength,15),kaiserOverlap,1:5:20000,FFS,'yaxis')
colormap jet
view(spectogramAnglex,spectogramAngley);
xlabel('Время, мс') 
ylabel('Частота, кГц') 
zlabel('Амплитуда, дБ') 

subplot(3,1,2);
spectrogram(audioin2(1:size),kaiser(kaiserLength,15),kaiserOverlap,1:5:20000,FFS,'yaxis')
%colormap hsv
view(spectogramAnglex,spectogramAngley);
xlabel('Время, мс') 
ylabel('Частота, кГц') 
zlabel('Амплитуда, дБ') 

subplot(3,1,3);
spectrogram(audioin3(1:size),kaiser(kaiserLength,15),kaiserOverlap,1:5:20000,FFS,'yaxis')
%colormap hsv
view(spectogramAnglex,spectogramAngley);
xlabel('Время, мс') 
ylabel('Частота, кГц') 
zlabel('Амплитуда, дБ') 

