function ana_fb = analysis_filter_bank(x,filter_bank)

%
% afb = analysis_filter_bank(x,filter_bank)
%
% ANALYSIS_FILTER_BANK recebe um banco de filtros FILTER_BANK e um 
% sinal no domínio do tempo X, e retorna amostras do sinal X
% FILTRADAS E DIZIMADAS de acordo com o banco de filtros.
%
% São utilizadas as funções apply_filter_bank()
% seguida de apply_downsample().
%
% Exemplo de uso,
%
%	x = rand(1000);
%
%	h0 = [1 1];
%	h1 = [1 -1];
%	filter_bank = iterate_filters(h0, h1, 5);
%
%	ana_fb = apply_filter_bank(x, filter_bank);
%
% Veja também apply_filter_bank apply_downsample synthesis_filter_bank iterate_filters wfilters
%
% Dez 07 2011
% Cristiano, Ema e Diogo

	y = apply_filter_bank(x, filter_bank);
	ana_fb = apply_downsample(y);
