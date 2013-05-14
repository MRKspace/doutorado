	clc; clear all; close all;

	load emg_noise;
	
	x = sig(1,:);		
	x = x(1:length(x)/100);

	levels = 5;

	% Test HAAR
	[h0, h1, g0, g1] = wfilters('db2');
	filter_bank_ana = iterate_filters(h0, h1, levels);
	filter_bank_syn = iterate_filters(g0, g1, levels);

	ana = analysis_filter_bank(x,filter_bank_ana);
	ana{1}=0;

	X = wt(x, filter_bank_ana);
	position = length(X)/2;
	X(position:length(X)) = 0;

 	[y, y_no_delay] = synthesis_filter_bank(ana,filter_bank_syn,length(x));


	figure; plot(x);
	a = axis;

	figure;	plot(X);
	hold on;

	band_bar = [min(X) max(X)];
	
	position_band_bar = length(X)/(2^levels);
	
	plot([position_band_bar position_band_bar], band_bar,'r');
	
	for i = 0 : (levels - 1)
		position_band_bar = position_band_bar + length(X)/(2^(levels-i));
		plot([position_band_bar position_band_bar], band_bar,'r');
	end
	
	figure;	plot(y);
	figure;	plot(y_no_delay); 
	axis(a);
	
	error = sum(abs(x-y_no_delay))/length(x)
	erro = x-y_no_delay;
	figure;	plot(erro);

	snr = 20*log10(norm(x)/norm(erro))




