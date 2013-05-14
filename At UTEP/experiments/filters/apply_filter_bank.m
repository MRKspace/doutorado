function app_fb = apply_filter_bank(x, filter_bank)

%
% afb = apply_filter_bank(x, filter_bank)
%
% APPLY_FILTER_BANK recebe um banco de filtros FILTER_BANK e um 
% sinal no domínio do tempo X, e retorna amostras do sinal X
% FILTRADAS de acordo com o banco de filtros.
%
% Se X for um vetor de células, a primeira célula de X
% será filtrada pelo filtro na primeira célula de FILTER_BANK,
% e assim sucessivamente. Note que isto exige que X e FILTER_BANK 
% possuam o mesmo número de células.
%
% Exemplo de uso,
%
%	x = rand(1000);
%
%	h0 = [1 1];
%	h1 = [1 -1];
%	filter_bank = iterate_filters(h0, h1, 5);
%
%	app_fb = apply_filter_bank(x, filter_bank);
%
% Veja também iterate_filters synthesis_filter_bank analysis_filter_bank apply_downsample apply_upsample 
%
% Dez 07 2011
% Cristiano, Ema e Diogo
	
if(iscell(x))
	for i = 1 : length(filter_bank)
		app_fb{i} = convnz(filter_bank{i},x{i});
	end
else
	for i = 1 : length(filter_bank)
		app_fb{i} = convnz(filter_bank{i},x);
	end
end


