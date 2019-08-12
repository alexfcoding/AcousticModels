clear

lengthSig = 500;

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

% Rx1 = 0;
% Rx2=0;
% Rxy1=0;
% Rxy2=0;
% Left = 1;
% Right = 50;
% 
% for lengthCorr = 1 : 50
%     Rx1 = corr(audioin1(Left:Right), audioin2(Left:Right));
%     Rx2 = corr(audioin1(Left:Right), audioin3(Left:Right));
%     Rxy1 = [Rxy1 Rx1];
%     Rxy2 = [Rxy2 Rx2];
%     Left = Left + 50;
%     Right = Right + 50;
% end
% 
% figure
% plot (Rxy1);
% hold on
% plot (Rxy2);
% hold off

kaiserLength = 200;
kaiserOverlap = 191;
spectogramAnglex = 81;
spectogramAngley = 31;

figure

array(1:length(audioin1),1) = audioin1;
array(1:length(audioin1),2) = audioin2;
array(1:length(audioin1),3) = audioin3;

i = 1;
start = 1;

size = 512;
shift = 512;

% for start = 1:3
%     for k = start:3:start+6
%         subplot(3,3,k);
%         spectrogram(array((size:size+shift),i),kaiser(kaiserLength,15),kaiserOverlap,1:10:5000,FFS,'yaxis')
%         colormap hsv
%         view(spectogramAnglex,spectogramAngley);
%         i = i + 1;
%     end
% size = size + shift;
% i=1;
% end

subplot(3,3,1);
spectrogram(audioin1(1:size),kaiser(kaiserLength,15),kaiserOverlap,1:5:10000,FFS,'yaxis')
colormap hsv
view(spectogramAnglex,spectogramAngley);
title('а) G(w)');
xlabel('¬рем€, мс') 
ylabel('„астота, к√ц') 
zlabel('јмплитуда, дЅ') 

subplot(3,3,4);
spectrogram(audioin2(1:size),kaiser(kaiserLength,15),kaiserOverlap,1:5:10000,FFS,'yaxis')
colormap hsv
view(spectogramAnglex,spectogramAngley);
title('б) V(w)');
xlabel('¬рем€, мс') 
ylabel('„астота, к√ц') 
zlabel('јмплитуда, дЅ') 

subplot(3,3,7);
spectrogram(audioin3(1:size),kaiser(kaiserLength,15),kaiserOverlap,1:5:10000,FFS,'yaxis')
colormap hsv
view(spectogramAnglex,spectogramAngley);
title('в) Y(w)');
xlabel('¬рем€, мс') 
ylabel('„астота, к√ц') 
zlabel('јмплитуда, дЅ') 

size = size + shift;

subplot(3,3,2);
spectrogram(audioin1(size:size+shift),kaiser(kaiserLength,15),kaiserOverlap,1:5:10000,FFS,'yaxis')
colormap hsv
view(spectogramAnglex,spectogramAngley);
title('г) G(w)');
xlabel('¬рем€, мс') 
ylabel('„астота, к√ц') 
zlabel('јмплитуда, дЅ') 

subplot(3,3,5);
spectrogram(audioin2(size:size+shift),kaiser(kaiserLength,15),kaiserOverlap,1:5:10000,FFS,'yaxis')
colormap hsv
view(spectogramAnglex,spectogramAngley);
title('д) V(w)');
xlabel('¬рем€, мс') 
ylabel('„астота, к√ц') 
zlabel('јмплитуда, дЅ') 

subplot(3,3,8);
spectrogram(audioin3(size:size+shift),kaiser(kaiserLength,15),kaiserOverlap,1:5:10000,FFS,'yaxis')
colormap hsv
view(spectogramAnglex,spectogramAngley);
title('е) Y(w)');
xlabel('¬рем€, мс') 
ylabel('„астота, к√ц') 
zlabel('јмплитуда, дЅ') 

size = size + shift;

subplot(3,3,3);
spectrogram(audioin1(size:size+shift),kaiser(kaiserLength,15),kaiserOverlap,1:5:10000,FFS,'yaxis')
colormap hsv
view(spectogramAnglex,spectogramAngley);
title('ж) G(w)');
xlabel('¬рем€, мс') 
ylabel('„астота, к√ц') 
zlabel('јмплитуда, дЅ') 

subplot(3,3,6);
spectrogram(audioin2(size:size+shift),kaiser(kaiserLength,15),kaiserOverlap,1:5:10000,FFS,'yaxis')
colormap hsv
view(spectogramAnglex,spectogramAngley);
title('з) V(w)');
xlabel('¬рем€, мс') 
ylabel('„астота, к√ц') 
zlabel('јмплитуда, дЅ') 

subplot(3,3,9);
spectrogram(audioin3(size:size+shift),kaiser(kaiserLength,15),kaiserOverlap,1:5:10000,FFS,'yaxis')
colormap hsv
view(spectogramAnglex,spectogramAngley);
title('и) Y(w)');
xlabel('¬рем€, мс') 
ylabel('„астота, к√ц') 
zlabel('јмплитуда, дЅ') 


% FFTSize = 2048;
% F=0:44100/FFTSize:44100/2-1/FFTSize; % ћассив частот вычисл€емого спектра ‘урье
% fft1 = fft((audioin1),FFTSize); % јмплитуды преобразовани€ ‘урье сигнала
% 
% order = 3;
% framelen = 11;
% lx = 34;
% sgf = sgolayfilt(mag2db(abs(fft1(1:length(F / 2))/32768)),order,framelen);
% 
% figure
% %plot(F, sgf);
% hold on
% %plot(F, mag2db(abs(fft1(1:length(F / 2))/32768)));
% 
% 
% fft2 = fft((audioin2),FFTSize); % јмплитуды преобразовани€ ‘урье сигнала
% sgf2 = sgolayfilt(mag2db(abs(fft2(1:length(F / 2))/32768)),order,framelen);
% plot(F, sgf2);
% %plot(F, mag2db(abs(fft2(1:length(F / 2))/32768)));
% 
% fft3 = fft((audioin3),FFTSize); % јмплитуды преобразовани€ ‘урье сигнала
% sgf3 = sgolayfilt(mag2db(abs(fft3(1:length(F / 2))/32768)),order,framelen);
% plot(F, sgf3);
% 
% hold off


% figure
% spectrogram(audioin1(1:32768),kaiser(kaiserLength,15),kaiserOverlap,1:10:5000,FFS,'yaxis')
% colormap hsv
% view(spectogramAnglex,spectogramAngley);
% 
% figure
% spectrogram(audioin2(1:32768),kaiser(kaiserLength,15),kaiserOverlap,1:10:5000,FFS,'yaxis')
% colormap hsv
% view(spectogramAnglex,spectogramAngley);
% 
% figure
% spectrogram(audioin3(1:32768),kaiser(kaiserLength,15),kaiserOverlap,1:10:5000,FFS,'yaxis')
% colormap hsv
% view(spectogramAnglex,spectogramAngley);



