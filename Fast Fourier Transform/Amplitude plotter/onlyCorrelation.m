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
hold on
plot (Rxy2);
hold off