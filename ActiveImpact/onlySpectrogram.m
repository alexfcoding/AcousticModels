lengthSig = 500;
figure
subplot(3,1,1);
audioin1 = 0;
[audioin1,FFS] = audioread('Only solenoid.wav');
aud = 1:1:length(audioin1);
plot(aud(1:lengthSig), audioin1(1:lengthSig));

subplot(3,1,2);
audioin2 = 0;
[audioin2,FFS] = audioread('Solenoid with welding.wav');
aud = 1:1:length(audioin2);
plot(aud(1:lengthSig), audioin2(1:lengthSig));

subplot(3,1,3);
audioin3 = 0;
[audioin3,FFS] = audioread('Solenoid with drilling.wav');
aud = 1:1:length(audioin3);
plot(aud(1:lengthSig), audioin3(1:lengthSig));

size = 3800;
shift = 512;
kaiserLength = 256;
kaiserOverlap = 240;
spectogramAnglex = -146;
spectogramAngley = 35;

figure
subplot(3,1,1);
spectrogram(audioin1(1400:size),kaiser(kaiserLength,15),kaiserOverlap,1:5:20000,FFS,'yaxis')
colormap jet
view(spectogramAnglex,spectogramAngley);
title('а1) G(t)');
xlabel('t, мс') 
ylabel('w, к√ц') 
zlabel('A, дЅ') 

subplot(3,1,2);
spectrogram(audioin2(1400:size),kaiser(kaiserLength,15),kaiserOverlap,1:5:20000,FFS,'yaxis')
%colormap hsv
view(spectogramAnglex,spectogramAngley);
title('б1) V(t)');
xlabel('t, мс') 
ylabel('w, к√ц') 
zlabel('A, дЅ') 

subplot(3,1,3);
spectrogram(audioin3(1400:size),kaiser(kaiserLength,15),kaiserOverlap,1:5:20000,FFS,'yaxis')
%colormap hsv
view(spectogramAnglex,spectogramAngley);
title('в1) Y(t)');
xlabel('t, мс') 
ylabel('w, к√ц') 
zlabel('A, дЅ') 

