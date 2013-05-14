function [sfb, sfb_no_delay] = synthesis_filter_bank(x, filter_bank, N)

%
% sfb = synthesis_filter_bank(x,filter_bank)
%
% SYNTHESIS_FILTER_BANK recebe um banco de filtros FILTER_BANK 
% e componentes wavelet de um sinal no domínio do tempo X,
% e retorna duas versões do sinal reconstruído utilizando o banco de filtros:
% uma com atraso, SFB;
% e uma com tratamento para atraso, visando que este sinal seja o mais parecido
% possível com o sinal original, SFB_NO_DELAY.
%
% São utilizadas as funções apply_filter_bank()
% e de apply_upsample(), além de lógica para tratar o atraso.
%
% Exemplo de uso,
%
%	x = rand(10);
%
%	[h0, h1, g0, g1] = wfilters('haar');
%	filter_bank_ana = iterate_filters(h0, h1, 3);
%	filter_bank_syn = iterate_filters(g0, g1, 3);
%
%	ana = analysis_filter_bank(x,filter_bank_ana);
%	[syn, syn_no_delay] = synthesis_filter_bank(ana,filter_bank_syn);
%
%
% Veja também apply_filter_bank apply_downsample synthesis_filter_bank iterate_filters wfilters
%
% Dez 07 2011
% Cristiano, Ema

	y = apply_upsample(x);
	y = apply_filter_bank(y, filter_bank);	
	
	% L = max[ length{filter_bank} ] que é o atraso total introduzido pelo apply_filter_bank
	L = 0;
	for(k = 1:length(filter_bank))
		if(length(filter_bank{k}) > L)
			L = length(filter_bank{k});
		end
	end


	sfb = 0;
	for(k = 1:length(y))
		y_ = [zeros(1, L - length(filter_bank{k})) y{k}];
		if(length(y_) < length(sfb))
			y_ = [y_ zeros(1, length(sfb) - length(y_))]
		else
			sfb = [sfb zeros(1, length(y_) - length(sfb))];
		end
		sfb = sfb + y_;
	end

	sfb_no_delay = sfb(L:length(sfb));		% remove zeros a esquerda
	
	if (nargin == 3)
		sfb_no_delay = sfb_no_delay(1:N);	% remove zeros a direita
	end	
	
	
	
	
	
	
	
