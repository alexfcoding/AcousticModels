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

size = 512;
shift = 512;
kaiserLength = 200;
kaiserOverlap = 191;
spectogramAnglex = 81;
spectogramAngley = 31;

subplot(3,3,1);
spectrogram(audioin1(1:512),kaiser(kaiserLength,15),kaiserOverlap,1:5:10000,FFS,'yaxis')
colormap hsv
view(spectogramAnglex,spectogramAngley);
title('а1) G(t)');
xlabel('t, мс') 
ylabel('w, к√ц') 
zlabel('A, дЅ') 

subplot(3,3,4);
spectrogram(audioin2(1:size),kaiser(kaiserLength,15),kaiserOverlap,1:5:10000,FFS,'yaxis')
colormap hsv
view(spectogramAnglex,spectogramAngley);
title('б1) V(t)');
xlabel('t, мс') 
ylabel('w, к√ц') 
zlabel('A, дЅ') 

subplot(3,3,7);
spectrogram(audioin3(1:size),kaiser(kaiserLength,15),kaiserOverlap,1:5:10000,FFS,'yaxis')
colormap hsv
view(spectogramAnglex,spectogramAngley);
title('в1) Y(t)');
xlabel('t, мс') 
ylabel('w, к√ц') 
zlabel('A, дЅ') 

size = size + shift;

subplot(3,3,2);
spectrogram(audioin1(size:size+shift),kaiser(kaiserLength,15),kaiserOverlap,1:5:10000,FFS,'yaxis')
colormap hsv
view(spectogramAnglex,spectogramAngley);
title('а2) G(t)');
xlabel('t, мс') 
ylabel('w, к√ц') 
zlabel('A, дЅ') 

subplot(3,3,5);
spectrogram(audioin2(size:size+shift),kaiser(kaiserLength,15),kaiserOverlap,1:5:10000,FFS,'yaxis')
colormap hsv
view(spectogramAnglex,spectogramAngley);
title('б2) V(t))');
xlabel('t, мс') 
ylabel('w, к√ц') 
zlabel('A, дЅ') 

subplot(3,3,8);
spectrogram(audioin3(size:size+shift),kaiser(kaiserLength,15),kaiserOverlap,1:5:10000,FFS,'yaxis')
colormap hsv
view(spectogramAnglex,spectogramAngley);
title('в2) Y(t)');
xlabel('t, мс') 
ylabel('w, к√ц') 
zlabel('A, дЅ') 

size = size + shift;

subplot(3,3,3);
spectrogram(audioin1(size:size+shift),kaiser(kaiserLength,15),kaiserOverlap,1:5:10000,FFS,'yaxis')
colormap hsv
view(spectogramAnglex,spectogramAngley);
title('а3) G(t)');
xlabel('t, мс') 
ylabel('w, к√ц') 
zlabel('A, дЅ') 

subplot(3,3,6);
spectrogram(audioin2(size:size+shift),kaiser(kaiserLength,15),kaiserOverlap,1:5:10000,FFS,'yaxis')
colormap hsv
view(spectogramAnglex,spectogramAngley);
title('б3) V(t)');
xlabel('t, мс') 
ylabel('w, к√ц') 
zlabel('A, дЅ') 

subplot(3,3,9);
spectrogram(audioin3(size:size+shift),kaiser(kaiserLength,15),kaiserOverlap,1:5:10000,FFS,'yaxis')
colormap hsv
view(spectogramAnglex,spectogramAngley);
title('в3) Y(t)');
xlabel('t, мс') 
ylabel('w, к√ц') 
zlabel('A, дЅ') 
