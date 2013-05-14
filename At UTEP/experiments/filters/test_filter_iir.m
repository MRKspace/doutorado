	clear all; close all; clc;

	load emg_noise;
	x = sig(1,:);
	
	order = 5;
	freq_sampling = 100;
	freq = 12;
	filter_type = 'low';
	filter_class = 'ellip';
	parameters = [0.5 20];

	[y,num,den] = filter_iir(x, freq_sampling, freq, filter_type, order, filter_class, parameters);

	X = fftshift(fft(x));
	Y = fftshift(fft(y));
	
	% PLOT ALL!!
	figure; title('Filter FIR');	
	linhas = 2;
	colunas = 2;
	
	% Original signal	
	subplot(linhas,colunas,1);
	plot(x(1:800));
	title('ECG Signal CH 1 with Noise')
	xlabel('time (ms)')
	ylabel('Amplitude')
	
	% Original signal on freq domain
	subplot(linhas,colunas,2);
	plot(abs(X)) 
	title('Amplitude Spectrum of x(t)')
	xlabel('Frequency (Hz)')
	ylabel('|X(f)|')

	% Lowpass signal
	subplot(linhas,colunas,3);
	plot(y(1:800))
	title('ECG Signal CH 1 LOWPASS')
	xlabel('time (ms)')
	ylabel('Amplitude')

	% Lowpass signal on freq domain
	subplot(linhas,colunas,4);
	plot(abs(Y)) 
	title('Amplitude Spectrum of low(t)')
	xlabel('Frequency (Hz)')
	ylabel('|LOW(f)|')

