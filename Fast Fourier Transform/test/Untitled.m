Fs = 16000;                       % sampling frequency
no_samples = 640;                  % no of samples
Freq1 = 1000;                      % Frequency 1 of the signal
Freq2 = 2500;                      % Frequency 2 of the signal
Freq3 = 3500;                      % Frequency 3 of the signal
Amp = 0.1;
t = 1/Fs*((1:no_samples)-1);      % time duration, t = 1/Fs
Input_sig_16k = Amp*sin(2*pi*Freq1*t)+Amp*sin(2*pi*Freq2*t)+Amp*sin(2*pi*Freq3*t);  % Multitone Input Signal 

% Equlizer data
Eq_data_32 =[0.0;0.1347;0.2117;0.2956;0.4146;0.5300;0.5615;0.5195;0.4391;0.3621;0.2816;0.1977;0.1837;0.1172;0.0857;0.0577;0.0;0.0577;0.0857;0.1172;0.1837;0.1977;0.2816;0.3621;0.4391;0.5195;0.5615;0.5300;0.4146;0.2956;0.2117;0.1347];

re_Eq_data_32 = Eq_data_32;  % Equalizer data for real values
im_Eq_data_32 = -(re_Eq_data_32);

window_size = 640;

 for ii = 1:(length(Input_sig_16k)/window_size)-1

  data_range = (((ii-1)*window_size)+1:((ii-1)*window_size)+32);
  data_block = Input_sig_16k(data_range);

  fft_sig = fft(data_block);                 %FFT of the signal

  after_eq_re = real(fft_sig).*re_Eq_data_32';   % Multiply real portion of FFT with Equalizer
  after_eq_im = imag(fft_sig).*im_Eq_data_32';   % Mutliply imaginary portion with Equalizer

  after_eq = after_eq_re + (1i*after_eq_im);

  ifft_sig = ifft(fft_sig);                  %iFFT of the signal

 data_full(data_range) = ifft_sig;            % Output signal

 end

plot(Input_sig_16k,'-og'), grid on;   % plot and compare both the signals
hold on;
plot(data_full,'-xr')
hold off;