% Read an audio waveform
[d,sr] = audioread('For article\ModelNormalGained.wav');
% Plot the spectrogram
%specgram(d(:,1),512,sr);
% Read with resampling, casting to mono, and time limits
spectrogram(d,kaiser(256,15),203,1024,sr,'yaxis')
colormap jet
%shading interp
view(101,60)
colorbar

%SPECTROGRAM2
[d,sr] = audioread('For article\RealWithObjectGained.wav');
figure
spectrogram(d,kaiser(256,15),203,1024,sr,'yaxis')
colormap jet
%shading interp
view(101,60)
colorbar

%SPECTROGRAM3
[d,sr] = audioread('For article\ModeledWithObjectGained.wav');
figure
spectrogram(d,kaiser(256,15),203,1024,sr,'yaxis')
colormap jet
%shading interp
view(101,60)
%h = histogram(d,'Normalization','probability')  % ѕодсчет частот, признака дл€ 11- и интервалов
%h.NumBins