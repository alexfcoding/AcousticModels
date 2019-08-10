clear

lengthSig = 500;

figure
subplot(3,1,1);
audioin1 = 0;
[audioin1,FFS] = audioread('CutTo5000\ModelNormalGained.wav');
aud = 1:1:length(audioin1);
plot(aud(1:lengthSig), audioin1(1:lengthSig));

subplot(3,1,2);
audioin2 = 0;
[audioin2,FFS] = audioread('CutTo5000\RealWithObjectGainedCut2800.wav');
aud = 1:1:length(audioin2);
plot(aud(1:lengthSig), audioin2(1:lengthSig));

subplot(3,1,3);
audioin3 = 0;
[audioin3,FFS] = audioread('CutTo5000\ModeledWithObjectGained.wav');
aud = 1:1:length(audioin3);
plot(aud(1:lengthSig), audioin3(1:lengthSig));

Rx1 = 0;
Rx2=0;
Rxy1=0;
Rxy2=0;
Left = 1;
Right = 50;

for lengthCorr = 1 : 50
    Rx1 = corr(audioin1(Left:Right), audioin2(Left:Right));
    Rx2 = corr(audioin1(Left:Right), audioin3(Left:Right));
    Rxy1 = [Rxy1 Rx1];
    Rxy2 = [Rxy2 Rx2];
    Left = Left + 50;
    Right = Right + 50;
end

figure
plot (Rxy1);
figure
plot (Rxy2);

size = 512;
shift = 512;
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

for start = 1:3
    for k = start:3:start+6
        subplot(3,3,k);
        spectrogram(array((1:size),i),kaiser(kaiserLength,15),kaiserOverlap,1:1:5000,FFS,'yaxis')
        colormap hsv
        view(spectogramAnglex,spectogramAngley);
        i = i + 1;
    end
size = size + shift;
i=1;
end



