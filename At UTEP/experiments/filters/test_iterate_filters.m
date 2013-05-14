	% test_iterate_filter
	clear all; close all; clc

	h0 = [1 1 1 1];
	h1 = [1 -1 1 -1];

	h0u = upsample(h0, 2);
	h0uu = upsample(h0u, 2);
	h0uuu = upsample(h0uu, 2);

	h1u = upsample(h1, 2);
	h1uu = upsample(h1u, 2);
	h1uuu = upsample(h1uu, 2);

	h0000 = convnz(convnz(convnz(h0, h0u), h0uu), h0uuu);
	h0001 = convnz(convnz(convnz(h0, h0u), h0uu), h1uuu);
	h001 = convnz(convnz(h0, h0u), h1uu);
	h01 = convnz(h0, h1u);

	filter_bank = iterate_filters(h0, h1, 4);

	% Print

	fprintf('\n\t Test_ITERATE_FILTERS\n');

	if (isequal(filter_bank{1},h1))
		fprintf('\n\tfilter_bank{1} é igual a h1');
	else 
		fprintf('\n\tAlgo está errado com filter_bank{1}');
	end


	if (isequal(filter_bank{2},h01))
		fprintf('\n\tfilter_bank{2} é igual a h01');
	else 
		fprintf('\n\tAlgo está errado com filter_bank{2}');
	end

	if (isequal(filter_bank{3},h001))
		fprintf('\n\tfilter_bank{3} é igual a h001');
	else 
		fprintf('\n\tAlgo está errado com filter_bank{3}');
	end

	if (isequal(filter_bank{4},h0001))
		fprintf('\n\tfilter_bank{4} é igual a h0001');
	else 
		fprintf('\n\tAlgo está errado com filter_bank{4}');
	end

	if (isequal(filter_bank{5},h0000))
		fprintf('\n\tfilter_bank{5} é igual a h0000');
	else 
		fprintf('\n\tAlgo está errado com filter_bank{5}');
	end
	
	fprintf('\n\n');


