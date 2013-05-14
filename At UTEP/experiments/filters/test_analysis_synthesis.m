	clc; clear all; close all;

	x = (1:10)

	% Test HAAR
	[h0, h1, g0, g1] = wfilters('haar');
	filter_bank_ana = iterate_filters(h0, h1, 5);
	filter_bank_syn = iterate_filters(g0, g1, 5);

	ana = analysis_filter_bank(x,filter_bank_ana);
	[syn, syn_HAAR] = synthesis_filter_bank(ana,filter_bank_syn);

	syn_HAAR

	% Test DAUBECHIES
	[h0, h1] = wfilters('db2', 'd');
	[g0, g1] = wfilters('db2', 'r');
	filter_bank_ana = iterate_filters(h0, h1, 5);
	filter_bank_syn = iterate_filters(g0, g1, 5);

	ana = analysis_filter_bank(x,filter_bank_ana);
	[syn, syn_DAUBECHIES] = synthesis_filter_bank(ana,filter_bank_syn);

	syn_DAUBECHIES

	% Teste COIFLETS
	[h0, h1, g0, g1] = wfilters('coif5');
	filter_bank_ana = iterate_filters(h0, h1, 5);
	filter_bank_syn = iterate_filters(g0, g1, 5);

	ana = analysis_filter_bank(x,filter_bank_ana);
	[syn, syn_COIFLETS] = synthesis_filter_bank(ana,filter_bank_syn);

	syn_COIFLETS
	
	% Teste BIORTOGHONAL
	[h0, h1, g0, g1] = wfilters('bior3.1');
	filter_bank_ana = iterate_filters(h0, h1, 2);
	filter_bank_syn = iterate_filters(g0, g1, 2);

	ana = analysis_filter_bank(x,filter_bank_ana);
	[syn, syn_BIORTOGHONAL] = synthesis_filter_bank(ana,filter_bank_syn);

	syn_BIORTOGHONAL
	
