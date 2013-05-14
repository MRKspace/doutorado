function awl = wt(x,filter_bank)

%
% awl = wt(x,filter_bank)
%
% WT, ou Wavelets Transform, recebe um banco de filtros FILTER_BANK e um 
% sinal no domínio do tempo X, e retorna a transformada em wavelets 
% de X utilizando FILTER_BANK.
%
% Exemplo de uso,
%
%	x = rand(1000);
%
%	h0 = [1 1];
%	h1 = [1 -1];
%	filter_bank = iterate_filters(h0, h1, 5);
%
%	X = wt(x,filter_bank);
%
% Veja também analysis_filter_bank synthesis_filter_bank apply_filter_bank iterate_filters wfilters
%
% Dez 07 2011
% Cristiano, Ema e Diogo

	y = apply_filter_bank(x, filter_bank);
	ana_fb = apply_downsample(y);
	ana_fb = invert(ana_fb);
	awl = [];
	for(k=1 : length(ana_fb))
		awl = [awl ana_fb{k}];
	end

function inv = invert(input)

	L = length(input);
	for i = 1 : L
		inv{i} = input{L-i+1};
	end

