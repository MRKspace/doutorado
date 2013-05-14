	clear all; close all; clc;

	load emg_noise;

% Parametros comuns aos 3 métodos
	bands = [];		% utiliza as bandas default
	x = sig(1,:);	
	freq_sampling = 201;
	freq = 20;		% automaticamente trocado por BANDS em energy
	filter_type = 'low';	% automaticamente trocado por 'bandpass' em energy

% Parametros FIR
	order_fir = 100; 
	window_type = 'hamming';	

% Parametros IIR
	order_iir = 4;
	filter_class = 'ellip';
	parameters = [0.5 20];

% Filtragem
	low = filter_fft(x, freq_sampling, freq, filter_type);
	
% Testes	
	energy_before = energy('filter_fft', bands, x, freq_sampling, freq, filter_type);
	energy_after = energy('filter_fft', bands, low, freq_sampling, freq, filter_type);
	
	energy_fft = energy('filter_fft', bands, x, freq_sampling, freq, filter_type);
	energy_fir = energy('filter_fir', bands, x, freq_sampling, freq, filter_type, order_fir, window_type);
	energy_iir = energy('filter_iir', bands, x, freq_sampling, freq, filter_type, order_iir, filter_class, parameters);
	
% Print
	
	fprintf('\n\t\t\t\t Test_ENERGY\n\n');

	fprintf('	DELTA		THETA		ALPHA		MU		BETA		GAMMA');
	fprintf('\n');
	
	fprintf('\nBefore\t%d\t%d\t%d\t%d\t%d\t%d', energy_before(:));
	fprintf('\nAfter\t%d\t%d\t%d\t%d\t%d\t%d', energy_after(:));

	fprintf('\n');
	fprintf('\nFFT\t%d\t%d\t%d\t%d\t%d\t%d', energy_fft(:));
	fprintf('\nFIR\t%d\t%d\t%d\t%d\t%d\t%d', energy_fir(:));
	fprintf('\nIIR\t%d\t%d\t%d\t%d\t%d\t%d', energy_iir(:));
	fprintf('\n');
	fprintf('\n');
	
	
