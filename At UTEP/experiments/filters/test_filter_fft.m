	clear all; close all; clc;
	load emg_noise;

	Fs = 1000;                    % Sampling frequency
	T = 1/Fs;                     % Sample time
	L = length(sig);              % Length of signal
	t = (0:L-1)*T;                % Time vector
	samples = 800;		      % Number of samples on plot
	noises = 17;		      % Number of noise componetes to remove
	ordem = 20;
	freq = 60;
	freq_low = 60;
	freq_high = 120;

	x = sig(1,:);
	X = fft(x);
 

	% Apply lowpass
	low = filter_fft(x, Fs, 2*freq, 'low');
	LOW = fft(low);

	% Apply highpass
	high = filter_fft(x, Fs, freq, 'high');
	HIGH = fft(high);

	% Apply notch
	notch = filter_fft(x, Fs, freq, 'notch');
	NOTCH = fft(notch);

	% Apply bandpass
	bandpass = filter_fft(x, Fs, [freq_low freq_high], 'bandpass');
	BANDPASS = fft(bandpass);
	
	% Apply band_reject
	reject = filter_fft(x, Fs, [freq_low freq_high], 'reject');
	REJECT = fft(reject);
	

	% PLOT ALL!!
	figure; title('Filter FFT');	
	linhas = 5;
	colunas = 2;

	% Original signal
	subplot(linhas,colunas,1);
	plot(Fs*t(1:samples),x(1:samples))
	title('ECG Signal CH 1 with Noise')
	xlabel('time (ms)')
	ylabel('Amplitude')

	% Original signal on freq domain
	subplot(linhas,colunas,2);
	X = fftshift(X);
	plot(abs(X)) 
	title('Amplitude Spectrum of x(t)')
	xlabel('Frequency (Hz)')
	ylabel('|X(f)|')

	% Lowpass signal
	subplot(linhas,colunas,3);
	plot(Fs*t(1:samples),low(1:samples))
	title('ECG Signal CH 1 LOWPASS')
	xlabel('time (ms)')
	ylabel('Amplitude')

	% Lowpass signal on freq domain
	subplot(linhas,colunas,4);
	LOW = fftshift(LOW);
	plot(abs(LOW)) 
	title('Amplitude Spectrum of low(t)')
	xlabel('Frequency (Hz)')
	ylabel('|LOW(f)|')

	% Highpass signal
	subplot(linhas,colunas,5);
	plot(Fs*t(1:samples),high(1:samples))
	title('ECG Signal CH 1 HIGHPASS')
	xlabel('time (ms)')
	ylabel('Amplitude')

	% Highpass signal on freq domain
	subplot(linhas,colunas,6);
	HIGH = fftshift(HIGH);
	plot(abs(HIGH)) 
	title('Amplitude Spectrum of high(t)')
	xlabel('Frequency (Hz)')
	ylabel('|HIGH(f)|')

	% Bandpass signal
	subplot(linhas,colunas,7);
	plot(Fs*t(1:samples),bandpass(1:samples))
	title('ECG Signal CH 1 BANDPASS')
	xlabel('time (ms)')
	ylabel('Amplitude')
	axis([0 800 -500 500]);

	% Bandpass signal on freq domain
	subplot(linhas,colunas,8);
	BANDPASS = fftshift(BANDPASS);
	plot(abs(BANDPASS)) 
	title('Amplitude Spectrum of bandpass(t)')
	xlabel('Frequency (Hz)')
	ylabel('|BANDPASS(f)|')

	% Reject signal
	subplot(linhas,colunas,9);
	plot(Fs*t(1:samples),reject(1:samples))
	title('ECG Signal CH 1 REJECT')
	xlabel('time (ms)')
	ylabel('Amplitude')

	% Reject signal on freq domain
	subplot(linhas,colunas,10);
	REJECT = fftshift(REJECT);
	plot(abs(REJECT)) 
	title('Amplitude Spectrum of reject(t)')
	xlabel('Frequency (Hz)')
	ylabel('|REJECT(f)|')

