function filter_bank = iterate_filters(h0, h1, levels)

%
% filter_bank = iterate_filters(h0, h1, levels)
%
% ITERATE_FILTERS recebe um par de filtros H0 e H1 e um nível LEVEL
% e retorna uma lista de banco de filtros com LEVEL + 1 elementos
% Exemplo de uso,
%
%	h0 = [1 1];
%	h1 = [1 -1];
%
%	filter_bank = iterate_filters(h0, h1, 5);
%
% Veja também apply_filter_bank synthesis_filter_bank analysis_filter_bank wfilters
%
% Nov 29 2011
% Diogo, Cristiano

	for i = 1:levels
		filter_bank{i} = iterate_single(iterate_multiple(h0,i-1),h1,i-1);
	end
	
	filter_bank{levels+1} = iterate_multiple(h0,levels);


% Local functions
function i_s = iterate_single(h_sample, h_upsample, iterations)
	if (h_sample == 0)
		i_s = h_upsample;
	else	
		i_s = convnz(h_sample, upsample(h_upsample,2^iterations));
	end
	
	
function i_m = iterate_multiple(h,n)

	if (n < 1)
		i_m = 0;
	else
		i_m = h;
	
		if (n > 1)
			for i = 2 : n
				i_m = iterate_single(h,i_m, 1);
			end
		end
	end

